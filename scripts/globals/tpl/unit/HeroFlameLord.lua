--- 火焰巨魔
TPL_UNIT.HeroFlameLord = UnitTpl("HeroFlameLord")
    :superposition("attack", 1)
    :attack(11)
    :attackModePush(AttackMode():mode("missile"):missileModel("FaerieDragonMissile"):homing(true):height(300):speed(300))
    :abilitySlot({ TPL_ABILITY.AB1, TPL_ABILITY.AB2, TPL_ABILITY.AB3, TPL_ABILITY.AB4 })
    :itemSlot({ TPL_ITEM.IT1, TPL_ITEM.IT2, TPL_ITEM.IT1, TPL_ITEM.IT2, TPL_ITEM.IT1, TPL_ITEM.IT2 })
    :iconMap("px", 0.01, 0.01)
    :level(1)
    :reborn(0.5)
    :hp(1000)
    :hpRegen(25)
    :mp(100)
    :mpRegen(10)
    :move(522)
    :attackSpaceBase(2)
    :attackRange(800)
    :attackSpeed(100)
    :crit(10)
    :odds("crit", 10)
    :hpSuckAttack("+=10")
    :mpSuckAttack("+=10")
    :punish(2000)
    :weight("+=10")