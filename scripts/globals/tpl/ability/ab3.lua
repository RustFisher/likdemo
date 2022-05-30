---@param effectiveData noteOnAbilityEffectiveData
TPL_ABILITY.AB3 = AbilityTpl()
    :name("技能3")
    :targetType(ABILITY_TARGET_TYPE.tag_loc)
    :icon("AB2")
    :coolDownAdv(5, 0)
    :mpCostAdv(10, 5)
    :castDistanceAdv(1000, 0)
    :onEvent(EVENT.Ability.Effective,
    function(effectiveData)
        ability.leap({
            modelAlias = "WarStompCaster",
            sourceUnit = effectiveData.triggerUnit,
            targetVec = Vector3(effectiveData.targetX, effectiveData.targetY),
            speed = 500,
            animate = "attack",
            acceleration = 0,
            height = 100,
            shake = nil,
            reflex = nil,
            onMove = function()
                print("move")
            end,
            onEnd = function()
                print("end")
            end,
        })
    end)