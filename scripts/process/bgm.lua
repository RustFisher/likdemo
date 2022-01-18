local process = Process("bgm")

process.onSetup(function(this)

    async.call(Player(1), function()
        Bgm().play("gbl")
    end)

end)

