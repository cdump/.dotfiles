-------------------------------
--  "Zenburn" awesome t  --
--    By Adrian C. (anrxc)   --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

t = {}
t.dir = "~/.config/awesome/themes/zenburn"


-- t.font      = "sans 9"
t.font      = "Dejavu Sans 7"
-- t.font      = "Dejavu Sans Mono for Powerline 10"


-- {{{ Colors
-- t.fg_normal = "#8C8C8C"
-- t.fg_focus  = "#BBBBBB"
-- t.fg_urgent = "#CC9393"
-- t.bg_normal = "#2F2F2F"
-- t.bg_focus  = "#151515"
-- t.bg_urgent = "#3F3F3F"
-- }}}
t.fg_normal = "#AAAAAA"
t.fg_focus  = "#F0DFAF"
t.fg_urgent = "#CC9393"
t.bg_normal = "#222222"
t.bg_focus  = "#1E2320"
t.bg_urgent = "#3F3F3F"

-- {{{ Borders
t.border_width  = "1"
t.border_normal = "#3F3F3F"
t.border_focus  = "#6F6F6F"
t.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
t.titlebar_bg_focus  = "#3F3F3F"
t.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- ~ t.fg_widget        = "#AECF96"
-- ~ t.fg_center_widget = "#88A175"
-- ~ t.fg_end_widget    = "#FF5656"
-- ~ t.fg_off_widget    = "#494B4F"
-- ~ t.fg_netup_widget  = "#7F9F7F"
-- ~ t.fg_netdn_widget  = "#CC9393"
-- ~ t.bg_widget        = "#3F3F3F"
-- ~ t.border_widget    = "#3F3F3F"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--t.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- t.fg_widget        = "#AECF96"
-- t.fg_center_widget = "#88A175"
-- t.fg_end_widget    = "#FF5656"
-- t.bg_widget        = "#494B4F"
-- t.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
t.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
t.menu_height = "15"
t.menu_width  = "100"
-- }}}

-- {{{ Icons
-- {{{ Taglist
t.taglist_squares_sel   = t.dir .. "/taglist/squarefz.png"
t.taglist_squares_unsel = t.dir .. "/taglist/squarez.png"
--~ t.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
t.awesome_icon           = t.dir .. "/awesome-icon.png"
t.menu_submenu_icon      = "/usr/local/share/awesome/ts/default/submenu.png"
t.tasklist_floating_icon = "/usr/local/share/awesome/ts/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout
t.layout_tile       = t.dir .. "/layouts/tile.png"
t.layout_tileleft   = t.dir .. "/layouts/tileleft.png"
t.layout_tilebottom = t.dir .. "/layouts/tilebottom.png"
t.layout_tiletop    = t.dir .. "/layouts/tiletop.png"
t.layout_fairv      = t.dir .. "/layouts/fairv.png"
t.layout_fairh      = t.dir .. "/layouts/fairh.png"
t.layout_spiral     = t.dir .. "/layouts/spiral.png"
t.layout_dwindle    = t.dir .. "/layouts/dwindle.png"
t.layout_max        = t.dir .. "/layouts/max.png"
t.layout_fullscreen = t.dir .. "/layouts/fullscreen.png"
t.layout_magnifier  = t.dir .. "/layouts/magnifier.png"
t.layout_floating   = t.dir .. "/layouts/floating.png"
-- }}}

-- {{{ Widget icons
t.widget_cpu    = t.dir .. "/icons/cpu.png"
t.widget_bat    = t.dir .. "/icons/bat.png"
t.widget_mem    = t.dir .. "/icons/mem.png"
t.widget_fs     = t.dir .. "/icons/disk.png"
t.widget_net    = t.dir .. "/icons/down.png"
t.widget_netup  = t.dir .. "/icons/up.png"
t.widget_mail   = t.dir .. "/icons/mail.png"
t.widget_vol    = t.dir .. "/icons/vol.png"
t.widget_org    = t.dir .. "/icons/cal.png"
t.widget_date   = t.dir .. "/icons/time.png"
t.widget_crypto = t.dir .. "/icons/crypto.png"
t.widget_temp   = t.dir .. "/icons/temp.png"
t.widget_next   = t.dir .. "/icons/next.png"
t.widget_paly   = t.dir .. "/icons/paly.png"
-- }}}


-- {{{ Titlebar
t.titlebar_close_button_focus               = t.dir .. "/titlebar/close_focus.png"
t.titlebar_close_button_normal              = t.dir .. "/titlebar/close_normal.png"
t.titlebar_ontop_button_focus_active        = t.dir .. "/titlebar/ontop_focus_active.png"
t.titlebar_ontop_button_normal_active       = t.dir .. "/titlebar/ontop_normal_active.png"
t.titlebar_ontop_button_focus_inactive      = t.dir .. "/titlebar/ontop_focus_inactive.png"
t.titlebar_ontop_button_normal_inactive     = t.dir .. "/titlebar/ontop_normal_inactive.png"
t.titlebar_sticky_button_focus_active       = t.dir .. "/titlebar/sticky_focus_active.png"
t.titlebar_sticky_button_normal_active      = t.dir .. "/titlebar/sticky_normal_active.png"
t.titlebar_sticky_button_focus_inactive     = t.dir .. "/titlebar/sticky_focus_inactive.png"
t.titlebar_sticky_button_normal_inactive    = t.dir .. "/titlebar/sticky_normal_inactive.png"
t.titlebar_floating_button_focus_active     = t.dir .. "/titlebar/floating_focus_active.png"
t.titlebar_floating_button_normal_active    = t.dir .. "/titlebar/floating_normal_active.png"
t.titlebar_floating_button_focus_inactive   = t.dir .. "/titlebar/floating_focus_inactive.png"
t.titlebar_floating_button_normal_inactive  = t.dir .. "/titlebar/floating_normal_inactive.png"
t.titlebar_maximized_button_focus_active    = t.dir .. "/titlebar/maximized_focus_active.png"
t.titlebar_maximized_button_normal_active   = t.dir .. "/titlebar/maximized_normal_active.png"
t.titlebar_maximized_button_focus_inactive  = t.dir .. "/titlebar/maximized_focus_inactive.png"
t.titlebar_maximized_button_normal_inactive = t.dir .. "/titlebar/maximized_normal_inactive.png"


return t
