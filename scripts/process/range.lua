local process = Process("range")

process:onStart(function(this)

    local u1 = Unit(TPL_UNIT.HeroFlameLord, Player(1), 0, -2500, 66.6)
    u1:abilitySlot():tail(6)

    ---@param damageData noteOnUnitDamageData
    u1:onEvent(EVENT.Unit.Damage, function(damageData)
        damageData.triggerUnit:exp("+=10")
    end)
    this:stage("u1", u1)

    ---@type Unit[]
    local u2s = {}
    for i = 1, 50 do
        local x1, y1 = math.rand(-500, 500), -500
        local x2, y2 = vector2.polar(x1, y1, 300, 0)
        local u2 = Unit(TPL_UNIT.Footman, Player(2), x1, y1, 0)
        table.insert(u2s, u2)
    end
    this:stage("u2s", u2s)

end)

process:onOver(function(this)
    destroy(this:stage("u1"))
    local u2s = this:stage("u2s")
    for _, v in ipairs(u2s) do
        destroy(v)
    end
end)
