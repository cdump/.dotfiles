-- cutter.lua - cut a segment out of the current file into a new file next to it
--
-- Install to:  ~/.config/mpv/scripts/cutter.lua
--
-- Options (mpv.conf):  script-opts=cutter-mode=copy,cutter-suffix=_cut
--   mode = copy   - no re-encoding, cut points snap to keyframes
--   mode = encode - frame accurate, video is re-encoded (x264 crf 16)

local mp    = require 'mp'
local utils = require 'mp.utils'
local msg   = require 'mp.msg'

local opts = {
    mode   = "copy",
    suffix = "_cut",
}
require('mp.options').read_options(opts, "cutter")

local start_pos = nil
local timer     = nil
local overlay   = mp.create_osd_overlay("ass-events")

local function hms(t)
    local h = math.floor(t / 3600)
    local m = math.floor(t % 3600 / 60)
    return string.format("%02d:%02d:%06.3f", h, m, t % 60)
end

local function tag(t) -- time for output filename
    return (hms(t):gsub("[:%.]", "-"))
end

local function exists(p)
    return utils.file_info(p) ~= nil
end

local function source_path()
    local p = mp.get_property("path")
    if not p or p:find("://") then return nil end   -- only local files
    if p:sub(1, 1) ~= "/" then
        p = utils.join_path(mp.get_property("working-directory", ""), p)
    end
    return p
end

local function dest_path(src, a, b)
    local dir, file = utils.split_path(src)
    local base, ext = file:match("^(.+)%.([^.]+)$")
    if not base then base, ext = file, "mkv" end
    local i = 0
    while true do
        local name = string.format("%s%s_%s_%s%s.%s",
            base, opts.suffix, tag(a), tag(b), i > 0 and ("-" .. i) or "", ext)
        local p = utils.join_path(dir, name)
        if not exists(p) then return p end
        i = i + 1
    end
end

local function draw()
    if not start_pos then return end
    local now = mp.get_property_number("time-pos") or start_pos
    overlay.data = string.format(
        "{\\an7}{\\fs28}{\\bord2}{\\c&H4040FF&}\226\151\143 CUT  %s \226\134\146 %s   (%.1f s)",
        hms(start_pos), hms(now), math.max(0, now - start_pos))
    overlay:update()
end

local function clear()
    start_pos = nil
    if timer then timer:kill(); timer = nil end
    overlay:remove()
end

local function run_ffmpeg(src, dst, a, b)
    local args
    if opts.mode == "encode" then
        args = { "ffmpeg", "-nostdin", "-hide_banner", "-loglevel", "error", "-y",
                 "-ss", string.format("%.3f", a), "-to", string.format("%.3f", b),
                 "-i", src,
                 "-map", "0:v:0", "-map", "0:a?", "-map", "0:s?",
                 "-c:v", "libx264", "-crf", "16", "-preset", "medium",
                 "-c:a", "copy", "-c:s", "copy",
                 dst }
    else
        args = { "ffmpeg", "-nostdin", "-hide_banner", "-loglevel", "error", "-y",
                 "-ss", string.format("%.3f", a), "-to", string.format("%.3f", b),
                 "-i", src,
                 "-map", "0", "-c", "copy", "-avoid_negative_ts", "make_zero",
                 dst }
    end

    local _, name = utils.split_path(dst)
    mp.osd_message("ffmpeg: " .. name .. " …", 5)

    mp.command_native_async({
        name          = "subprocess",
        playback_only = false,      -- do not kill process when unpaused
        capture_stdout = true,
        capture_stderr = true,
        args          = args,
    }, function(ok, res, err)
        if ok and res and res.status == 0 then
            mp.osd_message("Finished: " .. name, 4)
        else
            local e = (res and res.stderr or "") .. (err and tostring(err) or "")
            msg.error(e)
            mp.osd_message("ffmpeg error", 5)
        end
    end)
end

local function toggle()
    local pos = mp.get_property_number("time-pos")
    if not pos then return end

    if not start_pos then
        if not source_path() then
            mp.osd_message("Only local files", 2)
            return
        end
        start_pos = pos
        timer = mp.add_periodic_timer(0.2, draw)
        draw()
    else
        local a, b = start_pos, pos
        clear()
        if b - a < 0.05 then
            mp.osd_message("Empty - canceled", 2)
            return
        end
        local src = source_path()
        run_ffmpeg(src, dest_path(src, a, b), a, b)
    end
end

local function cancel()
    if not start_pos then return end
    clear()
    mp.osd_message("Canceled", 2)
end

mp.add_key_binding(nil, "cut-toggle", toggle)
mp.add_key_binding(nil, "cut-cancel", cancel)
mp.register_event("start-file", clear)
mp.register_event("end-file", clear)
