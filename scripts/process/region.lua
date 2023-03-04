local process = Process("region")

process:onStart(function(this)

    local r = Region("中心判断区", "square", 0, 0, 500, 500)
    ---@param enterData noteOnRegionEnterData
    r:onEvent(EVENT.Region.Enter, function(enterData)
        print("Enter")
        print(enterData.triggerRegion:name())
        print(enterData.triggerUnit:name())
    end)
    ---@param enterData noteOnRegionLeaveData
    r:onEvent(EVENT.Region.Leave, function(enterData)
        print("Leave")
        print(enterData.triggerRegion:name())
        print(enterData.triggerUnit:name())
    end)

    Player(1):unit(TPL_UNIT.HeroFlameLord, 0, 0, 270)

end)