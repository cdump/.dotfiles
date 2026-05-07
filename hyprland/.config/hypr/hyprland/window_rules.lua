hl.window_rule {
  match = {
    class = "nwg-look|nwg-displays|l3afpad|pavucontrol-qt|qalculate-gtk|org.twosheds.iwgtk"
  },
  float = true
}

hl.window_rule {
  match = {
    title = "Save File"
  },
  float = true
}

hl.window_rule {
  match = {
    float = true
  },
  group = "override barred",
}

hl.window_rule {
  match = {
    class = "org.telegram.desktop",
    title = "Media viewer",
  },
  fullscreen = true,
  fullscreen_state = 1,
}


-- hl.window_rule {
--   match = {
--     class = "org.keepassxc.KeePassXC"
--   },
--   workspace = "special:kpass",
--   float = true,
--   center = true,
--   size = "(monitor_w*0.55) (monitor_h*0.5)",
-- }

hl.window_rule {
  name           = "suppress-maximize-events",
  match          = { class = ".*" },
  suppress_event = "maximize",
}
