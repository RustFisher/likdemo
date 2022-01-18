local process = Process("timer")

process.onSetup(function(this)

    local t1 = time.setTimeout(100, function(curTimer)
        curTimer.destroy()
    end)
    this.stage("t1", t1)

    local tt = FrameText("timer-test", FrameGameUI)
        .relation(FRAME_ALIGN_CENTER, FrameGameUI, FRAME_ALIGN_CENTER, 0, 0)
        .textAlign(TEXT_ALIGN_CENTER)
        .fontSize(10)
    local t2 = time.setInterval(0.2, function(curTimer)
        tt.text(t1.remain() .. '/' .. t1.period())
        if (t1.remain() == 110) then
            t1.remain("-=55")
            t1.pause()
            time.setTimeout(3, function()
                t1.resume()
            end)
        end
        if (t1.remain() == 95) then
            t1.remain("+=20")
            t1.period("+=25")
        end
        if (t1.remain() == 50) then
            t1.remain("-=40").period("-=40")
        end
        if (t1.remain() == 5) then
            t1.remain("-=55")
        end
    end)

    this.stage("t1", t1)
    this.stage("t2", t2)

end)

process.onDestroy(function(this)
    this.stage("t1").destroy()
    this.stage("t2").destroy()
end)

