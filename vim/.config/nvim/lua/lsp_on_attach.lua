local M = {}

local tbi = require('telescope.builtin')

function M.lsp_on_attach(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', tbi.lsp_definitions, opts)
    vim.keymap.set('n', 'gi', tbi.lsp_implementations, opts)
    vim.keymap.set('n', 'gr', tbi.lsp_references, opts)
    vim.keymap.set('n', '<leader>x', function()
        tbi.diagnostics({ bufnr = 0 })
    end, opts)
    vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.hover) -- useful for 'get varible type under cursor'
end

return M
