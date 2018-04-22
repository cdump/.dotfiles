local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local gears     = require("gears")
local calendar  = require("calendar")
local io        = require("io")
local moex      = require("moex")
local dkjson    = require("dkjson")
local utf8      = require("utf8")

local battery = {}

local timer_weather = gears.timer { timeout = 600 }
local timer_info = gears.timer { timeout = 10 }
local timer_net  = gears.timer { timeout = 1 }

local function exec(cmd, all)
	local ret = '?'
	pcall(function()
		local f = io.popen(cmd)
		ret = f:read(all and "*all" or "*line")
		f:close()
	end)
	return ret
end

local function fg(color, text)
    return '<span color="#995555">' .. text .. '</span>'
end

local function bold(text)
    return '<b>' .. text .. '</b>'
end

local function italic(text)
    return '<i>' .. text .. '</i>'
end

local function get_battery_info()
    local function notify(text)
        naughty.notify {
            opacity = use_composite and beautiful.opacity.naughty or 1,
            title  = "BATTERY infos",
            text   = italic(text),
            margin = 10,
        }
    end

    local state
    local charge = 100
    local time = "AC"

	local line = exec("acpi -b") or ""
	local data = line:match("Battery #?[0-9] *: ([^\n]*)")
    if data ~= nil then
        state = data:match("([%a]*),.*"):lower()
        charge = tonumber(data:match(".*, ([%d]?[%d]?[%d]%.?[%d]?[%d]?)%%"))
        time = data:match(".*, ([%d]?[%d]?:?[%d][%d])")

        if state == "full" or state == "charging" then
            time = "AC"
        end
    end

    if battery.state ~= state then
        notify(state)
    end
    battery.state = state

    if charge <= 10 and time ~= "AC" then
        notify("Low Battery @#@|#!!")
    end

    return {charge or "?", time or "?"}
end

----------------- PUBLIC FUNCTIONS ------------------

function text_widgets_updatetext(name, value)
	widgets[name].update(value)
end

function volume_change(change)
    local current = exec("pactl list sinks|grep -E '^\\s+Volume:' | awk '{print $5}' | tr -d '%'")
    if current == nil then
        return
    end
    current = tonumber(current)

    if change == 0 then
        awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    end


    local muted = exec("pactl list sinks|grep -E '^\\s+Mute:' | awk '{print $2}'")
    if muted == "yes" then
        text_widgets_updatetext("volume", "MT")
        return
    end

    local new = current
    local step = 5
    if change ~= nil then
        if change > 0 then new = current + step end
        if change < 0 then new = current - step end
        if new < 0 then new = 0 end
        if new > 100 then new = 100 end
        if new ~= current then
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ "..new.."%")
        end
    end
	text_widgets_updatetext("volume", new)

end

function bright_change(change)
	local step = 10
	local current = exec("cat /sys/class/backlight/*/brightness")
	local max = exec("cat /sys/class/backlight/*/max_brightness")
	if current == nil then
		return
	end
    current = tonumber(current)

    local new = current * 100 / max
    if change ~= nil then
        current = tonumber(current) * 100 / max
        local new = current + step * (change == 0 and 0 or change/math.abs(change))
        if new < 0 then new = 0 end
        if new > 100 then new = 100 end
        local real_new = math.floor(new * max / 100)
        awful.spawn("bash -c 'echo " .. real_new .. " | sudo tee /sys/class/backlight/*/brightness'")
    end
	text_widgets_updatetext("bright", math.floor(new) .. "%")
end

function update_weather()
    local city = 524901; -- Moscow
    local cmd = "curl --connect-timeout 5 'https://api.openweathermap.org/data/2.5/weather?id="..city.."&appid=c3d7320b359da4e48c2d682a04076576&units=metric'"
    awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
        local obj = dkjson.decode(stdout)
        local temp = '?'
        if obj ~= nil  and obj.main ~= nil then
            temp = math.floor(obj.main.temp)
        end
        widgets.weather.update(temp .. "℃")
    end)
end

----------------- // PUBLIC FUNCTIONS ------------------


