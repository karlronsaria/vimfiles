require('define')
require('external')

vim.api.nvim_create_user_command(
  'Calendar',
  function()
    local cmd = script_path() .. 'nvim/pwsh/Get-DateStringFromCalendar.ps1'
    local dateStr = ToSingleLine(RunPowerShell(cmd), '')

    if (cmd == '') then
      return
    end

    vim.api.nvim_put({ dateStr }, 'c', true, true)
  end,
  { nargs = 0 }
)

