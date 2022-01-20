local process = Process("destructable")

process:onStart(function(this)

    local ds = {}
    for _ = 1, 3, 1 do
        table.insert(ds, Destructable("Cage", 0, 0, 0, 0, nil, nil))
    end
    this.stage("ds", ds)

    time.setInterval(0.05, function(curTimer)
        local _ds = this.stage("ds")
        if (_ds[1] == nil) then
            destroy(curTimer)
            return
        end
        for _, d in ipairs(_ds) do
            d.portal(math.rand(0, 500), math.rand(0, 500), math.rand(0, 100))
             .facing(math.rand(0, 360))
             .scale(math.rand(30, 200) * 0.01)
            print(d.x(), d.y(), d.z(), d.facing(), d.scale())
        end
    end)

end)

process:onOver(function(this)
    for d in ipairs(this.stage("ds")) do
        destroy(d)
    end

end)
