-- karlr (2022_12_31)
function PutMarkdownTableDivider()
    local fname = 'PutMarkdownTableDivider'

    local currentRowNum = vim.api.nvim__buf_stats(0).current_lnum
    local prevRow = vim.fn.getline(currentRowNum - 1)

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

-- @param line string
-- @return table
function GetMarkdownLinkTable(line)
  local dir = vim.fn.expand('%:p:h')
  local path = ''
  local exist = 0
  local myTable = {}

  for value in string.gmatch(line, "[^()%s]+") do
    path = value
    exist = vim.fn.filereadable(path)

    if exist == 0 then
      path = dir .. '/' .. value
      exist = vim.fn.filereadable(path)
    end

    if exist == 1 then
      table.insert(myTable, path)
    end
  end

  return myTable
end

vim.api.nvim_create_user_command(
  'Mdvinc',
  function() PutMarkdownTableDivider() end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'Mdlink',
  function()
    for key, value in pairs(GetMarkdownLinkTable(vim.fn.getline('.'))) do
      print('Mdlink: ' .. value)
    end
  end,
  { nargs = 0 }
)
