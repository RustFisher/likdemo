---@param effectiveData noteOnAbilityEffectiveData
TPL_ABILITY.AB4 = AbilityTpl()
    :name("技能4")
    :targetType(ABILITY_TARGET_TYPE.tag_square)
    :icon("AB4")
    :coolDownAdv(5, 0)
    :mpCostAdv(10, 5)
    :castWidthAdv(500, 0)
    :castHeightAdv(250, 0)
    :onEvent(EVENT.Ability.Effective,
    function(effectiveData)
        print("放")
    end)