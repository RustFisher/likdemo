local process = Process("battle")

process:onStart(function(this)

    local u1 = Unit(TPL_UNIT.HeroFlameLord, Player(1), 400, -1000, 66.6)
    u1:abilitySlot():tail(6)

    --ability.silent(u1, 30, "SilenceTarget", "overhead")
    --ability.unArm(u1, 30, "SilenceTarget", "weapon")

    ---@param damageData noteOnUnitDamageData
    u1:onEvent(EVENT.Unit.Damage, function(damageData)
        damageData.triggerUnit:exp("+=10")
    end)
    this:stage("u1", u1)

    ---@type Unit[]
    local u2s = {}
    for _ = 1, 5 do
        local u2 = Unit(TPL_UNIT.BloodBeetle, Player(2), math.rand(-400, 400), math.rand(-400, 400), 0):move(0)
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
