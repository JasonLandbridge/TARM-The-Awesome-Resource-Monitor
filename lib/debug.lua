local debug = {}

function debug:setup_gvv()
    if script.active_mods["gvv"] then
        require("__gvv__.gvv")()
    end
end

return debug
