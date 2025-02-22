--- @since 25.2.7

local function prompt()
	return ya.input {
		title = "Smart filter:",
		position = { "bottom-left", w = 50 },
		realtime = true,
	}
end

local function entry()
	local input = prompt()
    -- ya.manager_emit("escape", { filter = true })
	while true do
		local value, event = input:recv()

        -- 0: Unknown error.
        -- 1: The user has confirmed the input.
        -- 2: The user has canceled the input.
        -- 3: The user has changed the input (only if realtime is true).
		if event ~= 1 and event ~= 3 then
			ya.manager_emit("escape", { filter = true })
			break
		end

        if event == 3 and value == '/' then
			ya.manager_emit("escape", { filter = true })
			ya.input_emit("close", {})
            break
        end

        value = value:gsub("(.)", "%1.*"):sub(1, -3)
		ya.manager_emit("filter_do", { value, smart = true })

        if event == 1 then
            break
        end
	end
end

return { entry = entry }