return {
    bright_change = bright_change,
    volume_change = volume_change,

    init = function(beautiful, settings)
	widgets = {
        ["netspeed"] = { bg = '#111111', fg = '#888888', ticon='' },
        ["keyboard"] = { bg = '#181818', fg = '#aaaaaa', widget = awful.widget.keyboardlayout() },
        ["quotes"]   = { bg = '#282828', fg = '#aaaaaa' },
        ["weather"]  = { bg = '#111111', fg = '#aaaaaa', ticon='' },
        ["cpu"]      = { bg = '#282828', fg = '#aaaaaa', ticon='龍', },
        ["bright"]   = { bg = '#111111', fg = '#aaaaaa', ticon='' },
        ["volume"]   = { bg = '#282828', fg = '#aaaaaa', ticon='' },
        ["battery"]  = { bg = '#111111', fg = '#aaaaaa', ticon='' },
        ["clock"]    = { bg = '#282828', fg = '#dddddd', widget = wibox.widget.textclock('<span color="#dddddd">%d %B, %a · %H:%M:%S </span>', 1), },

	}


    widgets.netspeed.started = false
	widgets.netspeed.buttons = awful.util.table.join(
		awful.button({ }, 1, function()
            if widgets.netspeed.started then
                timer_net:stop()
                widgets.netspeed.update("")
            else
                timer_net:start()
                timer_net:emit_signal("timeout")
            end
            widgets.netspeed.started = not widgets.netspeed.started
        end)
	)

	widgets.volume.buttons = awful.util.table.join(
		awful.button({ }, 1, function() volume_change(0) end),
		awful.button({ }, 4, function() volume_change(1) end),
		awful.button({ }, 5, function() volume_change(-1) end)
	)

	widgets.bright.buttons = awful.util.table.join(
		awful.button({ }, 1, function() bright_change(-1) end),
		awful.button({ }, 3, function() bright_change(1) end),
		awful.button({ }, 4, function() bright_change(1) end),
		awful.button({ }, 5, function() bright_change(-1) end)
	)

	-- FIXME
	widgets_pos = {}
	table.insert(widgets_pos, widgets.netspeed)
	table.insert(widgets_pos, widgets.keyboard)
	table.insert(widgets_pos, widgets.quotes)
	table.insert(widgets_pos, widgets.weather)
	table.insert(widgets_pos, widgets.cpu)
	table.insert(widgets_pos, widgets.bright)
	table.insert(widgets_pos, widgets.volume)
	table.insert(widgets_pos, widgets.battery)
	table.insert(widgets_pos, widgets.clock)

	local pc = '#000000'
	local powerline_font = "DejaVuSansMono Nerd Font Mono 15"
	for key = 1, #widgets_pos do
		local val = widgets_pos[key]
		local str = string.format('<span color="%s">%%s</span>', val.fg)
		local arr = wibox.widget.textbox("<span font='" .. powerline_font .. "' color='" .. val.bg .. "'> </span>")

		if val.widget == nil then
			val.widget = wibox.widget.textbox()
		end

		val.result = wibox.layout.fixed.horizontal()
		val.result:add( wibox.container.background( arr , pc ) )
		if val.icon ~= nil then
			local icon = wibox.widget.imagebox( val.icon )
			val.result:add( wibox.container.background( icon, val.bg ) )
		end
		if val.ticon ~= nil then
            local ic = wibox.widget.textbox("<span font='" .. powerline_font .. "'>" .. val.ticon .. "</span> ")
			val.result:add( wibox.container.background( ic, val.bg ) )
		end
		val.result:add( wibox.container.background( val.widget, val.bg ) )

		if(val.buttons) then val.result:buttons(val.buttons) end
        val.update = function(text) if text == nil then text = 'nil' end val.widget:set_markup( string.format(str, text) ) end
		if not val.widget then
			val.update('-')
		end
		pc = val.bg
	end

	moex.addToWidget(widgets.quotes.widget, widgets.quotes.update, {
		[1] = {"currency", "EUR_RUB__TOM", "€" },
		[2] = {"currency", "USD000UTSTOM", "$" },
		-- [3] = {"futures", "SiU6", "Si" }
	})

	volume_change(nil);
	bright_change(nil);

	-- DateTime & Calendar
	calendar.addCalendarToWidget(widgets.clock.widget)

	timer_weather:connect_signal("timeout", update_weather)
	timer_weather:start()
	timer_weather:emit_signal("timeout")

	timer_info:connect_signal("timeout", function()
        local freq, temp
        data = get_battery_info()
        widgets.battery.update(data[1] .. '% <span color="#888">|</span> ' .. data[2])
        freq = exec("cat /proc/cpuinfo|grep '^cpu MHz'|awk '{s+=$4;c++;}END{print int(s/c);}'")
        temp = exec("sensors|grep 'Core 0'|awk '{print $3}'|tr -d '+'")
        if freq ~= nil and temp ~= nil then
            widgets.cpu.update(freq .. ' <span color="#888">|</span> ' .. temp)
        end
    end)
	timer_info:start()
	timer_info:emit_signal("timeout")

    local prev_recv = {}
    local prev_send = {}

    local function format_speed(bytes)
        local v = 8*tonumber(bytes)
        local r = v .. " b/s"
        if v >= 1000*1000 then
            r = string.format("%.1f Mb/s", (v/1024/1024))
        else
            if v >= 1000 then
                r = string.format("%.1f kb/s", (v/1024))
            end
        end

        local rl = utf8.len(r)
        if rl < 10 then
            r = r .. string.rep(" ", 10 - rl)
        end
        return "<span font='monospace'>" .. r .. "</span>"
    end

	timer_net:connect_signal("timeout", function()
        local s = ""
        for line in io.lines("/proc/net/dev") do
            local name = string.match(line, "^[%s]?[%s]?[%s]?[%s]?([%w]+):")
            if name ~= nil and name ~= "lo" then
                local recv = tonumber(string.match(line, ":[%s]*([%d]+)"))
                local send = tonumber(string.match(line, "([%d]+)%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+%d+%s+%d$"))

                if prev_recv[name] ~= nil then
                    local rate_recv = recv - prev_recv[name]
                    local rate_send = send - prev_send[name]
                        s = s .. name .. ": ⇩" .. format_speed(rate_recv) .." ⇧"..format_speed(rate_send)
                end

                prev_recv[name] = recv
                prev_send[name] = send

            end
        end
        widgets.netspeed.update(s)
    end)

	return widgets_pos
end
}
