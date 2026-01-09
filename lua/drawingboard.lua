
-- # DRAWINGBOARD

-- ## 2025-02-14: ?


vim.api.nvim_create_user_command(
    'Dr',
    function()
        print("Hello, world!")
        -- local cmd = ''
        -- for _, value in pairs(GetSystemLinkTable(vim.fn.getline('.'))) do
        --     cmd = "start " .. value
        --     print(cmd)
        --     io.popen(cmd)
        -- end
    end,
    { nargs = 0 }
)






-- ## 2024-10-12: Capturing Visual Mode

function Test()
    -- -- link
    -- -- - url: <https://saintofthe.day/2024/03/13/neovim-lua-visual-select-range/>
    -- -- - retrieved: 2024-10-12
    -- local start_pos = vim.fn.getpos("v") -- start line
    -- local end_pos = vim.fn.getpos(".") -- end line

    local start_pos = vim.fn.getpos("'<") -- start line
    local end_pos = vim.fn.getpos("'>") -- end line

    local line_num = vim.api.nvim_win_get_cursor(0)[1]

    print(line_num)

    local mode = vim.api.nvim_get_mode().mode  -- Get the current mode

    print(mode)

    if mode == '^V' then
        print("Visual block selection is active")
        return true
    end

    -- Check if the mode is one of the visual modes
    if mode == 'v' or mode == 'V' or mode == '' then  -- '' is block visual mode (<C-v>)
      print("Visual selection is active")
      return true
    else
      print("No visual selection")
      return false
    end
end

vim.api.nvim_create_user_command(
  'Test',
  function() Test() end,
  { nargs = 0, range = true }
)

-- link
-- - url: <https://github.com/hrsh7th/nvim-cmp/issues/1017>
-- - retrieved: 2024-10-12
if not table.unpack then
    table.unpack = unpack
end

local modes = {}

vim.api.nvim_create_autocmd("ModeChanged", {
    callback = function()
        -- if #modes > 4 then
        --     modes = {table.unpack(modes, #modes - 3, #modes)}
        -- end

        table.insert(modes, vim.fn.mode())
    end,
    pattern = '*'
})

-- Define a custom command to use the captured mode
vim.api.nvim_create_user_command(
    'Checkpreviousmode',
    function()
        for i, v in pairs(modes) do
            print(v)
        end
    end,
    {
        desc = "Check the mode before command-line mode",
        range = true
    }
)


