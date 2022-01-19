local process = Process("alert")

process:onStart(function(this)

    time.setInterval(3, function()
        Player(1).alert(string.rand(10))
    end)

end)