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
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
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
                },
                options = {
                    custom_commentstring = function()
                        return require("ts_context_commentstring.internal").calculate_commentstring() or
                        vim.bo.commentstring
                    end,
                },
            })

            local treesitter = require("mini.ai").gen_spec.treesitter
            require('mini.ai').setup {
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

            -- local miniclue = require('mini.clue')
            -- miniclue.setup {
            --     triggers = {
            --         -- Leader triggers
            --         { mode = 'n', keys = '<Leader>' },
            --         { mode = 'x', keys = '<Leader>' },
            --
            --         -- `g` key
            --         { mode = 'n', keys = 'g' },
            --         { mode = 'x', keys = 'g' },
            --
            --         -- Marks
            --         { mode = 'n', keys = "'" },
            --         { mode = 'n', keys = '`' },
            --         { mode = 'x', keys = "'" },
            --         { mode = 'x', keys = '`' },
            --
            --         -- Registers
            --         { mode = 'n', keys = '"' },
            --         { mode = 'x', keys = '"' },
            --         { mode = 'i', keys = '<C-r>' },
            --         { mode = 'c', keys = '<C-r>' },
            --
            --         -- Window commands
            --         { mode = 'n', keys = '<C-w>' },
            --
            --         -- `z` key
            --         { mode = 'n', keys = 'z' },
            --         { mode = 'x', keys = 'z' },
            --     },
            --
            --     clues = {
            --         -- Enhance this by adding descriptions for <Leader> mapping groups
            --         miniclue.gen_clues.builtin_completion(),
            --         miniclue.gen_clues.g(),
            --         miniclue.gen_clues.marks(),
            --         miniclue.gen_clues.registers(),
            --         miniclue.gen_clues.windows(),
            --         miniclue.gen_clues.z(),
            --     },
            --     window = {
            --         config = {
            --             width = 'auto',
            --             row = 'auto',
            --         },
            --     },
            -- }
        end
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            delay = 500,
            win = {
                border = 'single',
            },
        },
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

    { -- motions on speed
        'smoka7/hop.nvim',
        version = '*',
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        },
        keys = {
            { '<leader>j', '<cmd>HopLineStart<cr>' },
            { 's',         '<cmd>HopWord<cr>' },
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
        opts = {
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
            auto_install = true,

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
            }
        }
    },

    { -- a Git wrapper so awesome, it should be illegal
        'tpope/vim-fugitive'
    },

    { -- markdown preview plugin
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function()
            vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/lazy/markdown-preview.nvim')
            vim.fn['mkdp#util#install']()
        end,
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
        opts = function()
            return {
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
            }
        end
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { '<C-\\>', '<Cmd>Neotree reveal_force_cwd toggle<CR>' },
        },
        lazy = false, -- neo-tree will lazily load itself
        opts = {
            close_if_last_window = true,
            enable_diagnostics = false,
            open_files_in_last_windows = false, -- false = open files in top left window
            default_component_configs = {
                indent = {
                    indent_size = 1,
                    padding = 1
                },
            },
        },
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
                    null_ls.builtins.formatting.yamlfmt,
                },
            }
        end
    },

    { -- easily install and manage LSP servers, DAP servers, linters, and formatters
        'mason-org/mason.nvim',
        build = ':MasonUpdate',
        opts = {
            ui = {
                border = 'single',
            },
        },
    },
    {
        'williamboman/mason-lspconfig.nvim'
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig.ui.windows').default_options.border = 'single'
        end
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

    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        build = 'cargo build --release',
        opts = {
            snippets = { preset = 'luasnip' },
            keymap = {
                preset = 'none',
                ['<C-n>'] = { 'show' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },

                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-e>'] = { 'cancel', 'fallback' },

                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

                ['<Tab>'] = { 'snippet_forward', 'fallback' },
                ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
            },
            signature = {
                enabled = true,
                window = {
                    border = 'single',
                },
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = false,
                    },
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
                documentation = {
                    auto_show = true,
                    window = {
                        border = 'single',
                    },
                },
                menu = {
                    border = 'single',
                    draw = {
                        columns = { { 'label' }, { 'kind' }, { 'source_name' } },
                    },
                },
            },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                use_nvim_cmp_as_default = true,
            },
            cmdline = {
                completion = {
                    ghost_text = { enabled = false },
                },
                keymap = {
                    preset = 'none',
                    ['<Tab>'] = {
                        'show_and_insert',
                        'select_next'
                    },
                    ['<C-j>'] = { 'show', 'select_next', 'fallback' },
                    ['<Down>'] = { 'select_next', 'fallback' },
                    ['<C-k>'] = { 'select_prev', 'fallback' },
                    ['<Up>'] = { 'select_prev', 'fallback' },
                    ['<C-c>'] = { 'cancel', 'fallback' },
                },
                sources = function()
                    local type = vim.fn.getcmdtype()
                    if type == "/" or type == "?" then return { "buffer" } end
                    if type == ":" then
                        -- local c = vim.fn.getcmdline():sub(1, 1)
                        -- if c == 'e' or c == 'w' then
                        --     return { "path" }
                        -- end
                        return { "cmdline" }
                    end
                    return {}
                end,
            },

            -- fuzzy = {
            --     sorts = {
            --         function(a, b)
            --             print(vim.inspect(a))
            --             return true
            --         end,
            --         'score', 'sort_text',
            --     },
            -- },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    path = {
                        opts = {
                            trailing_slash = false,
                            show_hidden_files_by_default = true,
                        },
                    },
                },
            },
        },
        opts_extend = { "sources.default" }
    },

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
                    -- input = false,
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
            notify = {
                enabled = false,
            },
            views = {
                mini = {
                    timeout = 8000,
                    border = {
                        style = 'single',
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

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            styles = {
                input = {
                    relative = "cursor",
                    row = -3,
                    title_pos = "left",
                    keys = {
                        n_cc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                        i_cc = { "<C-c>", { "cmp_close", "cancel" }, mode = "i", expr = true },
                    },
                },
                notification = {
                    focusable = false,
                },
            },
            dim = { enabled = true, animate = { enabled = false } },
            notifier = {
                enabled = true,
            },
            bigfile = {
                enabled = true,
                -- line_length = math.huge,
            },
            explorer = { enabled = true },
            quickfile = { enabled = true },
            indent = {
                enabled = true,
                indent = {
                    char = '▏',
                },
                animate = {
                    enabled = false,
                },
                scope = {
                    enabled = false,
                },
                filter = function(buf)
                    local exclude = { 'help', 'markdown', 'text' }
                    return vim.g.snacks_indent ~= false
                        and vim.b[buf].snacks_indent ~= false
                        and vim.bo[buf].buftype == ""
                        and not vim.tbl_contains(exclude, vim.bo[buf].filetype)
                end,
            },
            input = {
                enabled = true,
                icon = "",
            },
            picker = {
                enabled = true,
                formatters = {
                    file = {
                        git_status_hl = false,
                    },
                },
                sources = {
                    files = {
                        layout = { preset = "telescope" },
                    },
                    grep = {
                        layout = { preset = "telescope" },
                    },
                    diagnostics = {
                        layout = { preset = "telescope" },
                    },
                    diagnostics_buffer = {
                        layout = { preset = "telescope" },
                    },
                    explorer = {
                        auto_close = true,
                        replace_netrw = false,
                        win = {
                            list = {
                                keys = {
                                    ["<C-c>"] = "close",
                                    ["<leader>w"] = "close",
                                    ["<C-\\>"] = "close",
                                    ["u"] = "explorer_up",
                                    ["cd"] = "tcd",
                                    ["z"] = "toggle_maximize",
                                    ["c"] = "tcd",
                                    -- ["l"] = "confirm",
                                    -- ["h"] = "explorer_close", -- close directory
                                    -- ["a"] = "explorer_add",
                                    -- ["d"] = "explorer_del",
                                    -- ["r"] = "explorer_rename",
                                    -- ["m"] = "explorer_move",
                                    -- ["o"] = "explorer_open", -- open with system application
                                    -- ["P"] = "toggle_preview",
                                    -- ["y"] = "explorer_yank",
                                    -- ["u"] = "explorer_update",
                                    -- ["<c-c>"] = "tcd",
                                    -- ["<leader>/"] = "picker_grep",
                                    -- ["<c-t>"] = "terminal",
                                    -- ["I"] = "toggle_ignored",
                                    -- ["H"] = "toggle_hidden",
                                    -- ["Z"] = "explorer_close_all",
                                    -- ["]g"] = "explorer_git_next",
                                    -- ["[g"] = "explorer_git_prev",
                                    -- ["]d"] = "explorer_diagnostic_next",
                                    -- ["[d"] = "explorer_diagnostic_prev",
                                    -- ["]w"] = "explorer_warn_next",
                                    -- ["[w"] = "explorer_warn_prev",
                                    -- ["]e"] = "explorer_error_next",
                                    -- ["[e"] = "explorer_error_prev",
                                },
                            },
                        },
                    },
                },
            },
        },
        keys = {
            { '<C-g>',      function() Snacks.picker.git_files() end },
            { '<C-p>',      function() Snacks.picker.files() end },
            { "<leader>a",  function() Snacks.picker.grep() end },
            { "<leader>\'", function() Snacks.picker.marks() end,                 desc = "Marks" },
            { "<leader>,",  function() Snacks.picker.buffers() end,               desc = "Buffers" },
            { "<leader>t",  function() Snacks.picker.resume() end,                desc = "Resume" },

            { "<leader>o",  function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
            { "<leader>O",  function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

            -- { "<C-\\>",     function() Snacks.explorer.reveal() end,              desc = "File Explorer" },

            { "<leader>gd", function() Snacks.picker.git_diff() end,              desc = "Git Diff (Hunks)" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end,          desc = "Git Log File" },
            { "<leader>gl", function() Snacks.picker.git_log_line() end,          desc = "Git Log Line" },

            { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
            { "gi",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
            { "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                 desc = "References" },
            { "<leader>x",  function() Snacks.picker.diagnostics_buffer() end },
            { "<leader>X",  function() Snacks.picker.diagnostics() end },

            { "<leader>n",  function() Snacks.notifier.show_history() end },

        },
    },


    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            {
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "codecompanion" },
                },
                ft = { "codecompanion" },
            },
        },
        cmd = {
            'CodeCompanion',
            'CodeCompanionActions',
            'CodeCompanionChat',
            'CodeCompanionCmd',
        },
        keys = {
            { mode = {'n', 'v'}, '<leader>cc', '<Cmd>CodeCompanionActions<cr>' },

        },
        opts = {
            strategies = {
                chat = {
                    adapter = "openrouter",
                    keymaps = {
                        close = { modes = { n = "<Esc>", i = "<Esc>" } },
                        stop = { modes = { n = "<C-c>" } },
                    },
                },
                inline = {
                    adapter = "openrouter",
                },
            },
            adapters = {
                openrouter = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        name = "openrouter",
                        schema = {
                            model = {
                                default = "anthropic/claude-3.5-sonnet",
                            },
                        },
                        env = {
                            url = "https://openrouter.ai/api",
                            api_key = "OPENROUTER_API_KEY",
                        },
                    })
                end,
            },
        },
    },

    -- {
    --     "yetone/avante.nvim",
    --     event = "VeryLazy",
    --     lazy = false,
    --     version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    --     opts = {
    --         provider = "openai",
    --         openai = {
    --             endpoint = "https://openrouter.ai/api/v1",
    --             model = "anthropic/claude-3.5-sonnet",
    --             -- endpoint = "https://api.openai.com/v1",
    --             -- model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
    --             timeout = 30000, -- timeout in milliseconds
    --             temperature = 0, -- adjust if needed
    --             max_tokens = 4096,
    --         },
    --     },
    --     -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    --     build = "make",
    --     -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    --     dependencies = {
    --         -- "stevearc/dressing.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "MunifTanjim/nui.nvim",
    --         --- The below dependencies are optional,
    --         -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
    --         -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    --         -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    --         -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
    --         -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    --         "zbirenbaum/copilot.lua", -- for providers='copilot'
    --         {
    --             -- Make sure to set this up properly if you have lazy=true
    --             'MeanderingProgrammer/render-markdown.nvim',
    --             opts = {
    --                 file_types = { "Avante" },
    --             },
    --             ft = {  "Avante" },
    --         },
    --     },
    -- },
}, {
    ui = {
        border = 'single',
    },
})
