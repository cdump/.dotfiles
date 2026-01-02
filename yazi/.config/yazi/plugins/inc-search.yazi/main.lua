--- @since 25.12.29

local function prompt()
  return ya.input {
    title = "Smart filter:",
    pos = { "bottom-left", w = 50 },
    realtime = true,
  }
end

local function entry()
  local input = prompt()
  while true do
    local value, event = input:recv()

    -- 0: Unknown error.
    -- 1: The user has confirmed the input.
    -- 2: The user has canceled the input.
    -- 3: The user has changed the input (only if realtime is true).
    if event ~= 1 and event ~= 3 then
      ya.emit("escape", { filter = true })
      break
    end

    if event == 3 and value == '/' then
      ya.emit("escape", { filter = true })
      ya.emit("input:close", {})
      break
    end

    value = value:gsub("(.)", "%1.*"):sub(1, -3)
    ya.emit("filter_do", { value, smart = true })

    if event == 1 then
      break
    end
  end
end

return { entry = entry }
