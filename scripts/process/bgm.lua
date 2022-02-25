local process = Process("bgm")

process:onStart(function(this)

    async(Player(1), function()
        Bgm():play("gbl")
    end)

end)

