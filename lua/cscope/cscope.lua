M = {}
local pid = -1
local action_to_option = {
    ["a"] = "9",
    ["c"] = "3",
    ["d"] = "2",
    ["e"] = "6",
    ["f"] = "7",
    ["g"] = "1",
    ["i"] = "8",
    ["s"] = "0",
    ["t"] = "4",
}

M.cscopeprg = "cscope"
M.execute_find = function(action, pattern, callback)
    local stdout = vim.loop.new_pipe(false)
    local handle, pid = vim.loop.spawn(M.cscopeprg, {
        args = { "-L" .. action_to_option[action], pattern },
        stdio = { nil, stdout, nil }
    },
        vim.schedule_wrap(function()
            stdout:read_stop()
            stdout:close()
        end
        )
    )
    vim.loop.read_start(stdout, function(err, data)
        if err then
            print(err)
            return
        end
        if data then
            local entries = vim.split(data, "\n")
            for _, entry in pairs(entries) do
                callback(entry)
            end
        end
    end)
end
return M
