hl.config {
  input = {
    kb_layout = "us,ru",
    kb_options = "grp:alt_shift_toggle",
    follow_mouse = 0,
    focus_on_close = 1,
    float_switch_override_focus = 2,
  },
  general = {
    gaps_in = 3,
    gaps_out = 0,
    border_size = 0,
    col = {
      active_border = "rgb(505050)",
      inactive_border = "rgb(1f1f1f)",
    },
    layout = "dwindle",
  },
  decoration = {
    blur = {
      enabled = false,
    },
  },
  animations = {
    enabled = false,
  },
  dwindle = {
    preserve_split = true,
    force_split = 2, -- right or bottom
    permanent_direction_override = true,
    split_width_multiplier = 1.7,
  },
  master = {
    new_status = "master",
  },
  misc = {
    force_default_wallpaper = 0,
    key_press_enables_dpms = true,
  },
  xwayland = {
    enabled = false,
  },
  group = {
    col = {
      border_active = "rgb(ff0000)",
      border_inactive = "rgb(ff0000)",
      border_locked_active = "rgb(ff0000)",
      border_locked_inactive = "rgb(ff0000)",
    },
    groupbar = {
      middle_click_close = false,
      gradients = true,
      font_size = 15,
      height = 21,
      col = {
        active = "rgb(444444)",
        inactive = "rgb(1f1f1f)",
      },
      text_color = "rgb(cccccc)",
      text_color_inactive = "rgb(777777)",
      gaps_out = 0,
      gaps_in = 0,
    }
  },
}
