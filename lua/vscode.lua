function is_in_vscode()
    return vim.fn.getenv("VSCODE_PID") ~= vim.NIL
end

function isThisVsCode()
    if is_in_vscode() then
        print("Neovim is running in VsCode")
    else
        print("Neovim is running from the command line")
    end
end

vim.api.nvim_create_user_command(
  'Isvscode', isThisVsCode, { nargs = 0 }
)

