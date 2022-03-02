local process = Process("ability")

process:onStart(function(self)
    local u1 = Unit(TPL_UNIT.HeroFlameLord, Player(1), 500, -500, 66.6)
        :level(1)
        :reborn(0.5)
        :hp(100)
        :hpRegen(10)
        :mp(100)
        :mpRegen(-1)
        :move(522)
        :attackModePush(AttackMode():missileModel("PriestMissile"):homing(true):height(300):speed(500))
        :attackSpaceBase(1)
        :attack(91)
        :attackRange(1000)
        :attackSpeed(100)
        :crit(10):odds("crit", 10)
        :hpSuckAttack("+=10")
        :mpSuckAttack("+=10")
        :punish(2000)
        :weight("+=10")
        :bindItemTpl()

    u1:odds("hurtRebound", "+=100")

    self:stage("u1", u1)

    u1:abilitySlot():push(TPL_ABILITY.AB1)
    u1:abilitySlot():push(TPL_ABILITY.AB2)
    u1:abilitySlot():push(TPL_ABILITY.King, 6)
end)

process:onOver(function(self)
    destroy(self:stage("u1"))
end)
