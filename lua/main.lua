local cs = require("cscope")


vim.keymap.set(
    "n",
    "<F7>",
    function()
        local action = "g"
        cs.execute_find(action, "security_cred_free", function(data)
            print(data)
        end)
    end
)
