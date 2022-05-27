local process = Process("t2r")

process:onStart(function(this)

    local t2rFrame = FrameBackdrop("t2r", FrameGameUI)
        :relation(FRAME_ALIGN_CENTER, FrameGameUI, FRAME_ALIGN_LEFT_BOTTOM, 0, 0)
        :size(0.01, 0.01)
        :texture("ReplaceableTextures\\TeamColor\\TeamColor01.blp")
    mouse.onMove("t2r", function()
        local x, y = japi.T2R(japi.DzGetMouseTerrainX(), japi.DzGetMouseTerrainY(), japi.DzGetMouseTerrainZ())
        t2rFrame:relation(FRAME_ALIGN_CENTER, FrameGameUI, FRAME_ALIGN_LEFT_BOTTOM, x, y)
    end)

end)