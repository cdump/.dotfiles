return {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--pch-storage=memory',
    '--completion-style=detailed',
    '-j=2',
  }
}
