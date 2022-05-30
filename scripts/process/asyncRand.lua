local process = Process("asyncRand")

process:onStart(function(this)

    local min = 9999
    local max = -9999
    local count = 0
    japi.Refresh("asyncRand", function()
        local a = async.rand(-1000, 1000)
        if (a < min) then
            min = a
        end
        if (a > max) then
            max = a
        end
        count = count + 1
        print(a, count, min, max)
        if (count >= 2000) then
            japi.Refresh("asyncRand", nil)
        end
    end)

end)