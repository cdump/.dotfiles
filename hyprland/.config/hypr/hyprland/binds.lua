local utils = require("hyprland.utils")
local focus_prev_window = require("hyprland.focus_prev_window")
local rename_workspace = require("hyprland.rename_workspace")

local function run_or_toggle(window_class, cmd, opts)
  local window_selector = "class:" .. window_class
  opts = opts or {}
  opts.match = { class = window_class }
  opts.workspace = "special:" .. window_class
  opts.float = opts.float or true
  hl.window_rule(opts)

  return function()
    if hl.get_window(window_selector) == nil then
      hl.dispatch(hl.dsp.exec_cmd(cmd))
      return
    end
    hl.dispatch(hl.dsp.workspace.toggle_special(window_class))
  end
end

local exec = hl.dsp.exec_cmd

local show_keepass = run_or_toggle(
  "org.keepassxc.KeePassXC",
  "~/.local/bin/keepassxc",
  {
    center = true,
    size = "(monitor_w*0.55) (monitor_h*0.5)"
  }
)

local binds = {
  { { "SUPER", "Return" },         exec("foot") },

  { { "SUPER", "Q" },              exec("~/.local/bin/chromium") },
  { { "SUPER", "SHIFT", "Q" },     exec("rofi -modes 'chrome:~/.config/rofi/chrome-profile-mode' -show chrome") },
  { { "SUPER", "E" },              exec("foot --app-id=yazi yazi") },
  { { "SUPER", "R" },              exec("rofi -show run") },
  { { "SUPER", "N" },              exec("l3afpad") },
  { { "SUPER", "C" },              exec("qalculate-gtk") },
  { { "SUPER", "F2" },             exec("firejail --profile=/etc/firejail/thunderbird.profile -- betterbird") },
  { { "SUPER", "F4" },             exec("foot --app-id=obsidian nvim ~/data/obsidian/") },
  { { "SUPER", "F5" },             exec("~/.local/bin/Telegram -scale 150") },

  { { "SUPER", "F9" },             exec("sudo systemctl poweroff --force") },
  { { "SUPER", "F12" },            exec("sudo systemctl suspend") },
  { { "CONTROL", "Delete" },       exec("loginctl lock-session") },

  { { "SUPER", "Print" },          exec("hyprpicker --no-fancy | wl-copy") },
  { { "ALT", "Print" },            exec("grim && notify-send 'Screenshot saved'") },
  { "Print",                       exec([[grim -g "$(slurp -d -b 000000bb -s 00000011 -c ff000088)"]]) },

  { "XF86AudioRaiseVolume",        exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") },
  { "XF86AudioLowerVolume",        exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") },
  { "XF86AudioMute",               exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") },
  { "XF86AudioMicMute",            exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") },
  { "XF86MonBrightnessUp",         exec("brightnessctl -e4 -n2 set 5%+") },
  { "XF86MonBrightnessDown",       exec("brightnessctl -e4 -n2 set 5%-") },

  { { "SUPER", "P" },     show_keepass },
  { { "SUPER", "grave" }, show_keepass }, -- grave = name of ` symbol

  { { "SUPER", "SHIFT", "S" },     hl.dsp.workspace.toggle_special("spec") },
  { { "SUPER", "S" },              hl.dsp.window.move({ workspace = "special:spec" }) },

  { { "SUPER", "SHIFT", "C" },     hl.dsp.window.close() },
  { { "SUPER", "SHIFT", "F" },     hl.dsp.window.float({ action = "toggle" }) },
  { { "SUPER", "SHIFT", "P" },     hl.dsp.window.pin() },
  { { "SUPER", "F" },              hl.dsp.window.fullscreen() },
  { { "SUPER", "M" },              hl.dsp.window.fullscreen({ mode = "maximized" }) },
  { { "SUPER", "G" },              hl.dsp.group.toggle() },

  -- dwindle
  { { "SUPER", "SHIFT", "P" },     hl.dsp.window.pseudo() },
  { { "SUPER", "Space" },          hl.dsp.layout("togglesplit") },

  { { "SUPER", "h" },              hl.dsp.focus({ direction = "left" }) },
  { { "SUPER", "l" },              hl.dsp.focus({ direction = "right" }) },
  { { "SUPER", "k" },              hl.dsp.focus({ direction = "up" }) },
  { { "SUPER", "j" },              hl.dsp.focus({ direction = "down" }) },
  { { "SUPER", "up" },             hl.dsp.window.cycle_next({ next = false }) },
  { { "SUPER", "down" },           hl.dsp.window.cycle_next({ next = true }) },
  { { "SUPER", "SHIFT", "h" },     hl.dsp.window.move({ direction = "left" }) },
  { { "SUPER", "SHIFT", "left" },  hl.dsp.window.move({ direction = "left" }) },
  { { "SUPER", "SHIFT", "l" },     hl.dsp.window.move({ direction = "right" }) },
  { { "SUPER", "SHIFT", "right" }, hl.dsp.window.move({ direction = "right" }) },
  { { "SUPER", "SHIFT", "k" },     hl.dsp.window.move({ direction = "up" }) },
  { { "SUPER", "SHIFT", "up" },    hl.dsp.window.move({ direction = "up" }) },
  { { "SUPER", "SHIFT", "j" },     hl.dsp.window.move({ direction = "down" }) },
  { { "SUPER", "SHIFT", "down" },  hl.dsp.window.move({ direction = "down" }) },
  { { "SUPER", "mouse:272" },      { hl.dsp.window.drag(), { mouse = true } } },
  { { "SUPER", "mouse:273" },      { hl.dsp.window.resize(), { mouse = true } } },


  { { "SUPER", "a" },              hl.dsp.window.move({ workspace = "emptyn" }) },
  { { "SUPER", "left" },           hl.dsp.focus({ workspace = "e-1" }) },
  { { "SUPER", "right" },          hl.dsp.focus({ workspace = "e+1" }) },
  { { "SUPER", "escape" },         hl.dsp.focus({ workspace = "previous" }) },

  { { "SUPER", "Tab" },            focus_prev_window.focus_prev_window_on_current_workspace },
  { { "SUPER", "SHIFT", "R" },     rename_workspace.rename_current_workspace },
}

for _, b in ipairs(binds) do
  utils.bind(b[1], b[2])
end
