hs.window.animationDuration = 0

hs.hotkey.bind({"cmd"}, "Return", function()
  -- hs.application.launchOrFocus("iTerm")
  hs.execute("open -n -a iTerm")
end)
hs.hotkey.bind({"cmd"}, "P", function()
  hs.application.launchOrFocus("KeePassXC.app")
end)
hs.hotkey.bind({"cmd"}, "Q", function()
  hs.application.launchOrFocus("Google Chrome.app")
end)

hs.hotkey.bind({"Shift"}, "Help", nil, function() -- shift+Insert
  hs.eventtap.event.newKeyEvent("cmd", "v", true):post()
  hs.eventtap.event.newKeyEvent("cmd", "v", false):post()
end)
-- hs.hotkey.bind({"ctrl"}, "a", nil, function()
--   hs.eventtap.event.newKeyEvent("cmd", "a", true):post()
--   hs.eventtap.event.newKeyEvent("cmd", "a", false):post()
-- end)
hs.hotkey.bind({"ctrl"}, "t", nil, function()
  hs.eventtap.event.newKeyEvent("cmd", "t", true):post()
  hs.eventtap.event.newKeyEvent("cmd", "t", false):post()
end)

hs.hotkey.bind({"cmd", "shift"}, "C", function()
    local cwin = hs.window.focusedWindow()
    -- if cwin then cwin:close() end
    if cwin then cwin:application():kill() end
end)
hs.hotkey.bind({"cmd", "shift"}, "F", function()
    local cwin = hs.window.focusedWindow()
    if cwin then cwin:toggleFullScreen() end
end)
hs.hotkey.bind({"cmd"}, "M", function()
    local cwin = hs.window.focusedWindow()
    -- if cwin then cwin:maximize() end
    if cwin then
        cwin:setTopLeft(hs.geometry.rect(-3,0,0,0))
        cwin:setSize(hs.geometry.size(1923,1080))
        cwin:setTopLeft(hs.geometry.rect(0,0,0,0))
    end
end)

hs.hotkey.bind({"cmd"}, "n", function()
    hs.window.tiling.tileWindows(hs.window.allWindows(), hs.mouse.getCurrentScreen():frame())
end)

local SkyRocket = hs.loadSpoon("SkyRocket")
sky = SkyRocket:new({
  opacity = 0.75,
  moveModifiers = {'cmd'},
  moveMouseButton = 'left',
  resizeModifiers = {'cmd'},
  resizeMouseButton = 'right',
})


function reloadConfig(files)
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then hs.reload() return end
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon config loaded")
