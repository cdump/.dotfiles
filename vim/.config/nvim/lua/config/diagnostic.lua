vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  -- virtual_text = {
  --     spacing = 3,
  --     severity_limit = 'Error',
  --     prefix = '·',
  -- },
  severity_sort = true,
})

vim.keymap.set('n', '<C-k>', function()
  vim.diagnostic.jump({ count = -1, float = true, severity = { min = vim.diagnostic.severity.WARN } })
end)

vim.keymap.set('n', '<C-j>', function()
  vim.diagnostic.jump({ count = 1, float = true, severity = { min = vim.diagnostic.severity.WARN } })
end)

vim.keymap.set('n', '<C-A-k>', function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

vim.keymap.set('n', '<C-A-j>', function()
  vim.diagnostic.jump({ count = 1, float = true })
end)
