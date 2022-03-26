--- 火焰巨魔
TPL_UNIT.HeroFlameLord = UnitTpl("HeroFlameLord")
    :superposition("attack", 1)
    :attackModePush(AttackMode():missileModel("PriestMissile"):homing(true):height(300):speed(600))
    :itemSlot({ TPL_ITEM.IT1, TPL_ITEM.IT2 })
    :abilitySlot({ TPL_ABILITY.AB1, TPL_ABILITY.AB2, TPL_ABILITY.AB3 })