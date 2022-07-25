local process = Process("frame")

process:onStart(function(this)

    local t = time.setInterval(0.5, function()
        print("do")
        for i = 1, 5 do
            local f = FrameBackdrop("_" .. i)
            destroy(f)
        end
    end)
    this:stage("t", t)

end)

process:onOver(function(this)
    destroy(this:stage("t"))
end)

