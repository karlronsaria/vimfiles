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

function notifyFollowLinkInVsCode()
    if is_in_vscode() then
        print("(karlr 2024-09-25): That sequence does not work in VsCode")
    else
        print("Nah, it'll work.")
    end
end

vim.api.nvim_create_user_command(
  'Isvscode', isThisVsCode, { nargs = 0 }
)

-- -- (karlr 2024-09-25): interferes with the original binding
-- vim.api.nvim_set_keymap(
--     'n', 'gf',
--     ':lua notifyFollowLinkInVsCode()<CR>',
--     { noremap = true, silent = false }
-- )

