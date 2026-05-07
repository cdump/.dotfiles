hl.on("config.reloaded", function()
  hl.notification.create {
    text = "Hyprland config reloaded",
    timeout = 3000,
    icon = "info"
  }
end)

require("hyprland.monitor")
require("hyprland.env")
require("hyprland.config")
require("hyprland.binds")
require("hyprland.workspaces")
require("hyprland.window_rules")
require("hyprland.autostart")
