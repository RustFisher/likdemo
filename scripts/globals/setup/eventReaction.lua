-- 事件反应
---@param u Unit
local function _z(u, offset)
    return u:h() + 130 + offset
end

---@param evtData noteOnUnitCritData
event.reaction(EVENT.Unit.Crit, function(evtData)
    evtData.targetUnit:attach("lik_crit", "origin", 0.5)
end)
---@param evtData noteOnUnitCritAbilityData
event.reaction(EVENT.Unit.CritAbility, function(evtData)
    evtData.targetUnit:attach("lik_crit_ability", "origin", 0.5)
    ttg.model({
        model = "lik_ttg_crit_ability",
        size = 1.4,
        x = evtData.targetUnit:x(),
        y = evtData.targetUnit:y(),
        z = _z(evtData.targetUnit, -24),
        height = 50,
        speed = 0.5,
        duration = 0.8,
    })
end)
---@param evtData noteOnUnitAvoidData
event.reaction(EVENT.Unit.Avoid, function(evtData)
    evtData.triggerUnit:attach("lik_ttg_avoid", "overhead", 0.3)
end)
---@param evtData noteOnUnitImmuneInvincibleData
event.reaction(EVENT.Unit.ImmuneInvincible, function(evtData)
    evtData.triggerUnit:attach("DivineShieldTarget", "origin", 1)
    ttg.model({
        model = "lik_ttg_immuneInvincible",
        size = 1.2,
        x = evtData.triggerUnit:x(),
        y = evtData.triggerUnit:y(),
        z = _z(evtData.triggerUnit, -44),
        height = 100,
        duration = 1,
    })
end)
---@param evtData noteOnUnitImmuneDefendData
event.reaction(EVENT.Unit.ImmuneDefend, function(evtData)
    ttg.model({
        model = "lik_ttg_immuneDamage",
        size = 0.7,
        x = evtData.triggerUnit:x(),
        y = evtData.triggerUnit:y(),
        z = _z(evtData.triggerUnit, -44),
        height = 100,
        duration = 1,
    })
end)
---@param evtData noteOnUnitImmuneReductionData
event.reaction(EVENT.Unit.ImmuneReduction, function(evtData)
    ttg.model({
        model = "lik_ttg_immuneDamage",
        size = 0.7,
        x = evtData.triggerUnit:x(),
        y = evtData.triggerUnit:y(),
        z = _z(evtData.triggerUnit, -44),
        height = 100,
        duration = 1,
    })
end)
---@param evtData noteOnUnitImmuneEnchantData
event.reaction(EVENT.Unit.ImmuneEnchant, function(evtData)
    ttg.model({
        model = "lik_ttg_immuneEnchant",
        size = 0.7,
        x = evtData.triggerUnit:x(),
        y = evtData.triggerUnit:y(),
        z = _z(evtData.triggerUnit, -44),
        height = 100,
        duration = 1,
    })
end)
---@param evtData noteOnUnitHPSuckAttackData
event.reaction(EVENT.Unit.HPSuckAttack, function(evtData)
    evtData.triggerUnit:attach("HealTarget2", "origin", 0.5)
end)
---@param evtData noteOnUnitHPSuckAbilityData
event.reaction(EVENT.Unit.HPSuckAbility, function(evtData)
    evtData.triggerUnit:attach("HealTarget2", "origin", 0.5)
end)
---@param evtData noteOnUnitMPSuckAttackData
event.reaction(EVENT.Unit.MPSuckAttack, function(evtData)
    evtData.triggerUnit:attach("AImaTarget", "origin", 0.5)
end)
---@param evtData noteOnUnitMPSuckAbilityData
event.reaction(EVENT.Unit.MPSuckAbility, function(evtData)
    evtData.triggerUnit:attach("AImaTarget", "origin", 0.5)
end)
---@param evtData noteOnUnitPunishData
event.reaction(EVENT.Unit.Punish, function(evtData)
    evtData.triggerUnit:rgba(140, 140, 140, nil, evtData.duration)
    evtData.triggerUnit:attach("lik_ttg_punish", "head", 4.9)
end)
---@param evtData noteOnUnitBeStunData
event.reaction(EVENT.Unit.Be.Stun, function(evtData)
    evtData.triggerUnit:attach("ThunderclapTarget", "overhead", evtData.duration)
end)
---@param evtData noteOnUnitBeSplitData
event.reaction(EVENT.Unit.Be.Split, function(evtData)
    evtData.triggerUnit:effect("SpellBreakerAttack")
end)
---@param evtData noteOnUnitBeSplitSpreadData
event.reaction(EVENT.Unit.Be.SplitSpread, function(evtData)
    evtData.triggerUnit:effect("CleaveDamageTarget")
end)
---@param evtData noteOnUnitBeShieldData
event.reaction(EVENT.Unit.Be.Shield, function(evtData)
    ttg.word({
        str = math.format(evtData.value, 0),
        width = 7.5,
        size = 0.45,
        x = evtData.triggerUnit:x(),
        y = evtData.triggerUnit:y(),
        z = _z(evtData.triggerUnit, 0),
        height = 150,
        duration = 0.6,
    })
end)
---@param evtData noteOnUnitHurtData
event.reaction(EVENT.Unit.Hurt, function(evtData)
    local str = math.format(evtData.damage, 0)
    local height = -50
    if (evtData.crit == true) then
        str = 'C' .. str
        height = 300
    end
    ttg.word({
        str = str,
        width = 12,
        size = 0.7,
        x = evtData.triggerUnit:x(),
        y = evtData.triggerUnit:y(),
        z = _z(evtData.triggerUnit, 0),
        height = height,
        duration = 0.7,
    })
end)
---@param evtData noteOnUnitEnchantData
event.reaction(EVENT.Unit.Enchant, function(evtData)
    local m = {
        [DAMAGE_TYPE.fire.value] = "lik_ttg_e_fire",
        [DAMAGE_TYPE.water.value] = "lik_ttg_e_water",
        [DAMAGE_TYPE.ice.value] = "lik_ttg_e_ice",
        [DAMAGE_TYPE.rock.value] = "lik_ttg_e_rock",
        [DAMAGE_TYPE.wind.value] = "lik_ttg_e_wind",
        [DAMAGE_TYPE.light.value] = "lik_ttg_e_light",
        [DAMAGE_TYPE.dark.value] = "lik_ttg_e_dark",
        [DAMAGE_TYPE.grass.value] = "lik_ttg_e_grass",
        [DAMAGE_TYPE.thunder.value] = "lik_ttg_e_thunder",
        [DAMAGE_TYPE.poison.value] = "lik_ttg_e_poison",
        [DAMAGE_TYPE.steel.value] = "lik_ttg_e_steel",
    }
    if (m[evtData.enchantType.value] ~= nil) then
        ttg.model({
            model = m[evtData.enchantType.value],
            size = 1.2,
            x = evtData.targetUnit:x() - math.rand(30, -30),
            y = evtData.targetUnit:y(),
            z = _z(evtData.targetUnit, -evtData.targetUnit:stature() * 2),
            height = 160,
            speed = 0.4,
            duration = 1,
        })
    end
end)