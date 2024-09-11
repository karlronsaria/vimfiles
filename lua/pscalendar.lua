require('define')
require('run')

vim.api.nvim_create_user_command(
  'Calendar',
  function()
    local cmd = script_path() .. 'nvim/pwsh/Get-DateStringFromCalendar.ps1'

    if ('' == cmd) then
      return
    end

    local dateStr = Join('', RunPowerShell(cmd))

    print(dateStr)
    local start, len = string.find(dateStr, '%d%d%d%d_%d%d_%d%d')

    if (nil == start) then
        return
    end

    dateStr = string.sub(dateStr, start, len)
    vim.api.nvim_put({ dateStr }, 'c', true, true)
  end,
  { nargs = 0 }
)

