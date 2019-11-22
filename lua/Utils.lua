Utils = {}

function Utils.Serialize(obj)
    local str = ''
    local t = type(obj)
    if t == 'number' then
        str = str .. obj
    elseif t == 'boolean' then
        str = str .. tostring(obj)
    elseif t == 'string' then
        str = str .. string.format('%q', obj)
    elseif t == 'table' then
        str = str .. '{\n'
        for k, v in pairs(obj) do
            str = str .. '[' .. Utils.Serialize(k) .. '] = ' .. Utils.Serialize(v) .. ',\n'
        end
        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == table then
            for k, v in pairs(metatable.__index) do
                str = str .. '[' .. Utils.Serialize(k) .. '] = ' .. Utils.Serialize(v) .. ',\n'
            end
        end
        str = str .. '}'
    end
    return str
end

function Utils.Deserialize(str)
    local t = type(str)
    if t == nil or t == '' then
        return nil
    elseif t == 'number' or t == 'string' or t == 'boolean' then
        str = tostring(str)
    else
        error('Deserialize Fail')
    end

    str = 'return ' .. str
    local func = load(str)
    if func == nil then
        return nil
    end
    return func()
end

return Utils