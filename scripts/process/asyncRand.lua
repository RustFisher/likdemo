local process = Process("asyncRand")

process:onStart(function(this)

    local min = 9999
    local max = -9999
    japi.Refresh("asyncRand", function()
        local a = async.rand(-1000, 1000)
        if (a < min) then
            min = a
        end
        if (a > max) then
            max = a
        end
        print(a, min, max)
    end)

end)