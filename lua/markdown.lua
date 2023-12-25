-- (karlr 2022_12_31)
function PutMarkdownTableDivider()
    local fname = 'PutMarkdownTableDivider'

    -- -- OLD (karlr 2023_12_25)
    --  # link
    --  - url: <https://vi.stackexchange.com/questions/31189/how-can-i-get-the-current-cursor-position-in-lua>
    --  - retrieved: 2023_12_25
    -- local currentRowNum = vim.api.nvim__buf_stats(0).current_lnum
    local currentRowNum, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local prevRow = vim.fn.getline(currentRowNum - 1)

    print('Previous number: ' .. currentRowNum)
    print('Previous row: ' .. prevRow)

    local leadingWhitespace = string.match(prevRow, [[%s*]])

    -- -- non-whitespace
    -- local pattern = [[(|%s*[^|]*)%s*]]

    local pattern = [[(|[^|]*)]]
    local captures = string.gmatch(prevRow, pattern)
    local valid = false
    local t = {}

    for value in captures do
        endBar = not (string.match(value, [[^%s*|%s*$]]) == nil)

        if (not endBar) then
            -- -- non-whitespace
            -- table.insert(t, string.match(value, [[|%s*([^|]+)%s*]]))

            table.insert(t, string.match(value, [[|([^|]+)]]))
        end
    end

    local outStr = leadingWhitespace .. '|'

    if endBar then
        for _, value in pairs(t) do
            outStr = outStr .. string.rep('-', string.len(value)) .. '|'
        end
    end

    vim.api.nvim_put({ outStr }, 'c', true, true)
end

vim.api.nvim_create_user_command(
  'Mdvinc',
  function() PutMarkdownTableDivider() end,
  { nargs = 0 }
)

