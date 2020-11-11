os.setlocale("ru_RU.UTF-8")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

local my_widgets = require("my_widgets")

require("awful.autofocus")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
modkey = "Mod4"
homedir = os.getenv("HOME")

settings = {
    ["theme"] = gears.filesystem.get_themes_dir() .. "zenburn/theme.lua",
    ["wallpaper"]  = homedir .. "/.wall.jpg",
	["apps"]  = {
		["terminal"]    = "urxvt",
        -- ["browser"]     = "sh -c 'chromium-browser --force-device-scale-factor=1 || chromium --force-device-scale-factor=1'",
		["browser"]     = "sh -c 'chromium-browser || chromium'",
		["mail"]        = "thunderbird",
		["filemgr"]     = "urxvt -e 'ranger'",
		["music"]       = "deadbeef",
		["im"]          = "telegram-desktop",
		["pass"]        = "keepassxc",
		["vbox"]        = "VirtualBox",
		["notepad"]     = "leafpad",
		["torrent"]     = "qbittorrent",
        ["screenshot"]  = "sh -c 'sleep 0.1 && scrot --select'",
	},

	["tags"] = {
		{
			name = "web",
			layout = awful.layout.suit.max,
			rules = {
                rule_any = {
                    class = {
                        "firefox", "chrome", "Chromium", "KeePassXC",
                    },
                },
				properties = {
					border_width = 0
				},
		    }
		},

		{
			name = "file",
			layout = awful.layout.suit.tile.bottom,
			rules = {
                rule_any = {
                    class = {
                        "Pcmanfm"
                    },
                    name = {
                        "ranger"
                    },
                }
			}
		},

		{
			name = "main",
			layout = awful.layout.suit.tile.bottom,
			rules = {
                rule_any = {
                    class = {
                        "wxmaxima", "wireshark",
                    }
                }
			}
		},

		{
			name = "edit",
			volatile = true,
			layout = awful.layout.suit.tile.bottom,
			rules = {
                rule_any = {
                    class = {
                        "Leafpad", "qtcreator"
                    }
                }
			}
		},

		{
			name = "im",
			volatile = true,
			layout = awful.layout.suit.floating,
			rules = {
                rule_any = {
                    class = {
                        "Slack", "TelegramDesktop", "gajim", "psi", "Skype", "xchat", "pidgin",
                    }
                }
			}
		},

		{
			name = "urxvt",
			volatile = true,
			layout = awful.layout.suit.tile.bottom,
			rules = {
                rule_any = {
                    name = {
                        "urxvt"
                    }
                },
				properties = {
					size_hints_honor = false
				}
			}
		},

		{
			name = "mail",
			volatile = true,
			layout = awful.layout.suit.max,
			rules = {
                rule_any = {
                    class = {
                        "Thunderbird", "Geary", "Mail",
                    }
                },
				properties = {
					border_width = 0
				},
			}
		},

		{
			name = "office",
			volatile = true,
			layout = awful.layout.suit.max,
			rules = {
                rule_any = {
                    class = {
                        "libreoffice", "Zathura",
                    }
                }
			}
		},

		{
			name = "torrent",
			volatile = true,
			layout = awful.layout.suit.max,
			rules = {
                rule_any = {
                    class = {
                        "qBittorrent"
                    }
                }
			}
		},

		{
			name = "media",
			volatile = true,
			layout = awful.layout.suit.floating,
			rules = {
                rule_any = {
                    class = {
                        "audacity", "Deadbeef", "vlc", "mpv",
                    }
                }
			}
		},

		{
			name = "gimp",
			volatile = true,
			layout = awful.layout.suit.floating,
			rules = {
                rule_any = {
                    class = {
                        "Gimp"
                    }
                }
			}
		},
	}
}

-- pcall(function()
dofile(homedir .. "/.awesome.local.lua")
-- end)

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

