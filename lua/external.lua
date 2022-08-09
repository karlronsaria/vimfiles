-- @param cmd string
-- @return string array
function RunExternal(cmd)
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
    return RunExternal('powershell.exe -Command "' .. cmd .. '"')
end

-- @param lines string array
-- @param delim string
-- @return string
function ToSingleLine(lines, delim)
    str = ""

    for _, value in pairs(lines) do
        str = str .. value .. delim
    end

    return str
end
