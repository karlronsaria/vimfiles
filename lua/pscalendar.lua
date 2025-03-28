require('define')
require('run')

vim.api.nvim_create_user_command(
  'Calendar',
  function()
    local cmd = script_path() .. 'pwsh/Get-DateStringFromCalendar.ps1'

    if ('' == cmd) then
      return
    end

    local dateStr = Join('', RunPowerShellNoProfile(cmd))

    print(dateStr)

    -- (karlr 2025-03-28): Hyphens need to be escaped ``%-``
    local start, len = string.find(dateStr, '%d%d%d%d%-%d%d%-%d%d') -- Uses DateTimeFormat

    if (nil == start) then
        return
    end

    dateStr = string.sub(dateStr, start, len)
    vim.api.nvim_put({ dateStr }, 'c', true, true)
  end,
  { nargs = 0 }
)

