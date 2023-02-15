local process = Process("frame")

process:onStart(function(this)

    FrameModel("test", FrameGameUI)
        :relation(FRAME_ALIGN_CENTER, FrameGameUI, FRAME_ALIGN_CENTER, 0, 0)
        :model("Echo")

end)