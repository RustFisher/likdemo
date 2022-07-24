local process = Process("array")

process:onStart(function(this)

    local a = Array()
    a:set("q", 1)
    a:set("w", 2)
    a:set("e", 3)
    a:set("r", 4)

    print("========")
    dump(a)
    a:forEach(function(key, value)
        print("1=", key, value)
        a:forEach(function(k2, v2)
            print("2=", k2, v2)
            --a:set(k2, nil)
        end)
        a:set(key, nil)
    end, true)
    dump(a)

end)