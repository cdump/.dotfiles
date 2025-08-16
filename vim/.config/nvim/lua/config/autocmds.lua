-- Disable comments on Enter press
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

-- autoformat go
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go' },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- 2 spaces for web and lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'html', 'vue', 'css', 'scss', 'javascript', 'typescript' },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- highlighting on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 500 })
  end,
  pattern = '*',
})
