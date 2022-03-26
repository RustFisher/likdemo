--- 恢复生命监听器
---@param obj Unit
Monitor("life_back")
    :frequency(0.4)
    :actionFunc(function(obj) obj:hpCur("+=" .. 0.4 * obj:hpRegen()) end)
    :ignoreFilter(function(obj) return obj:isDead() or obj:hpRegen() == nil or obj:hpRegen() == 0 end)

--- 恢复魔法监听器
---@param obj Unit
Monitor("mana_back")
    :frequency(0.5)
    :actionFunc(function(obj) obj:mpCur("+=" .. 0.5 * obj:mpRegen()) end)
    :ignoreFilter(function(obj) return obj:isDead() or obj:mpRegen() == nil or obj:mpRegen() == 0 end)

--- 硬直监听器
---@param obj Unit
Monitor("punish_back")
    :frequency(1)
    :actionFunc(function(obj) obj:punishCur("+=" .. obj:mpRegen()) end)
    :ignoreFilter(function(obj) return obj:isDead() or obj:punishRegen() == nil or obj:punishRegen() == 0 end)