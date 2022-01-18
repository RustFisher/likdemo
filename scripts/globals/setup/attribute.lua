--- 方便伤害类型引用 {value:string,label:string}
DAMAGE_TYPE.fire = nil
DAMAGE_TYPE.rock = nil
DAMAGE_TYPE.water = nil
DAMAGE_TYPE.ice = nil
DAMAGE_TYPE.wind = nil
DAMAGE_TYPE.light = nil
DAMAGE_TYPE.dark = nil
DAMAGE_TYPE.grass = nil
DAMAGE_TYPE.thunder = nil
DAMAGE_TYPE.poison = nil

-- 附魔设定
attribute.enchant("fire", "火", {
    strengthen = 0,
    resistance = 0,
    append = {
        { attach = 'origin', effect = 'BreathOfFireDamage' },
        { attach = 'left hand', effect = 'BreathOfFireDamage' },
        { attach = 'right hand', effect = 'BreathOfFireDamage' },
        { attach = 'head', effect = 'BreathOfFireDamage' },
    },
    reaction = {
        grass = attribute.enchantReaction(function(evtData)
            evtData.triggerUnit.hpRegen("-=200;5")
        end)
    },
})

attribute.enchant("rock", "岩")
attribute.enchant("water", "水")
attribute.enchant("ice", "冰")
attribute.enchant("wind", "风")
attribute.enchant("light", "光")
attribute.enchant("dark", "暗")
attribute.enchant("grass", "草")
attribute.enchant("thunder", "雷")
attribute.enchant("poison", "毒")

attribute.labelOpts = {
    attack = "攻击",
    defend = "防御",
    enchantWeapon_water = "水武装",
}

-- 定义智能属性描述体
-- [基础信息]
---@param this Ability|Item
---@param options {level:number}
Game().defineDescription("attributes", function(this, options)
    if (type(this.attributes) ~= "function") then
        return nil
    end
    local attributes = this.attributes()
    if (type(attributes) ~= "table" or #attributes == 0) then
        return nil
    end
    local desc = {}
    local lv = math.floor(options.level or this.level())
    table.insert(desc, "")
    for _, a in ipairs(attributes) do
        local method = a[1]
        local m2 = a[2] or 0
        local d1
        local d2
        if (type(m2) == "number") then
            d1 = m2
            d2 = a[3] or d1
        elseif (type(m2) == "string") then
            method = method .. '_' .. m2
            d1 = a[3] or 0
            d2 = a[4] or d1
        end
        if (attribute.labelOpts[method] ~= nil) then
            local v = d1
            if (lv > 1) then
                v = v + (lv - 1) * d2
            end
            if (v > 0) then
                table.insert(desc, attribute.labelOpts[method] .. ": +" .. v)
            elseif (v < 0) then
                table.insert(desc, attribute.labelOpts[method] .. ": " .. v)
            end
        end
    end
    return desc
end)