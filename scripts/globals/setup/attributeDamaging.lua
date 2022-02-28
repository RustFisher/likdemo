--- 提取一些需要的参数
attribute.damaging("prop", function(options)
    options.defend = options.targetUnit:defend()
    options.avoid = options.targetUnit:avoid() - options.sourceUnit:aim()
end)

--- 判断无视装甲类型
attribute.damaging("breakArmor", function(options)
    local ignore = { defend = false, avoid = false, invincible = false }
    if (#options.breakArmor > 0) then
        for _, b in ipairs(options.breakArmor) do
            if (b ~= nil) then
                ignore[b.value] = true
                --- 触发无视防御事件
                event.trigger(options.sourceUnit, EVENT.Unit.BreakArmor, { triggerUnit = options.sourceUnit, targetUnit = options.targetUnit, breakType = b })
                --- 触发被破防事件
                event.trigger(options.targetUnit, EVENT.Unit.Be.BreakArmor, { triggerUnit = options.targetUnit, breakUnit = options.sourceUnit, breakType = b })
            end
        end
    end
    --- 处理护甲
    if (ignore.defend == true and options.defend > 0) then
        options.defend = 0
    end
    --- 处理回避
    if (ignore.avoid == true and options.avoid > 0) then
        options.avoid = 0
    end
    --- 单位是否无视无敌
    if (true == options.targetUnit.isInvulnerable()) then
        if (ignore.invincible == false) then
            --- 触发无敌抵御事件
            event.trigger(options.sourceUnit, EVENT.Unit.ImmuneInvincible, { triggerUnit = options.targetUnit, sourceUnit = options.sourceUnit })
            return
        end
    end
end)

--- 自身攻击暴击
attribute.damaging("crit", function(options)
    local approveCrit = (options.sourceUnit ~= nil and (options.damageSrc == DAMAGE_SRC.attack or options.damageSrc == DAMAGE_SRC.ability))
    options.isCrit = false
    if (approveCrit) then
        local crit = options.sourceUnit:crit()
        if (crit > 0) then
            local odds = options.sourceUnit:odds("crit") - options.targetUnit:resistance("crit")
            if (odds > math.rand(1, 100)) then
                options.damage = options.damage * (1 + crit * 0.01)
                options.isCrit = true
                --- 触发时自动无视回避
                options.avoid = 0
            end
        end
    end
end)

--- 回避
attribute.damaging("avoid", function(options)
    local approveAvoid = (options.avoid > 0 and (options.damageSrc == DAMAGE_SRC.attack or options.damageSrc == DAMAGE_SRC.rebound))
    if (approveAvoid) then
        if (options.avoid > math.rand(1, 100)) then
            -- 触发回避事件
            event.trigger(options.targetUnit, EVENT.Unit.Avoid, { triggerUnit = options.targetUnit, sourceUnit = options.sourceUnit })
            event.trigger(options.sourceUnit, EVENT.Unit.Be.Avoid, { triggerUnit = options.sourceUnit, targetUnit = options.targetUnit })
            return
        end
    end
end)

-- 允许判定
local approveDamageAmplify = (sourceUnit ~= nil)
local approveReboundHurtResistance = (sourceUnit ~= nil and damageSrc == DAMAGE_SRC.rebound)
local approveReboundAnti = (sourceUnit ~= nil and (damageSrc == DAMAGE_SRC.attack or damageSrc == DAMAGE_SRC.ability))
local approveHPSuck = (sourceUnit ~= nil and damageSrc == DAMAGE_SRC.attack)
local approveHPSuckSpell = (sourceUnit ~= nil and damageSrc == DAMAGE_SRC.ability)
local approveMPSuck = (sourceUnit ~= nil and damageSrc == DAMAGE_SRC.attack and sourceUnit.mp() > 0 and targetUnit.mpCur() > 0)
local approveMPSuckSpell = (sourceUnit ~= nil and damageSrc == DAMAGE_SRC.ability and sourceUnit.mp() > 0 and targetUnit.mpCur() > 0)
local approvePunish = (targetUnit.punish() > 0 and targetUnit.isPunishing() == false)


-- [处理]伤害加深(%)
if (approveDamageAmplify) then
    local damageIncrease = sourceUnit.damageIncrease()
    if (damageIncrease > 0) then
        dmg = dmg * (1 + damageIncrease * 0.01)
    end
end
-- [处理]受伤加深(%)
local hurtIncrease = targetUnit.hurtIncrease()
if (hurtIncrease > 0) then
    dmg = dmg * (1 + hurtIncrease * 0.01)
end
-- [处理]反伤抵抗
if (approveReboundHurtResistance) then
    local resistance = sourceUnit.resistance("hurtRebound")
    if (resistance > 0) then
        dmg = math.max(0, dmg * (1 - resistance * 0.01))
        if (dmg < 1) then return end
    end
end
-- [处理]反伤
if (approveReboundAnti) then
    local hurtRebound = targetUnit:hurtRebound()
    local odds = targetUnit:odds("hurtRebound")
    if (hurtRebound > 0 and odds > math.rand(1, 100)) then
        local dmgRebound = math.round(dmg * hurtRebound * 0.01, 3)
        if (dmgRebound >= 1.000) then

            local damagedArrived = function()
                --- 触发反伤事件
                ability.damage(targetUnit, sourceUnit, dmgRebound, DAMAGE_SRC.rebound, damageType)
            end
            if (damageSrc == DAMAGE_SRC.attack) then
                -- 攻击下
                if (sourceUnit:isMelee()) then
                    damagedArrived()
                else
                    local am = sourceUnit:attackMode()
                    local mode = am:mode()
                    if (mode == "lightning") then
                        local lDur = 0.3
                        local lDelay = lDur * 0.6
                        ability.lightning(am:lightningType(), targetUnit:x(), targetUnit:y(), targetUnit:h(), sourceUnit:x(), sourceUnit:y(), sourceUnit:h(), lDur)
                        time.setTimeout(lDelay, function()
                            damagedArrived()
                        end)
                    elseif (mode == "missile") then
                        local options = {
                            modelAlias = am:missileModel(),
                            hover = math.rand(am:hover() - 5, am:hover() + 5),
                            sourceUnit = targetUnit,
                            targetUnit = sourceUnit,
                            speed = am:speed(),
                            height = am:height() / 4,
                            acceleration = am:acceleration(),
                            onEnd = function() damagedArrived() end,
                        }
                        ability.missile(options)
                    end
                end
            elseif (damageSrc == DAMAGE_SRC.ability) then
                -- 技能下
                damagedArrived()
            end
        end
    end
end
-- [处理]防御
local defend = targetUnit.defend()
if (defend < 0) then
    dmg = dmg + math.abs(defend)
elseif (defend > 0 and ignore.defend == false) then
    dmg = dmg - defend
    if (dmg < 1) then
        event.trigger(targetUnit, EVENT.Unit.ImmuneDefend, { triggerUnit = targetUnit, sourceUnit = sourceUnit })
        return
    end
end
-- [处理]减伤:比例
local hurtReduction = targetUnit.hurtReduction()
if (hurtReduction > 0) then
    dmg = dmg * (1 - hurtReduction * 0.01)
    if (dmg < 1) then
        event.trigger(targetUnit, EVENT.Unit.ImmuneReduction, { triggerUnit = targetUnit, sourceUnit = sourceUnit })
        return
    end
end
-- [处理]攻击吸血
if (approveHPSuck) then
    local percent = sourceUnit.hpSuckAttack() - targetUnit.resistance("hpSuckAttack")
    if (percent > 0) then
        local val = dmg * percent * 0.01
        sourceUnit.hpCur("+=" .. val)
        --- 触发吸血事件
        event.trigger(sourceUnit, EVENT.Unit.HPSuckAttack, { triggerUnit = sourceUnit, targetUnit = targetUnit, value = val, percent = percent })
        event.trigger(sourceUnit, EVENT.Unit.Be.HPSuckAttack, { triggerUnit = targetUnit, sourceUnit = sourceUnit, value = val, percent = percent })
    end
end
-- [处理]技能吸血
if (approveHPSuckSpell) then
    local percent = sourceUnit.hpSuckAbility() - targetUnit.resistance("hpSuckAbility")
    if (percent > 0) then
        local val = dmg * percent * 0.01
        sourceUnit.hpCur("+=" .. val)
        --- 触发技能吸血事件
        event.trigger(sourceUnit, EVENT.Unit.HPSuckAbility, { triggerUnit = sourceUnit, targetUnit = targetUnit, value = val, percent = percent })
        event.trigger(sourceUnit, EVENT.Unit.Be.HPSuckAbility, { triggerUnit = targetUnit, sourceUnit = sourceUnit, value = val, percent = percent })
    end
end
-- [处理]攻击吸魔;吸魔会根据伤害，扣减目标的魔法值，再据百分比增加自己的魔法值;目标魔法值不足 1 从而吸收时，则无法吸取
if (approveMPSuck) then
    local percent = sourceUnit.mpSuckAttack() - targetUnit.resistance("mpSuckAttack")
    if (percent > 0) then
        local mana = math.min(targetUnit.mp(), dmg)
        local val = mana * percent * 0.01
        if (val > 1) then
            targetUnit.mpCur("-=" .. val)
            sourceUnit.mpCur("+=" .. val)
            --- 触发吸魔事件
            event.trigger(sourceUnit, EVENT.Unit.MPSuckAttack, { triggerUnit = sourceUnit, targetUnit = targetUnit, value = val, percent = percent })
            event.trigger(sourceUnit, EVENT.Unit.Be.MPSuckAttack, { triggerUnit = targetUnit, sourceUnit = sourceUnit, value = val, percent = percent })
        end
    end
end
-- [处理]技能吸魔;吸魔会根据伤害，扣减目标的魔法值，再据百分比增加自己的魔法值;目标魔法值不足 1 从而吸收时，则无法吸取
if (approveMPSuckSpell) then
    local percent = sourceUnit.mpSuckAbility() - targetUnit.resistance("mpSuckAbility")
    if (percent > 0) then
        local mana = math.min(targetUnit.mp(), dmg)
        local val = mana * percent * 0.01
        if (val > 1) then
            targetUnit.mpCur("-=" .. val)
            sourceUnit.mpCur("+=" .. val)
            --- 触发技能吸魔事件
            event.trigger(sourceUnit, EVENT.Unit.MPSuckAbility, { triggerUnit = sourceUnit, targetUnit = targetUnit, value = val, percent = percent })
            event.trigger(sourceUnit, EVENT.Unit.Be.MPSuckAbility, { triggerUnit = targetUnit, sourceUnit = sourceUnit, value = val, percent = percent })
        end
    end
end
-- [处理]硬直
if (approvePunish) then
    targetUnit.punishCur("-=" .. dmg)
end
-- [处理]伤害类型:占比
local damageTypeRatio = {}
local damageTypeOcc = 0
local enchantType = {}
local ratio = {}
if (damageSrc == DAMAGE_SRC.attack and sourceUnit ~= nil) then
    -- 附加攻击形态的伤害类型
    attribute.conf("enchant").forEach(function(ek, _)
        local ew = sourceUnit.enchantWeapon(ek)
        if (ew > 0) then
            damageTypeOcc = damageTypeOcc + ew
            if (ratio[ek] == nil) then
                ratio[ek] = 0
            end
            ratio[ek] = ratio[ek] + ew
            table.insert(enchantType, ek)
        end
    end)
elseif (type(damageType) == "table" and #damageType > 0) then
    for _, d in ipairs(damageType) do
        if (type(d) == "table" and d.value) then
            damageTypeOcc = damageTypeOcc + 1
            if (ratio[d.value] == nil) then
                ratio[d.value] = 0
            end
            ratio[d.value] = ratio[d.value] + 1
            table.insert(enchantType, d.value)
        end
    end
end
if (damageTypeOcc == 0) then
    damageTypeOcc = 1
    ratio[DAMAGE_TYPE.common.value] = 1
end
local dtu = 1 / damageTypeOcc
for _, dt in ipairs(DAMAGE_TYPE_KEYS) do
    if (ratio[dt] == nil) then
        ratio[dt] = 0
    end
    damageTypeRatio[dt] = dtu * ratio[dt]
end
local lastDmg = dmg
-- [处理]附魔类型:加成|抵抗|上身
for _, et in ipairs(enchantType) do
    local addition = 0
    if (sourceUnit ~= nil) then
        local amplify = sourceUnit.enchant(et)
        if (amplify ~= 0) then
            addition = addition + amplify * 0.01
        end
    end
    local resistance = targetUnit.enchantResistance(et)
    if (resistance ~= 0) then
        addition = addition - resistance * 0.01
    end
    local d = dmg * addition * damageTypeRatio[et]
    --- 触发附魔事件
    event.trigger(targetUnit, EVENT.Unit.Enchant, {
        triggerUnit = sourceUnit, targetUnit = targetUnit,
        enchantType = et,
        radio = damageTypeRatio[et], damage = d, addition = addition
    })
    lastDmg = lastDmg + d
end
if (#enchantType > 0) then
    attribute.enchantAppend(options.targetUnit, options.sourceUnit, enchantType)
end