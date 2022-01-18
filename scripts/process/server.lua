local process = Process("server")

process.onSetup(function(this)


    Player(1).server().save("hello", 1)

    Player(1).server().save("hello", "you")

    Player(1).server().save("hello", true)

    Player(1).server().clear("hello")

    local t = time.setInterval(1.51, function()
        dump(japi.DzAPI_Map_GetServerValue(Player(1).handle(), "hello"))
    end)
    this.stage("t", t)
end)

process.onDestroy(function(this)
    this.stage("t").destroy()
end)

