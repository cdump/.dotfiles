local M = {}

local colors = { '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF' }
local highlight_prefix = 'WordMark'


local active_matches = {}
local pos = 0

for i, c in ipairs(colors) do
    vim.cmd('highlight ' .. highlight_prefix .. i .. ' guibg=' .. c .. ' guifg=Black')
end

function M.toggle()
    local cword = vim.fn.expand("<cword>")
    if cword == "" then
        return
    end
    local match = active_matches[cword]
    if match ~= nil then
        vim.fn.matchdelete(match[2])
        if match[1] == pos then
            pos = pos - 1
        end
        active_matches[cword] = nil
    else
        pos = 1 + (pos % #colors)
        active_matches[cword] = { pos, vim.fn.matchadd(highlight_prefix .. pos, cword) }
    end
end

return M
