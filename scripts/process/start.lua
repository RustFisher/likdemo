local process = Process("start")

process.onSetup(function(this)

    -- 调试自动去除迷雾
    Game().fog(not DEBUGGING).mark(not DEBUGGING)

    this.next("battle")

end)
