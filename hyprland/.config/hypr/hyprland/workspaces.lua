local utils = require("hyprland.utils")

local workspaces = {
  {
    name = "web",
    window_classes = {
      "firefox",
      "brave",
      "chromium",
      "google-chrome.*"
    },
    window_opts = {
      group = "set",
    },
  },
  {
    name = "file",
    window_classes = {
      "yazi",
    },
  },
  {
    name = "mail",
    window_classes = {
      "eu.betterbird.Betterbird",
    },
  },
  {
    name = "im",
    window_classes = {
      "org.telegram.desktop",
    },
  },
  {
    name = "term",
    window_classes = {
      "foot",
    },
  },
  {
    name = "six",
    window_classes = {
      "gimp",
      "obsidian",
    },
  },
  {
    name = "seven",
    window_classes = {
      "libreoffice-.*",
    },
  },
  {
    name = "eight",
    window_classes = {
      "org.qbittorrent.qBittorrent",
    },
  },
  { name = "nine" },
  { name = "ten" },
  { name = "eleven" },
  { name = "twelve" },
}

for i, ws in ipairs(workspaces) do
  hl.workspace_rule {
    workspace = i,
    default_name = utils.format_subscript(i) .. " " .. ws.name
  }

  if i <= 10 then
    local key = i % 10 -- 10 maps to key 0
    utils.bind({ "SUPER", key }, hl.dsp.focus({ workspace = i }))
    utils.bind({ "SUPER", "SHIFT", key }, hl.dsp.window.move({ workspace = i }))
  end

  if ws.window_classes ~= nil then
    local wopts = ws.window_opts or {}
    wopts.workspace = i
    wopts.match = {
      class = table.concat(ws.window_classes, "|")
    }
    hl.window_rule(wopts)
  end
end
