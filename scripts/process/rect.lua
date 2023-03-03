local process = Process("rect")

process:onStart(function(this)

    local r = Rect("中心判断区", "square", 0, 0, 500, 500)
    ---@param enterData noteOnRectEnterData
    r:onEvent(EVENT.Rect.Enter, function(enterData)
        print("Enter")
        print(enterData.triggerRect:name())
        print(enterData.triggerUnit:name())
    end)
    ---@param enterData noteOnRectLeaveData
    r:onEvent(EVENT.Rect.Leave, function(enterData)
        print("Leave")
        print(enterData.triggerRect:name())
        print(enterData.triggerUnit:name())
    end)

    Player(1):unit(TPL_UNIT.HeroFlameLord, 0, 0, 270)

end)