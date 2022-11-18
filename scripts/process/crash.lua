local process = Process("crash")

process:onStart(function(this)

    local types = {
        var = "变量清空",
        unit = "创建单位",
        ttg = "创建飘浮字",
        effect = "创建特效",
        timer = "创建计时器",
    }

    local var_text = {}

    FrameTooltips(FRAME_OBJ_MAX_TOOLTIPS)
        :relation(FRAME_ALIGN_RIGHT_TOP, FrameGameUI, FRAME_ALIGN_RIGHT_TOP, -0.002, -0.04)
        :textAlign(TEXT_ALIGN_LEFT)
        :content(
        {
            tips = {
                "测试例子，进入游戏，敲入聊天信息",
                "-var [concurrent] [frequency] [number]",
                "-unit [concurrent] [frequency] [number] [during]",
                "-ttg [concurrent] [frequency] [number] [during]",
                "-effect [concurrent] [frequency] [number] [during]",
                "-timer [concurrent] [frequency] [number] [during]",
            }
        })
        :show(true)

    Team("enemy")
        :colorSync(true)
        :color(3)
        :name("敌人")
        :members({ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 })

    local running = false
    Player(1):onChat('%-', function(evtData)
        local chatString = evtData.chatString
        local chatOptions = string.explode(' ', chatString)
        local type = string.gsub(chatOptions[1] or "", "-", "")
        local concurrent = tonumber(chatOptions[2]) or 1
        local frequency = tonumber(chatOptions[3]) or 0.5
        local number = tonumber(chatOptions[4]) or 1000
        local during = tonumber(chatOptions[5]) or 3
        if (type == "" or table.includes({ "var", "unit", "ttg", "effect", "timer", "stop" }, type) == false) then
            error(type)
            return
        end
        if (type == 'stop') then
            running = false;
            return
        end
        running = true;
        print("========测试开始"
            .. "\n->type:" .. types[type]
            .. "\n->concurrent:" .. concurrent
            .. "\n->frequency:" .. frequency
            .. "\n->number:" .. number
            .. "\n->during:" .. during
            .. "\n========")
        for _ = 1, concurrent do
            local n = 0
            local cache = {}
            local t = J.CreateTimer()
            J.handleRef(t)
            J.TimerStart(t, frequency, true, function()
                n = n + 1
                if (n % 1000 == 0) then
                    print("====== = >" .. types[type] .. n .. "次")
                end
                if (n > number or running == false) then
                    J.PauseTimer(t)
                    J.DestroyTimer(t)
                    J.handleUnRef(t)
                    running = false;
                    print("========" .. types[type] .. "测试结束========")
                    cache = {}
                    return
                end
                local x = math.rand(0, 1000)
                local y = math.rand(0, 1000)
                if (type == "var") then
                    --测试全局/局部变量清空，成绩：100万 clear
                    cache[n] = x + y
                    var_text[n] = x + y
                    var_text[n] = nil
                elseif (type == "unit") then
                    --测试创建单位，成绩：83万
                    --Team("enemy").unit(TPL_UNIT.Footman, x, y, 270).destroy(during)
                    local u = Player(1):unit(TPL_UNIT.DEMO, x, y, 270)
                    destroy(u, during)
                elseif (type == "ttg") then
                    --测试模型漂浮字，成绩：50万 clear
                    ttg.word({
                        str = math.rand(10000, 99999),
                        width = 10,
                        size = 0.25,
                        x = math.rand(-500, 500),
                        y = math.rand(-500, 500),
                        z = math.rand(0, 300),
                        height = 250,
                        duration = 0.5,
                    })
                elseif (type == "effect") then
                    --测试特效，成绩：100万 clear
                elseif (type == "timer") then
                    --测试计时器，成绩：150万 clear
                    --每个占用 0.1764KB 左右，上限不变则不再增加
                    time.setTimeout(math.rand(1, 3), function() end)
                end
            end)
        end
    end)

end)