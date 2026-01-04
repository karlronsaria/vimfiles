function GetDate()
  return os.date("%Y-%m-%d") -- Uses DateTimeFormat
end

function GetDateTime()
  return os.date("%Y-%m-%d-%H%M%S") -- Uses DateTimeFormat
end

function GetWeekDate()
  return os.date("%a %Y-%m-%d") -- Uses DateTimeFormat
end

function AddDays(date_table, num_days)
  local seconds_per_day = 24 * 60 * 60
  return os.date("*t", os.time(date_table) + num_days * seconds_per_day)
end

function GetNextDateDistance(day_code, factor)
  local today = os.date("*t")
  local distance = factor * (day_code - today.wday)

  if distance < 0 then
    distance = 7 + distance
  end

  return distance
end

function GetDayCode(day_trinomial)
  local days = {
    ['sun'] = 1,
    ['mon'] = 2,
    ['tue'] = 3,
    ['wed'] = 4,
    ['thu'] = 5,
    ['fri'] = 6,
    ['sat'] = 7,
  }

  assert(type(days[day_trinomial]) == "number", "Expected number, got " .. type(days[day_trinomial]))
  return days[day_trinomial]
end

function GetNextDateString(day_trinomial, format)
  local day_code = GetDayCode(day_trinomial)
  local distance = GetNextDateDistance(day_code, 1)
  local next = AddDays(os.date("*t"), distance)
  return os.date(format, os.time(next))
end

vim.api.nvim_create_user_command(
  'PutDate',
  function(opts)
    -- vim.api.nvim_put({ GetDate() }, 'c', true, true)
    local format = "%Y-%m-%d"
    local str = #opts.fargs == 0 and os.date(format) or GetNextDateString(opts.fargs[1], format)
    vim.api.nvim_put({ str }, 'c', true, true)
  end,
  { nargs = "?" }
)

vim.api.nvim_create_user_command(
  'PutDateTime',
  function(opts)
    -- vim.api.nvim_put({ GetDateTime() }, 'c', true, true)
    local format = "%Y-%m-%d-%H%M%S"
    local str = #opts.fargs == 0 and os.date(format) or GetNextDateString(opts.fargs[1], format)
    vim.api.nvim_put({ str }, 'c', true, true)
  end,
  { nargs = "?" }
)

vim.api.nvim_create_user_command(
  'PutWeekDate',
  function(opts)
    -- vim.api.nvim_put({ GetWeekDate() }, 'c', true, true)
    local format = "%a %Y-%m-%d"
    local str = #opts.fargs == 0 and os.date(format) or GetNextDateString(opts.args, format)
    vim.api.nvim_put({ str }, 'c', true, true)
  end,
  { nargs = "?" }
)

vim.api.nvim_create_user_command(
  'ClipDate',
  function()
    local date = GetDate()
    vim.fn.setreg('+', date)
    print(":ClipDate: Copied '" .. date .. "' to system clipboard")
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command(
  'ClipDateTime',
  function()
    local date = GetDateTime()
    vim.fn.setreg('+', date)
    print(":ClipDateTime: Copied '" .. date .. "' to system clipboard")
  end,
  { nargs = 0 }
)
