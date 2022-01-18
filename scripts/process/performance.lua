local process = Process("performance")

process.onSetup(function(this)

    collectgarbage("collect")
    local x1 = os.clock()
    local r1 = collectgarbage("count")

    for _ = 1, 1000 do
        Ability(TPL_ABILITY.AB1).destroy()
    end

    print(string.format("Time: %.6f", os.clock() - x1))
    print(string.format("Ram: %.6f MB", (collectgarbage("count") - r1) / 1024))

end)