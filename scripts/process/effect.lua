local process = Process("effect")

process:onStart(function(this)
    local eff = Effect("GlaiveMissile", 0, 0, 100)
    this:stage("eff", eff)
    mouse.onMove("eff", 3, function(evtData)
        eff:size(math.rand(1, 3))
           :portal(japi.DzGetMouseTerrainX(), japi.DzGetMouseTerrainY(), japi.DzGetMouseTerrainZ() + 100)
    end)

end)

process:onOver(function(this)
    destroy(this:stage("eff"))
    mouse.onMove("eff", 3, nil)
end)

