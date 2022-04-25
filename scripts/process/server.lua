local process = Process("server")

process:onStart(function(this)

    Server(Player(1)):putin("hello", 1)
    time.setTimeout(3, function()
        dump(Server(Player(1)):putout("hello"))

        Server(Player(1)):putin("hello", "you")
        time.setTimeout(3, function()
            dump(Server(Player(1)):putout("hello"))

            Server(Player(1)):putin("hello", true)
            time.setTimeout(3, function()
                dump(Server(Player(1)):putout("hello"))
                Server(Player(1)):clear("hello")
                time.setTimeout(3, function()
                    dump(Server(Player(1)):putout("hello"))
                end)
            end)
        end)
    end)
    
end)