beautiful.init(settings.theme)
beautiful.border_width = 1
beautiful.bg_normal = "#1f1f1f"
beautiful.fg_normal = "#aaaaaa"
beautiful.bg_focus = "#2f2f2f"
beautiful.font = "Dejavu Sans 9"
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

local function lock_screen()
    awful.spawn("i3lock -c 111111")
    awful.spawn("xset dpms force off")
end

local function lock_and_sleep()
	lock_screen()
	awful.spawn("sudo systemctl suspend")
end

local function move_tag(tag, diff)
    local tag = tag or awful.screen.focused().selected_tag
    if not tag then return end
    local other_tag = tag.screen.tags[tag.index + diff]
    if not other_tag then return end
    local i = tag.index
    tag.index = other_tag.index
    other_tag.index = i
end

-- local orig_hp_tag = awful.rules.high_priority_properties.tag
function awful.rules.high_priority_properties.tag(c, tagname, props)
    -- naughty.notify({ preset = naughty.config.presets.critical,
    --                  title = "new client",
    --                  text = "name:" .. c.name .. " | class:" .. c.class })

	local tag = awful.tag.find_by_name(c.screen, tagname)
    local layout = awful.layout.suit.tile.bottom
    local index = nil
	if tag == nil then
		for _, v in ipairs(settings.tags) do
			if v.name == tagname then
				layout = v.layout
                break
            else
                local t = awful.tag.find_by_name(c.screen, v.name)
                if t ~= nil then
                    index = t.index + 1
                end
			end
		end
        tag = awful.tag.add(tagname, {screen=c.screen, volatile=true, layout=layout, index=index})
    end

    c:tags{ tag }
    tag:view_only()
    -- orig_hp_tag(c, tag, props)
end
-- }}}

-- {{{ Wibar
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t) if client.focus then client.focus:move_to_tag(t) end end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t) if client.focus then client.focus:toggle_tag(t) end end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
            c.first_tag:view_only()
        end
        -- -- This will also un-minimize
        -- -- the client, if needed
        client.focus = c
        c:raise()
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

local function set_wallpaper(s)
    gears.wallpaper.set("#333333")
    pcall(function() gears.wallpaper.maximized(settings.wallpaper, s, true) end)
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local widgets = my_widgets.init(beautiful, settings)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    s.mypromptbox = awful.widget.prompt()
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
	   awful.button({ }, 1, function () awful.layout.inc( 1) end),
	   awful.button({ }, 3, function () awful.layout.inc(-1) end),
	   awful.button({ }, 4, function () awful.layout.inc( 1) end),
	   awful.button({ }, 5, function () awful.layout.inc(-1) end))
	)

    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons, false, function (w, buttons, label, data, objects)
        for i, o in ipairs(objects) do
            o.tag_pos = i
        end
        local label_func = function(t, args)
            local text, bg_color, bg_image, icon, other_args = awful.widget.taglist.taglist_label(t, args)
            local new_text = "<span color='#666666' font='monospace 6'>" .. tostring(t.tag_pos) .. "</span> " .. text
            return new_text, bg_color, bg_image, icon, other_args
        end
        return awful.widget.common.list_update(w, buttons, label_func, data, objects)
    end)

    -- Each screen has its own tag table.
	local tags = {}
	local layouts = {}
	for _, v in ipairs(settings.tags) do
		if v.volatile ~= true then
			table.insert(tags, v.name)
			table.insert(layouts, v.layout)
		end
	end

	awful.tag(tags, s, layouts)

	s.top_wibox    = awful.wibar({ position = "top", screen = s })
	s.top_wibox:setup {
        layout = wibox.layout.align.horizontal,
		s.mypromptbox,
        s.mytasklist, -- Middle widget
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
	}

	local w = {layout = wibox.layout.fixed.horizontal}
    for key = 1, #widgets do
		table.insert(w, widgets[key].result)
    end

    s.bottom_wibox = awful.wibar({ position = "bottom", screen = s, bg = "#000000ff" })
	s.bottom_wibox:setup {
        layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
		},
		{ layout = wibox.layout.align.horizontal },
		w
	}

