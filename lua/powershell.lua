-- @param cmd string
-- @return string array
function RunPowerShell(cmd)
    local pipe = io.popen('powershell.exe -Command "' .. cmd .. '"')
    local outputs = {}

    for output in pipe:lines() do
        table.insert(outputs, output)
    end

    return outputs
end

-- @param lines string array
-- @param delim string
-- @return string
function ToSingleLineString(lines, delim)
    str = ""

    for _, value in pairs(lines) do
        str = str .. value .. delim
    end

    return str
end

-- @param cmd string
-- @return string
function GetPowerShellSingleString(cmd)
    return string.gsub(
        ToSingleLineString(RunPowerShell(cmd), ''),
        '%s+', ''
    )
end

