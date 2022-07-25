local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.o.runtimepath = install_path .. ',' .. vim.o.runtimepath
    packer_bootstrap = true
end

return require('packer').startup({ function(use)
    use { -- package manager
        'wbthomason/packer.nvim'
    }

    use{
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require('lsp_lines').setup()
        end,
    }

    use { -- colorscheme
        'sainnhe/sonokai'
    }

    use { -- fastest Neovim colorizer
        'norcalli/nvim-colorizer.lua',
        config = function() require 'colorizer'.setup {
                'css';
                'javascript';
            }
        end
    }

    use {
        'stevearc/dressing.nvim',
        config = function() require('dressing').setup {
                select = {
                    get_config = function(opts)
                        if opts.kind == 'codeaction' then
                            return {
                                backend = 'telescope',
                                telescope = require('telescope.themes').get_cursor(),
                            }
                        end
                    end
                }
            }
        end
    }

    use { -- smart and powerful comment plugin
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup {} end,
    }

    use { -- alignment plugin
        'junegunn/vim-easy-align',
        setup = function()
            vim.g.easy_align_delimiters = { ['\\'] = { pattern = '\\\\' } }
        end,
    }

    use { -- motions on speed
        'phaazon/hop.nvim',
        branch = 'v1',
        config = function() require('hop').setup {
                keys = 'etovxqpdygfblzhckisuran'
            }
        end
    }

    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'static',
                max_width = 120,
            }
            vim.notify = require('notify')
        end
    }

    use { -- Extended Vim syntax highlighting for C and C++ (C++11/14/17/20)
        'bfrg/vim-cpp-modern'
    }

    use { -- highlight, edit, and navigate code using a fast incremental parsing library
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'p00f/nvim-ts-rainbow',
        },
        config = function() require('nvim-treesitter.configs').setup {
                rainbow = {
                    enable = true,
                    colors = { '#5fd7ff', '#ffffaf', '#afffff', '#ffd7ff' }
                },
                ensure_installed = { 'c', 'cpp', 'lua', 'python' },
                highlight = {
                    enable = true,
                    disable = { 'c', 'cpp' }, -- bfrg/vim-cpp-modern is better (#if 0 support, auto type support, ...)
                },
                indent = {
                    enable = true,
                }
            }
        end
    }

    use { -- a Git wrapper so awesome, it should be illegal
        'tpope/vim-fugitive'
    }

    use { -- git signs in signcolumn
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup {
                attach_to_untracked = false,
            }
        end
    }

    use { -- Find, Filter, Preview, Pick. All lua, all the time
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                    mappings = {
                        i = {
                            ['<C-k>'] = 'move_selection_previous',
                            ['<C-j>'] = 'move_selection_next',
                            ['<Esc>'] = 'close',
                        }
                    },
                },
            }
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('notify')
        end
    }

    -- use {
    --     'fatih/vim-go',
    --     -- run = function() vim.cmd[[<cmd>GoInstallBinaries<cr>]] end,
    --     ft = {'go'},
    -- }

    use { -- markdown preview plugin
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
        ft = { 'markdown' },
        setup = function()
            vim.g.mkdp_open_to_the_world = 1
            vim.g.mkdp_echo_preview_url = 1
        end,
    }

    use { -- highlight trailing whitespaces
        'ntpeters/vim-better-whitespace',
        setup = function()
            vim.g.better_whitespace_enabled = 1
            vim.g.show_spaces_that_precede_tabs = 1
            vim.g.strip_whitespace_confirm = 0
            vim.g.strip_whitelines_at_eof = 1
            vim.g.strip_whitespace_on_save = 1
            vim.g.better_whitespace_guicolor = '#d78787'
        end,
    }

    use { -- A snazzy bufferline for Neovim
        'akinsho/bufferline.nvim',
        tag = '*',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('bufferline').setup {
                options = {
                    offsets = { { filetype = 'neo-tree', padding = 1 } },
                    numbers = function(opts) return opts.raise(opts.ordinal) end,
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    -- show_buffer_icons = false,
                    modified_icon = '',
                }
            }
        end
    }

    use { -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('lualine').setup {
                options = {
                    globalstatus = true,
                    component_separators = { left = ' ', right = ' ' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_c = { { 'filename', path = 1 } } -- relative path
                }
            }
        end
    }


    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
        config = function()
            vim.g.neo_tree_remove_legacy_commands = true
            require('neo-tree').setup({
                close_if_last_window = true,
                enable_diagnostics = false,
                enable_git_status = false,
                use_default_mappings = false,
                open_files_in_last_windows = false, -- false = open files in top left window
                window = {
                    width = 30,
                    mappings = {
                        ['<cr>'] = 'open',
                        ['r'] = 'refresh',
                        ['a'] = {
                            'add',
                            config = { show_path = 'absolute' } -- 'none', 'relative', 'absolute'
                        },
                        ['d'] = 'delete',
                        ['R'] = 'rename',
                        ['y'] = 'copy_to_clipboard',
                        ['x'] = 'cut_to_clipboard',
                        ['p'] = 'paste_from_clipboard',
                        ['q'] = 'close_window',
                        ['?'] = 'show_help',
                        ['u'] = function(state)
                            local node = state.tree:get_node()
                            if node.level == 0 then
                                require('neo-tree.sources.filesystem.commands').navigate_up(state)
                            else
                                require('neo-tree.sources.manager').focus('filesystem', node:get_parent_id(), nil)
                            end
                        end,
                        ['.'] = 'set_root',
                        ['cd'] = function(state)
                            local node = state.tree:get_node()
                            if node.type == 'directory' then
                                vim.cmd('cd ' .. node.path)
                                print('working directory changed to ' .. node.path)
                            end
                        end,
                    },
                },
                filesystem = {
                    window = {
                        mappings = {
                            ['H'] = 'toggle_hidden',
                            ['f'] = 'filter_on_submit',
                            ['<C-x>'] = 'clear_filter',
                        }
                    },
                    bind_to_cwd = false, -- true creates a 2-way binding between vim's cwd and neo-tree's root
                    filtered_items = {
                        visible = false, -- when true, they will just be displayed differently than normal items
                        force_visible_in_empty_folder = true, -- when true, hidden files will be shown if the root folder is otherwise empty
                        show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
                        hide_dotfiles = true,
                        hide_gitignored = false,
                    },
                },
            })
        end
    }

    use {
        'williamboman/mason.nvim',
        config = function() require('mason').setup{} end
    }
    use {
        'williamboman/mason-lspconfig.nvim'
    }
    use {
        'neovim/nvim-lspconfig'
    }

    use { -- a tree like view for symbols using LSP
        'simrat39/symbols-outline.nvim',
        setup = function()
            vim.g.symbols_outline = {
                auto_preview = false,
                highlight_hovered_item = false,
            }
        end
    }

    use { -- snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    }

    use { -- autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local lsp_icons = {
                Text = '', Method = '', Function = '', Constructor = '', Field = 'ﴲ',
                Variable = '', Class = '', Interface = 'ﰮ', Module = '', Property = '襁',
                Unit = '', Value = '', Enum = '練', Keyword = '', Snippet = '',
                Color = '', File = '', Reference = '', Folder = '', EnumMember = '',
                Constant = 'ﲀ', Struct = 'ﳤ', Event = '', Operator = '', TypeParameter = '',
            }
            local sources = {
                buffer = 'Buffer',
                nvim_lsp = 'LSP',
                luasnip = 'Snippet',
                nvim_lsp_signature_help = 'Sign',
                path = 'Path',
            }
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local border_opts = {
                border = 'rounded',
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
            }

            cmp.setup {
                window = {
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- explicitly selected items only
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'path' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                },
                formatting = {
                    format = function(entry, item)
                        item.kind = string.format('%s %s', lsp_icons[item.kind] or '?', item.kind)
                        item.menu = sources[entry.source.name] or entry.source.name
                        return item
                    end
                },
            }
        end
    }


    if packer_bootstrap then
        require('packer').sync()
    end
end, config = {
    display = {
        open_fn = require('packer.util').float,
    }
} })
