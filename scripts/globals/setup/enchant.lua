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
Enchant("fire")
    :name("火")
    :strengthen(0)
    :resistance(0)
    :attachEffect("origin", "BreathOfFireDamage")
    :attachEffect("left hand", "BreathOfFireDamage")
    :attachEffect("right hand", "BreathOfFireDamage")
    :attachEffect("head", "BreathOfFireDamage")
    :reaction("grass", function(evtData) evtData.triggerUnit:hpRegen("-=200;5") end)

Enchant("rock"):name("岩")
Enchant("water"):name("水")
Enchant("ice"):name("冰")
Enchant("wind"):name("风")
Enchant("light"):name("光")
Enchant("dark"):name("暗")
Enchant("grass"):name("草")
Enchant("thunder"):name("雷")
Enchant("poison"):name("毒")