local process = Process("dialog")

process:onStart(function(this)

    Dialog(
        "选择难度",
        {
            { label = "一般困难", value = 1, hotkey = "Q" },
            { label = "非常困难", value = 2, hotkey = "W" },
            { label = "极奇困难", value = 3, hotkey = "E" },
            { label = "破天荒难", value = 5 },
        },
        function(evtData)
            destroy(evtData.triggerDialog)
            if (evtData.value == 1) then
                --搞点事情
            elseif (evtData.value == 2) then
                --搞点事情
            elseif (evtData.value == 3) then
                --搞点事情
            elseif (evtData.value == 5) then
                --搞点事情
            end
            echo("选择了：" .. evtData.label .. "，" .. evtData.value)
        end
    ):show()

end)