end)
-- }}}


-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    -- Tag navigate
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev), -- view previous (tag)
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext), -- view next (tag)
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore), -- go back (tag)

    -- Move tag
    awful.key({ modkey, "Control" }, "Left",  function() move_tag(nil, -1) end),
    awful.key({ modkey, "Control" }, "Right", function() move_tag(nil, 1) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end), -- swap with next client by index (client)
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end), -- swap with previous client by index (client)
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end), -- focus the next screen (screen)
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end), -- focus the previous screen (screen)
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto), -- jump to urgent client (client)
    awful.key({ modkey,           }, "Tab", function ()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end), -- go back (client)

    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end), -- focus next by index (client)
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end), -- focus previous by index (client)

    awful.key({ modkey, }, "`", function ()
        local cl = nil
        for c in awful.client.iterate(function (c)
            return c.instance == "QuakeDD"
        end) do
            if c.hidden == true then
                c.hidden = false
                client.focus = c
            else
                c.hidden = true
            end
            cl = c
        end
        if not cl then
            awful.spawn("urxvt -name QuakeDD")
        end
    end),

    awful.key({ }, "XF86MonBrightnessUp", function () my_widgets.bright_change(1) end),
    awful.key({ }, "XF86MonBrightnessDown", function () my_widgets.bright_change(-1) end),
    awful.key({ }, "XF86AudioMute", function () my_widgets.volume_change(0) end),
    awful.key({ }, "XF86AudioRaiseVolume", function () my_widgets.volume_change(1) end),
    awful.key({ }, "XF86AudioLowerVolume", function () my_widgets.volume_change(-11) end),

    -- Standard program
    awful.key({ modkey, }, "F2", function () awful.spawn(settings.apps.mail) end),
    awful.key({ modkey, }, "F3", function () awful.spawn(settings.apps.torrent) end),
    awful.key({ modkey, }, "F4", function () awful.spawn(settings.apps.im) end),
    awful.key({ modkey, }, "F5", function () awful.spawn(settings.apps.vbox) end),
    awful.key({ modkey, }, "q", function () awful.spawn(settings.apps.browser) end),
    awful.key({ modkey, }, "n", function () awful.spawn(settings.apps.notepad) end),
    awful.key({ modkey, }, "d", function () awful.spawn(settings.apps.music) end),
    awful.key({ modkey, }, "e", function () awful.spawn(settings.apps.filemgr) end),
    awful.key({ modkey, }, "p", function () awful.spawn(settings.apps.pass) end),
    awful.key({ },     "Print", function () awful.spawn(settings.apps.screenshot) end),
    awful.key({ modkey, }, "Return", function () awful.spawn(settings.apps.terminal) end),
    awful.key({ modkey, }, "F12", function() lock_and_sleep() end),
    awful.key({ "Ctrl" }, "Delete", function() lock_screen() end),

    awful.key({ modkey, "Control" }, "r", function()
        awful.prompt.run({
            prompt = "Restart (type 'yes' to confirm)? ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = function(t)
                if string.lower(t) == 'yes' then
                    awesome.restart()
                end
            end
        })
    end),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end), -- increase master width factor (layout)
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end), -- decrease master width factor (layout)
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end), -- increase the number of master clients (layout)
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end), -- decrease the number of master clients (layout)
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end), -- increase the number of columns (layout)
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end), -- decrease the number of columns (layout)
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end), -- select next (layout)
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end), -- select previous (layout)

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end), -- run prompt (launcher)

    awful.key({ modkey, "Control" }, "n", function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then client.focus = c c:raise() end
    end), -- restore minimized (client)


    -- Move to tag
    awful.key({ modkey, "Shift"}, "Left", function()
	  if client.focus then
		  local tag = awful.screen.focused().selected_tag
		  if not tag then return end
		  local new_tag = client.focus.screen.tags[tag.index-1]
		  if new_tag then
			  client.focus:move_to_tag(new_tag)
			  new_tag:view_only()
		  end
	  end
	end),

    awful.key({ modkey, "Shift"}, "Right", function()
	  if client.focus then
		  local tag = awful.screen.focused().selected_tag
		  if not tag then return end
		  local new_tag = client.focus.screen.tags[tag.index+1]
		  if new_tag then
			  client.focus:move_to_tag(new_tag)
			  new_tag:view_only()
		  end
	  end
	end),

	--move selected client to new tag
    awful.key({ modkey, }, "a", function()
		local c = client.focus
		if not c then return end

        local t = awful.tag.add(string.lower(c.class), {screen=c.screen, volatile=true, layout=awful.layout.suit.tile.top})
        c:tags({t})
        t:view_only()
	end),

	--delete tag
    awful.key({ modkey, "Shift"}, "d", function()
		local t = awful.screen.focused().selected_tag
		if not t then return end
        t:delete()
	end),

	--rename tag
    awful.key({ modkey, "Shift"}, "r", function()
		local s = awful.screen.focused()
		local tag = s.selected_tag
		if not tag then return end
		awful.prompt.run {
            ul_cursor = "single",
            text = tag.name,
            selectall = true,
            --from awful/widget/common.lua: list_update
			textbox = s.mytaglist.children[tag.index].widget.children[2].widget,
			exe_callback = function(new_name)
				if not new_name or #new_name == 0 then return end
				tag.name = new_name
			end
		}
		end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen c:raise() end), -- toggle fullscreen (client)
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end), -- close (client)
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ), -- toggle floating (client)
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end), -- move to master (client)
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end), -- move to screen (client)
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end), -- toggle keep on top (client)
    awful.key({ modkey,           }, "m",      function (c) c.maximized = not c.maximized c:raise() end), -- (un)maximize (client)
    awful.key({ modkey, "Shift"   }, "t",      function(c) c.border_width=1 awful.titlebar.toggle(c) end),
    awful.key({ modkey,           }, "s",      function (c) c.ontop = true c.floating = true c.sticky = not c.sticky  end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    {
        rule_any = {
            class = {
                "KeePassXC",
            },
        },
        properties = {
            floating = true,
        },
    },
    {
        rule_any = {
            class = {
                "mpv",
            },
        },
        properties = {
            fullscreen = true,
        },
    },
    {
        rule_any = {
            instance = {
                "QuakeDD"
            },
        },
        properties = {
            floating = true,
            sticky = true,
            ontop = true,
            above = true,
            skip_taskbar = true,
            width = 2560,
            height = 400,
        }
    }
}

for _, v in ipairs(settings.tags) do
    if v.rules.properties == nil then
        v.rules.properties = {}
    end
    v.rules.properties.tag=v.name
    v.rules.properties.switchtotag=true
	table.insert(awful.rules.rules, v.rules)
end

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

local function webtopbar(c)
    local s = c.screen
    if s == nil or s.top_wibox == nil then return end
    local webtag = awful.tag.find_by_name(s, "web")

    s.top_wibox.visible = not (webtag.selected and #s.clients == 1)

    for _, cl in ipairs(s.clients) do
        if cl.floating or (#s.clients > 1 and not webtag.selected) then
            cl.border_width = 1
        else
            cl.border_width = 0
        end
    end
end
awful.tag.attached_connect_signal(nil, "property::selected", webtopbar)
client.connect_signal("tagged", webtopbar)
client.connect_signal("untagged", webtopbar)

screen.connect_signal("removed", function(s)
	for _, c in ipairs(s.all_clients) do
		c:move_to_screen()
        awful.rules.apply(c)
	end
end)
-- }}}
