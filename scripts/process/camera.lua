local process = Process("camera")

process.onSetup(function(this)

    async.call(Player(1), function()
        Camera().shake(10, 0.2, 10)
        Camera().quake(10, 5)

        print(Camera().isShaking())
        print(Camera().isQuaking())

        time.setTimeout(7.5, function()
            print(Camera().isShaking())
            print(Camera().isQuaking())
        end)
    end)

end)

