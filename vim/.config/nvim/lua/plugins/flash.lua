return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    search = {
      multi_window = false,
    },
    modes = {
      char = {
        enabled = false,
      },
      search = {
        enabled = true,
      },
    }
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "Flash"
    },
    -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    {
      "r",
      mode = "o",
      function() require("flash").remote() end,
      desc = "Remote Flash"
    },
    -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    {
      "<c-s>",
      mode = { "c" },
      function() require("flash").toggle() end,
      desc = "Toggle Flash Search"
    },
    {
      "<leader>j",
      mode = { "n" },
      function()
        require("flash").jump({
          search = { mode = "search", max_length = 0 },
          label = { after = { 0, 0 } },
          pattern = "^"
        })
      end,
      desc = "Jump to a line"
    },
  },
}
