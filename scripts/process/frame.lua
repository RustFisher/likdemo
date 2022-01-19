local process = Process("frame")

process:onStart(function(this)

    local frame1 = FrameTextarea("pf1", FrameGameUI)
    frame1.relation(FRAME_ALIGN_RIGHT, FrameGameUI, FRAME_ALIGN_RIGHT, -0.002, 0)
          .size(0.2, 0.2)
          .textAlign(TEXT_ALIGN_LEFT)
          .fontSize(10)
          .text(string.implode('|n', {
        "4图1794日好9负那9放1nfu913fn9u31fnun1",
        "3213194日好9负那9放1nfu913fn9u31fnun1",
        "5图1794日好9负那9放1nfu913fn9u31fnun1",
        "6图1794日好9负那9放1nfu913fn9u31fnun1",
        "7图1794日好9负那9放1nfu913fn9u31fnun1",
        "1图1794日好9负那9放1nfu913fn9u31fnun1",
        "2图1794日好9负那9放1nfu913fn9u31fnun1",
        "46图1794日好9负那9放1nfu913fn9u31fnun1",
        "421794日好9负那9放1nfu913fn9u31fnun1",
        "4图8794日好9负那9放1nfu913fn9u31fnun1",
        "321794日好9负那9放1nfu913fn9u31fnun1",
        "4图1794日好9负那9放1nfu913fn9u31fnun1",
        "5图1794日好9负那9放1nfu913fn9u31fnun1",
        "8图1794日好9负那9放1nfu913fn9u31fnun1",
        "0图1794日好9负那9放1nfu913fn9u31fnun1",
        "1图1794日好9负那9放1nfu913fn9u31fnun1",
        "2图1794日好9负那9放1nfu913fn9u31fnun1",
        "3图1794日好9负那9放1nfu913fn9u31fnun1",
    }))   .show(true)

    this.stage("frame1", frame1)

end)

process:onOver(function(this)
    this.stage("frame1").show(false)
end)

