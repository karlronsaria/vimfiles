local psapp = "pwsh"

-- @param cmd string
-- @return string array
function RunExternal(cmd)
    -- prepare DOS string
    cmd = cmd:gsub("&", "^&")

    local pipe = io.popen(cmd)
    local outputs = {}

    for output in pipe:lines() do
        table.insert(outputs, output)
    end

    return outputs
end

-- @param cmd string
-- @return string
function RunPowerShell(cmd)
    return RunExternal(psapp .. ' -Command "' .. cmd .. '"')
end

-- @param cmd string
-- @return string
function RunPowerShellNoProfile(cmd)
    return RunExternal(psapp .. ' -NoProfile -Command "' .. cmd .. '"')
end

-- @param cmd string
-- @return string
function RunElevatedPowerShell(cmd)
    return RunExternal('sudo ' .. psapp .. ' -Command "' .. cmd .. '"')
end

-- @param cmd string
-- @return string
function OpenPowerShell(cmd)
    return os.execute(psapp .. ' -NoExit -Command "' .. cmd .. '"')
end

-- @param lines string array
-- @param delim string
-- @return string
function Join(delim, lines)
    local str = ""

    for _, value in pairs(lines) do
        str = str .. value .. delim
    end

    return str
end

