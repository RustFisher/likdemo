local process = Process("battle")

process:onStart(function(this)
    local u1 = Unit(TPL_UNIT.HeroFlameLord, Player(1), 400, -1000, 66.6)
        .level(1)
        .reborn(0.5)
        .hp(1000)
        .hpRegen(25)
        .mp(100)
        .mpRegen(10)
        .move(522)
        .attackSpaceBase(1).attack(91).attackRange(800).attackSpeed(100)
        .crit(10)
        .odds("crit", 10)
        .hpSuckAttack("+=10")
        .mpSuckAttack("+=10")
    --.enchantWeapon("grass", "+=1")
    --.enchantWeapon("fire", "+=1")
        .punish(2000)
        .weight("+=10")

    ability.silent(u1, 30, "SilenceTarget", "overhead")
    ability.unArm(u1, 30, "SilenceTarget", "weapon")

    ---@param damageData noteOnUnitDamageData
    u1.onEvent(EVENT.Unit.Damage, function(damageData)
        damageData.triggerUnit.exp("+=10")
    end)
    this.stage("u1", u1)

    ---@type Unit[]
    local u2s = {}
    for _ = 1, 4 do
        table.insert(u2s, Unit(TPL_UNIT.BloodBeetle, Player(2), -500, 500, 0)
            .reborn(0.5)
            .hp(10000).hpRegen(100)
            .mp(1000).mpRegen(10)
            .move(0)
            .attackSpaceBase(1).attack(91).attackRange(1000)
            .lightningPush(Lightning(LIGHTNING_TYPE.suckBlue).focus(3))
            .enchantWeapon("lightning", "+=1")
            .punish(1000)
        )
    end
    this.stage("u2s", u2s)

end)

process:onOver(function(this)
    destroy(this.stage("u1"))
    local u2s = this.stage("u2s")
    for _, v in ipairs(u2s) do
        destroy(v)
    end
end)
