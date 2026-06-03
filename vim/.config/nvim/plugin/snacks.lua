vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

require('snacks').setup({
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
  dim = { animate = { enabled = false } },
  notifier = {
    enabled = true,
  },
  bigfile = {
    enabled = true,
    -- line_length = math.huge,
  },
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
        win = {
          list = {
            keys = {
              ["<C-c>"] = "close",
              ["<leader>w"] = "close",
              ["<leader>e"] = "close",
              ["z"] = "toggle_maximize",
              ["."] = "tcd",
            },
          },
        },
      },
    },
  },
})

vim.keymap.set('n', '<C-g>', function() Snacks.picker.git_files() end)
vim.keymap.set('n', '<C-p>', function() Snacks.picker.files() end)
vim.keymap.set('n', '<leader>a', function() Snacks.picker.grep() end)
vim.keymap.set('n', "<leader>'", function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set('n', '<leader>,', function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set('n', '<leader>t', function() Snacks.picker.resume() end, { desc = "Resume" })

vim.keymap.set('n', '<leader>o', function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set('n', '<leader>O', function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- { "<C-\\>",     function() Snacks.explorer.reveal() end,              desc = "File Explorer" },
vim.keymap.set('n', '<leader>e', function() Snacks.explorer.reveal() end, { desc = "File Explorer" })

vim.keymap.set('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
vim.keymap.set('n', '<leader>gf', function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })
vim.keymap.set('n', '<leader>gl', function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })

vim.keymap.set('n', 'gD', function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set('n', 'gi', function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set('n', 'gr', function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })

vim.keymap.set('n', '<leader>x', function() Snacks.picker.diagnostics_buffer() end)
vim.keymap.set('n', '<leader>X', function() Snacks.picker.diagnostics() end)

vim.keymap.set('n', '<leader>n', function() Snacks.notifier.show_history() end)
