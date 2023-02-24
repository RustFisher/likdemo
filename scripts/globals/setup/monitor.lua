--- 恢复生命监听器
---@param obj Unit
Monitor("life_regen")
    :frequency(0.2)
    :actionFunc(
    function(obj)
        local regen = 0.2 * obj:hpRegen()
        local cure = obj:cure() * 0.01
        local v = 0
        if (regen >= 0) then
            v = math.max(0, 1 + cure) * regen
            obj:hpCur("+=" .. v)
        else
            v = math.min(0, cure - 1) * regen
            obj:hpCur("-=" .. v)
        end
    end)
    :ignoreFilter(function(obj) return obj:isDead() or obj:hpRegen() == nil or obj:hpRegen() == 0 end)

--- 恢复魔法监听器
---@param obj Unit
Monitor("mana_regen")
    :frequency(0.3)
    :actionFunc(
    function(obj)
        local regen = 0.3 * obj:mpRegen()
        local cure = obj:cure() * 0.01
        local v = 0
        if (regen >= 0) then
            v = math.max(0, 1 + cure) * regen
            obj:mpCur("+=" .. v)
        else
            v = math.min(0, cure - 1) * regen
            obj:mpCur("-=" .. v)
        end
    end)
    :ignoreFilter(function(obj) return obj:isDead() or obj:mpRegen() == nil or obj:mpRegen() == 0 end)

--- 硬直监听器
---@param obj Unit
Monitor("punish_regen")
    :frequency(0.5)
    :actionFunc(function(obj) obj:punishCur("+=" .. 0.5 * obj:punishRegen()) end)
    :ignoreFilter(function(obj) return obj:isDead() or obj:punishRegen() == nil or obj:punishRegen() == 0 end)