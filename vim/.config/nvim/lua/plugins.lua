local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable", -- latest stable release
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    {
        'folke/lazy.nvim',
        tag = 'stable'
    },

    {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        keys = {
            { '<leader>l', function() require('lsp_lines').toggle() end, desc = 'Toggle lsp_lines' },
        },
        config = function()
            require('lsp_lines').setup()
            vim.diagnostic.config({ virtual_lines = false })
        end,
    },

    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            require('mini.diff').setup({
                view = {
                    signs = { add = '┃', change = '┃', delete = '_' },
                },
            })

            require('mini.comment').setup({
                mappings = {
                    textobject = 'ic',
                }
            })

            local treesitter = require("mini.ai").gen_spec.treesitter
            require('mini.ai').setup{
                n_lines = 500,
                custom_textobjects = {
                    f = treesitter { a = '@function.outer', i = '@function.inner' },
                    k = treesitter { a = '@block.outer', i = '@block.inner' },
                    o = treesitter { a = { '@conditional.outer', '@loop.outer' }, i = { '@conditional.inner', '@loop.inner' } },
                },
            }

            require('mini.bracketed').setup()

            require('mini.splitjoin').setup {
                mappings = {
                    toggle = 'gs',
                }
            }

            local minialign = require('mini.align')
            minialign.setup {
                mappings = {
                    start_with_preview = 'ga',
                },
                modifiers = {
                    ['\\'] = function(steps, opts)
                        opts.split_pattern = '\\%s*$'
                        table.insert(steps.pre_justify, minialign.gen_step.trim())
                    end
                },
            }

            local miniclue = require('mini.clue')
            miniclue.setup {
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
            }
        end
    },

    { -- a better user experience for viewing and interacting with Vim marks
        'chentoast/marks.nvim',
        opts = {},
    },

    { -- colorscheme
        'sainnhe/sonokai'
    },

    { -- Create Color Code
        'uga-rosa/ccc.nvim',
        cmd = 'CccPick',
    },

    { -- fastest Neovim colorizer
        'norcalli/nvim-colorizer.lua',
        opts = {
            'css',
            'javascript',
        }
    },

    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        config = function() require('dressing').setup {
            input = {
                win_options = {
                    winblend = 0, -- disable transparency
                },
            },
            select = {
                telescope = require('telescope.themes').get_cursor(),
            }
        }
        end
    },

    { -- motions on speed
        'smoka7/hop.nvim',
        version = '*',
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        },
        keys = {
            { '<leader>j', '<cmd>HopLineStart<cr>'},
            { 's', '<cmd>HopWord<cr>'},
        },
    },


    { -- Extended Vim syntax highlighting for C and C++ (C++11/14/17/20)
        'bfrg/vim-cpp-modern'
    },

    {
        'hiphish/rainbow-delimiters.nvim',
        config = function()
            vim.g.rainbow_delimiters = {
                highlight = {
                    'rainbowcol1',
                    'rainbowcol2',
                    'rainbowcol3',
                    'rainbowcol4',
                    'rainbowcol5',
                    'rainbowcol6',
                    'rainbowcol7',
                }
            }
        end
    },

    { -- highlight, edit, and navigate code using a fast incremental parsing library
        'nvim-treesitter/nvim-treesitter',
        -- version = nil,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        -- build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash',
                    'c',
                    'cpp',
                    'css',
                    'go',
                    'html',
                    'javascript',
                    'json',
                    'lua',
                    'make',
                    'markdown',
                    'markdown_inline',
                    'python',
                    'regex',
                    'rust',
                    'typescript',
                    'vim',
                    'vimdoc',
                    'vue',
                    'yaml',
                },

                highlight = {
                    enable = true,
                    disable = { 'c', 'cpp' }, -- bfrg/vim-cpp-modern is better (#if 0 support, auto type support, ...)
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<C-space>',
                        node_incremental = '<C-space>',
                        node_decremental = '<C-A-space>',
                    },
                },
            }
        end
    },

    { -- a Git wrapper so awesome, it should be illegal
        'tpope/vim-fugitive'
    },

    { -- Find, Filter, Preview, Pick. All lua, all the time
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
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
        end
    },

    { -- markdown preview plugin
        'iamcco/markdown-preview.nvim',
        build = function() vim.fn['mkdp#util#install']() end,
        ft = { 'markdown' },
        init = function()
            vim.g.mkdp_open_to_the_world = 1
            vim.g.mkdp_echo_preview_url = 1
        end,
    },

    { -- highlight trailing whitespaces
        'ntpeters/vim-better-whitespace',
        init = function()
            vim.g.better_whitespace_enabled = 1
            vim.g.show_spaces_that_precede_tabs = 1
            vim.g.strip_whitespace_confirm = 0
            vim.g.strip_whitelines_at_eof = 1
            vim.g.strip_whitespace_on_save = 1
            vim.g.better_whitespace_guicolor = '#d78787'
        end,
    },

    { -- A snazzy bufferline for Neovim
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                numbers = function(opts) return opts.raise(opts.ordinal) end,
                show_buffer_close_icons = false,
                show_close_icon = false,
                modified_icon = '',
                indicator = {
                    style = 'none',
                },
            }
        }
    },

    { -- A blazing fast and easy to configure neovim statusline plugin written in pure lua
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = function() return {
            options = {
                globalstatus = true,
                component_separators = { left = ' ', right = ' ' },
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_b = { { 'filename', path = 1 } }, -- relative path
                lualine_c = {
                    {
                        require('noice').api.status.search.get,
                        cond = require('noice').api.status.search.has,
                        color = { fg = '#ff9e64' },
                    },
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                },
            }
        } end
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        config = function()
            local hooks = require 'ibl.hooks'
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                 vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#282c34' })
            end)
            require('ibl').setup{
                indent = {
                    char = '▏',
                },
                scope = {
                    enabled = false,
                },
                exclude = {
                    filetypes = { 'help', 'markdown', 'text' },
                },
            }

        end
    },

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        keys = {
            { '<C-\\>', function() require('nvim-tree.api').tree.open({find_file=true, update_root=true}) end },
        },
        config = function()
            require('nvim-tree').setup({
                sort_by = 'case_sensitive',
                on_attach = function(bufnr)
                    local api = require "nvim-tree.api"
                    local lib = require "nvim-tree.lib"
                    local function opts(desc)
                        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                    end
                    api.config.mappings.default_on_attach(bufnr)

                    vim.keymap.set('n', 'u', api.tree.change_root_to_parent,        opts('Up'))

                    vim.keymap.set('n', 'cd', function()
                        local node = lib.get_node_at_cursor()
                        local path = node.type == 'directory' and node.absolute_path or
                        node.parent.absolute_path
                        vim.cmd('cd ' .. path)
                        print('directory changed to ' .. path)
                    end, opts('cd'))

                    vim.keymap.set('n', '.', function()
                        local node = api.tree.get_node_under_cursor()
                        local cnode = node.type == 'directory' and node.parent or
                        (node.parent.parent or node.parent)
                        api.tree.change_root_to_node(cnode)
                        api.tree.find_file(node.absolute_path)
                        print('root set to ' .. cnode.absolute_path)
                    end, opts('set root'))
                end,
                view = {
                    signcolumn = 'no',
                    width = {
                        min = 25,
                        max = 60,
                    },
                },
                renderer = {
                    group_empty = true,
                    indent_width = 1,
                    icons = {
                        show = {
                            folder_arrow = false,
                        },
                    },
                },
                filters = {
                    dotfiles = true,
                },
                git = {
                    enable = false,
                },
                live_filter = {
                    always_show_folders = false, -- Turn into false from true by default
                },
            })
            vim.api.nvim_create_autocmd('BufEnter', {
                nested = true,
                callback = function()
                    if #vim.api.nvim_list_wins() == 1 and require('nvim-tree.utils').is_nvim_tree_buf() then
                        vim.cmd 'quit'
                    end
                end
            })
        end
    },

    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            'nvimtools/none-ls-extras.nvim',
        },
        config = function()
            local null_ls = require('null-ls')
            null_ls.setup {
                -- debug = true,
                on_attach = require('lsp_on_attach').lsp_on_attach,
                sources = {
                    null_ls.builtins.formatting.black.with {
                        only_local = '.venv/bin',
                    },
                    null_ls.builtins.diagnostics.mypy.with {
                        only_local = '.venv/bin',
                    },
                },
            }
        end
    },

    { -- easily install and manage LSP servers, DAP servers, linters, and formatters
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        opts = {
            ui = {
                border = 'rounded',
            },
        },
    },
    {
        'williamboman/mason-lspconfig.nvim'
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig.ui.windows').default_options.border = 'rounded'
        end
    },

    { -- a tree like view for symbols using LSP
        'hedyhli/outline.nvim',
        keys = {
            { '<leader>t', '<cmd>Outline<CR>', desc = 'Toggle outline' },
        },
        opts = {
            highlight_hovered_item = false,
        }
    },

    { -- snippets
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        build = 'make install_jsregexp',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
        end
    },

    { -- autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local border_opts = {
                border = 'rounded',
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
            }

            cmp.setup {
                preselect = cmp.PreselectMode.None,
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
                        local sources = {
                            buffer = 'Buffer',
                            nvim_lsp = 'LSP',
                            luasnip = 'Snippet',
                            nvim_lsp_signature_help = 'Sign',
                            path = 'Path',
                        }
                        item.menu = sources[entry.source.name] or entry.source.name
                        return item
                    end
                },
            }
        end
    },

    -- use {
    --     'fatih/vim-go',
    --     -- run = function() vim.cmd[[<cmd>GoInstallBinaries<cr>]] end,
    --     ft = {'go'},
    -- }

    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            routes = {
                {
                    view = 'split',
                    filter = { event = 'msg_show', min_height = 10 },
                },
                {
                    filter = { event = 'msg_show', kind = 'search_count' },
                    opts = { skip = true },
                },
                {
                    filter = { event = 'msg_show', kind = '', find = 'written' },
                    opts = { skip = true },
                },
                {
                    filter = { event = 'lsp', kind = 'progress', cond = function(message) return vim.tbl_get(message.opts, 'progress', 'client') == 'null-ls' end },
                    opts = { skip = true },
                },
            },
            cmdline = {
                enabled = true,
                view = 'cmdline',
                format = {
                    cmdline = { conceal = false },
                    input = false,
                },
            },
            lsp = {
                progress = {
                    enabled = false,
                },
                hover = {
                    enabled = false,
                },
                signature = {
                    enabled = false,
                },
            },
            messages = {
                view_search = false,
            },
            views = {
                mini = {
                    timeout = 8000,
                    border = {
                        style = 'rounded',
                    },
                    position = {
                        row = -2,
                        col = '100%',
                    },
                    win_options = {
                        winblend = 0, -- disable transparency
                    },
                },
            },
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
        }
    },

    -- {
    --     'nvim-neo-tree/neo-tree.nvim',
    --     branch = 'v3.x',
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --         'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    --         'MunifTanjim/nui.nvim',
    --     },
    --     config = function()
    --         vim.g.neo_tree_remove_legacy_commands = true
    --         require('neo-tree').setup({
    --             close_if_last_window = true,
    --             enable_diagnostics = false,
    --             enable_git_status = false,
    --             use_default_mappings = false,
    --             open_files_in_last_windows = false, -- false = open files in top left window
    --             window = {
    --                 width = 30,
    --                 mappings = {
    --                     ['<cr>'] = 'open',
    --                     ['r'] = 'refresh',
    --                     ['a'] = {
    --                         'add',
    --                         config = { show_path = 'absolute' } -- 'none', 'relative', 'absolute'
    --                     },
    --                     ['d'] = 'delete',
    --                     ['R'] = 'rename',
    --                     ['y'] = 'copy_to_clipboard',
    --                     ['x'] = 'cut_to_clipboard',
    --                     ['p'] = 'paste_from_clipboard',
    --                     ['q'] = 'close_window',
    --                     ['?'] = 'show_help',
    --                     ['u'] = function(state)
    --                         local node = state.tree:get_node()
    --                         if node.level == 0 then
    --                             require('neo-tree.sources.filesystem.commands').navigate_up(state)
    --                         else
    --                             require('neo-tree.sources.manager').focus('filesystem', node:get_parent_id(), nil)
    --                         end
    --                     end,
    --                     ['.'] = 'set_root',
    --                     ['cd'] = function(state)
    --                         local node = state.tree:get_node()
    --                         if node.type == 'directory' then
    --                             vim.cmd('cd ' .. node.path)
    --                             print('working directory changed to ' .. node.path)
    --                         end
    --                     end,
    --                 },
    --             },
    --             filesystem = {
    --                 window = {
    --                     mappings = {
    --                         ['H'] = 'toggle_hidden',
    --                         ['f'] = 'filter_on_submit',
    --                         ['<C-x>'] = 'clear_filter',
    --                     }
    --                 },
    --                 bind_to_cwd = false, -- true creates a 2-way binding between vim's cwd and neo-tree's root
    --                 filtered_items = {
    --                     visible = false, -- when true, they will just be displayed differently than normal items
    --                     force_visible_in_empty_folder = true, -- when true, hidden files will be shown if the root folder is otherwise empty
    --                     show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
    --                     hide_dotfiles = true,
    --                     hide_gitignored = false,
    --                 },
    --             },
    --         })
    --     end
    -- }
}, {
    ui = {
        border = 'rounded',
    },
})
