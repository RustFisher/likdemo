local process = Process("server")

process:onStart(function(this)

    Server(Player(1)):save("hello", 1)
    time.setTimeout(3, function()
        dump(Server(Player(1)):load("hello"))

        Server(Player(1)):save("hello", "you")
        time.setTimeout(3, function()
            dump(Server(Player(1)):load("hello"))

            Server(Player(1)):save("hello", true)
            time.setTimeout(3, function()
                dump(Server(Player(1)):load("hello"))
                Server(Player(1)):clear("hello")
                time.setTimeout(3, function()
                    dump(Server(Player(1)):load("hello"))
                end)
            end)
        end)
    end)

end)

