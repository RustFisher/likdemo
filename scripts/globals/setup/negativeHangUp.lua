--- 挂机灭绝器
--- negative hang up
if (false == DEBUGGING) then

    Game():onEvent(EVENT.Game.Start, "negativeHangUp", function()

        sync.receive("negativeHangUp", function(syncData)
            syncData.syncPlayer:quit("消极挂机")
        end)
        async.call(PlayerLocal(), function()
            local cx = Camera():x()
            local cy = Camera():y()
            local click = false
            mouse.onRightClick("negativeHangUp", function() click = true end)
            time.setInterval(30, function(curTimer)
                local cx2 = Camera():x()
                local cy2 = Camera():y()
                if (click ~= true and cx == cx2 and cy == cy2) then
                    destroy(curTimer)
                    sync.send("negativeHangUp")
                    return
                end
                cx, cy = cx2, cy2
                click = false
                if (curTimer:period() < 300) then
                    curTimer:period("+=15")
                end
            end)
        end)

    end)

end