hl.on("hyprland.start", function()
  local e = hl.exec_cmd
  e("waybar --config ~/.config/waybar/config-hyprland")
  e("swaybg --image ~/.wall.jpg --mode fill")
  e("mako")
  e("hypridle")
  -- e("wl-paste --primary --watch wl-copy")
  e("gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true")
end)
