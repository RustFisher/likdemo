local process = Process("orderRouteWheel")

process:onStart(function(this)

    local path = {
        {
            -500, -1000,
            ---@param orderUnit Unit
            function(orderUnit)
                orderUnit:effect("HCancelDeath")
                orderUnit:orderRouteResume()
            end
        },
        { 500, -1000, },
        { 500, -2000, },
        { -500, -2000 },
    }
    local routes = {}
    for i = 1, #path do
        routes[i] = table.wheel(path, 1 * (i - 1))
    end

    local us = {}
    this:stage("us", us)
    for i = 1, #routes do
        local r = routes[i]
        local u = Unit(TPL_UNIT.HeroFlameLord, Player(i), r[1][1], r[1][2], 0)
        us[i] = u
        u:orderRoute(true, r)
    end

end)

process:onOver(function(this)
    local us = this:stage("us")
    for _, u in ipairs(us) do
        destroy(u)
    end
end)