local M = {}

local subscript_digits = { "₀", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉" }

function M.format_subscript(num)
  local ret = ""
  repeat
    ret = subscript_digits[1 + num % 10] .. ret
    num = math.floor(num / 10)
  until num == 0
  return ret
end

function M.bind(keys, val)
  local key = type(keys) == "table" and table.concat(keys, " + ") or keys
  if type(val) == "table" then
    hl.bind(key, val[1], val[2]) -- with opts
  else
    hl.bind(key, val)
  end
end

return M
