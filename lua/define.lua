function script_path()
  return debug.getinfo(1).source:match("@?(.*\\)")
end

function source(file)
  vim.cmd('source ' .. script_path() .. file)
end

function special(sequence)
  return vim.api.nvim_eval('"\\' .. sequence .. '"')
end

---
-- link: https://www.notonlycode.org/neovim-lua-config/
-- retrieved: 2022_07_30

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(
    mode, shortcut, command, { noremap = true, silent = true }
  )
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

---

---
-- link: https://stackoverflow.com/questions/42373969/how-to-pass-a-tuple-as-arguments-to-a-lua-function/42375132#42375132
-- retrieved: 2022_07_31

function pack(...)
    return {n = select("#", ...), ...}
end

function execute(cmd)
    local pipe = assert(io.popen(cmd, 'r'))
    pipe:close()
    return pipe
end

function trim(str)
  local newStr, _ = string.gsub(str, '%s+', '')
  return newStr
end

function system(cmd)
  return vim.fn.system(cmd)
end

function replace_current_line(lines)
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, r, r, true, lines)
end

