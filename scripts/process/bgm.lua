local process = Process("bgm")

process:onStart(function(this)

    async.call(Player(1), function()
        Bgm():play("Mysterious")
    end)

end)

