-- @return string
function script_path()
  return debug.getinfo(1).source:match("@?(.*\\)")
end

-- @param file string
-- @return void
function source(file)
  if script_path() == nil then
    return
  end

  vim.cmd('source ' .. script_path() .. file)
end

-- @param sequence string
-- @return string|expanded object
function special(sequence)
  return vim.api.nvim_eval('"\\' .. sequence .. '"')
end

---
-- link: https://www.notonlycode.org/neovim-lua-config/
-- retrieved: 2022_07_30

-- @param mode string
-- @param shortcut string
-- @param command string
-- @return void
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(
    mode, shortcut, command, { noremap = true, silent = true }
  )
end

-- @param shortcut string
-- @param command string
-- @return void
function nmap(shortcut, command)
  map('n', shortcut, command)
end

-- @param shortcut string
-- @param command string
-- @return void
function imap(shortcut, command)
  map('i', shortcut, command)
end

-- link: https://stackoverflow.com/questions/42373969/how-to-pass-a-tuple-as-arguments-to-a-lua-function/42375132#42375132
-- retrieved: 2022_07_31

function pack(...)
    return {n = select("#", ...), ...}
end

-- @param cmd string
-- @return userdata
function execute(cmd)
    local pipe = assert(io.popen(cmd, 'r'))
    pipe:close()
    return pipe
end

-- @param str string
-- @return string
function trim(str)
  local newStr, _ = string.gsub(str, '%s+', '')
  return newStr
end

-- @param cmd string
-- @return string
function system(cmd)
  return vim.fn.system(cmd)
end

-- @param lines string array
-- @return void
function replace_current_line(lines)
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, r, r, true, lines)
end

