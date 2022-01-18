local process = Process("test")

process.onSetup(function(this)

    local me = Unit(TPL_UNIT.Footman, Player(1), 0, 0, 270).abilityPoint(5)
    me.abilitySlot().push(TPL_ABILITY.Rebound, 1)
    ability.invulnerable(me, 5)

    Unit(TPL_UNIT.MortarTeam, Player(2), 500, 300, 270)
    Unit(TPL_UNIT.Rifleman, Player(2), 500, -300, 270)
    Unit(TPL_UNIT.BloodElfDragonHawk, Player(2), -500, 300, 270)
    Unit(TPL_UNIT.WyvernRider, Player(2), -500, -300, 270)
    Unit(TPL_UNIT.ChaosWarlockGreen, Player(2), 0, -500, 270)

end)

process.onDestroy(function(this)
end)
