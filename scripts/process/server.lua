local process = Process("server")

process:onStart(function(this)

    Server(Player(1)):write("hello", 1)
    time.setTimeout(3, function()
        dump(Server(Player(1)):read("hello"))

        Server(Player(1)):write("hello", "you")
        time.setTimeout(3, function()
            dump(Server(Player(1)):read("hello"))

            Server(Player(1)):write("hello", true)
            time.setTimeout(3, function()
                dump(Server(Player(1)):read("hello"))
                Server(Player(1)):erase("hello")
                time.setTimeout(3, function()
                    dump(Server(Player(1)):read("hello"))
                end)
            end)
        end)
    end)
    
end)

