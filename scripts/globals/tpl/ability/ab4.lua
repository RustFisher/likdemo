---@param effectiveData noteOnAbilityEffectiveData
TPL_ABILITY.AB4 = AbilityTpl()
    :name("技能4")
    :targetType(ABILITY_TARGET_TYPE.tag_square)
    :icon("AB4")
    :coolDownAdv(5, 0)
    :castWidthAdv(500, 0)
    :castHeightAdv(250, 0)
    :worthCostAdv({ gold = 10 }, { sliver = 10 })
    :onEvent(EVENT.Ability.Effective,
    function(effectiveData)
        print("放")
    end)