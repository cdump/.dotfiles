return {
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
}
