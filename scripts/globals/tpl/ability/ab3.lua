---@param effectiveData noteOnAbilityEffectiveData
TPL_ABILITY.AB3 = AbilityTpl()
    .name("技能3")
    .targetType(ABILITY_TARGET_TYPE.TAG_L)
    .icon("AB2")
    .coolDownAdv(5, 0)
    .mpCostAdv(10, 5)
    .castDistanceAdv(1000, 0)
    .onEvent(EVENT.Ability.Effective,
    function(effectiveData)
        ability.leap({
            sourceUnit = effectiveData.triggerUnit,
            targetX = effectiveData.targetX,
            targetY = effectiveData.targetY,
            speed = 500,
            animate = "attack",
            acceleration = 0,
            height = 100,
            shake = nil,
            reflex = nil,
            leapModel = "WarStompCaster",
            onMove = function()
                print("move")
            end,
            onEnd = function()
                print("end")
            end,
        })
    end)