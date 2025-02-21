-- (karlr 2022-12-31)
function PutMarkdownTableDivider()
    local fname = 'PutMarkdownTableDivider'

    -- -- OLD (karlr 2023-12-25)
    --  # link
    --  - url: <https://vi.stackexchange.com/questions/31189/how-can-i-get-the-current-cursor-position-in-lua>
    -- local currentRowNum = vim.api.nvim__buf_stats(0).current_lnum

    local currentRowNum, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local prevRow = vim.fn.getline(currentRowNum - 1)

    local captures = {}
    local t = {}

    for value in string.gmatch(prevRow, [[(|[^|]*)]]) do
        table.insert(captures, string.match(value, [[|([^|]*)]]))
    end

    for i = 1, #captures - 1 do
        table.insert(t, captures[i])
    end

    local lead = string.match(prevRow, [[[^|]*]])
    local outStr = string.rep(' ', string.len(lead)) .. '|'

    for _, value in pairs(t) do
        outStr = outStr .. string.rep('-', string.len(value)) .. '|'
    end

    vim.api.nvim_put({ outStr }, 'c', true, true)
end

vim.api.nvim_create_user_command(
    'Mdvinc',
    function() PutMarkdownTableDivider() end,
    { nargs = 0 }
)

