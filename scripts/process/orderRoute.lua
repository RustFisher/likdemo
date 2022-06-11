local process = Process("orderRoute")

process:onStart(function(this)

    local u1 = Unit(TPL_UNIT.HeroFlameLord, Player(1), 0, 0, 0)
    this:stage("u1", u1)

    u1:orderRoute(true, {
        {
            -500, -500,
            ---@param orderUnit Unit
            function(orderUnit)
                orderUnit:effect("HCancelDeath")
                orderUnit:orderRouteResume()
            end
        },
        {
            500, -500,
            ---@param orderUnit Unit
            function(orderUnit)
                ability.leap({
                    sourceUnit = orderUnit,
                    targetVec = Vector3(0, -1000, 0),
                    speed = 3000,
                    height = 500,
                    reflex = 2,
                    onEnd = function(options)
                        options.sourceUnit:orderRouteResume()
                    end
                })
            end
        },
        {
            500, -1000,
            ---@param orderUnit Unit
            function(orderUnit)
                ability.crackFly({
                    targetUnit = orderUnit,
                    distance = 300,
                    height = 500,
                    bounce = { qty = 3 },
                    onEnd = function(options)
                        options.targetUnit:orderRouteResume()
                    end
                })
            end
        },
        { -500, -1000 },
    })

end)

process:onOver(function(this)
    destroy(this:stage("u1"))
end)