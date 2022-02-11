local process = Process("dialog")

process:onStart(function(this)

    Dialog(
        "选择难度",
        {
            { hotkey = "Q", label = "一般困难", value = 1 },
            { hotkey = "W", label = "非常困难", value = 2 },
            { hotkey = "E", label = "极奇困难", value = 3 },
            { hotkey = "R", label = "破天荒难", value = 4 },
        },
        function(evtData)
            destroy(evtData.triggerDialog)
            if (evtData.hotkey == "Q") then
                --搞点事情
            elseif (evtData.hotkey == "W") then
                --搞点事情
            elseif (evtData.hotkey == "E") then
                --搞点事情
            else
                --搞点事情
            end
            echo("选择了：" .. evtData.label .. "等级：" .. evtData.value)
        end
    ).show()

end)
