return {
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
    explorer = { enabled = false },
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

    { "gD",         function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
    { "gd",         function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
    { "gi",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
    { "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                 desc = "References" },

    { "<leader>x",  function() Snacks.picker.diagnostics_buffer() end },
    { "<leader>X",  function() Snacks.picker.diagnostics() end },

    { "<leader>n",  function() Snacks.notifier.show_history() end },

  },
}
