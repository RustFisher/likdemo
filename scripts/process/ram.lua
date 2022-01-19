local process = Process("ram")

process:onStart(function(this)

    local r1 = function()
        collectgarbage("collect")
        local rem0 = collectgarbage("count")
        local class = function()
            local o = {data = {}}
            o.a = function(v) o.data.a = v return o end
            o.b = function(v) o.data.b = v return o end
            o.c = function(v) o.data.c = v return o end
            o.d = function(v) o.data.d = v return o end
            o.e = function(v) o.data.e = v return o end
            o.f = function(v) o.data.f = v return o end
            o.g = function(v) o.data.g = v return o end
            o.h = function(v) o.data.h = v return o end
            o.i = function(v) o.data.i = v return o end
            return o
        end
        local x1 = os.clock()
        for _ = 1, 10000, 1 do
            local b = class()
            b.a(1).b(2).c(3).d(4).e(5).f(6).g(7).h(8).i(9)
        end
        local x2 = os.clock()
        print(string.format("Time: %.6f\n", x2 - x1))
        print("R1=" .. (collectgarbage("count") - rem0) / 1024 .. ' MB')
    end

    local r2 = function()
        collectgarbage("collect")
        local rem0 = collectgarbage("count")
        local class = { data = {} }
        function class:a(v) self.data.a = v return self end
        function class:b(v) self.data.b = v return self end
        function class:c(v) self.data.c = v return self end
        function class:d(v) self.data.d = v return self end
        function class:e(v) self.data.e = v return self end
        function class:f(v) self.data.f = v return self end
        function class:g(v) self.data.g = v return self end
        function class:h(v) self.data.h = v return self end
        function class:i(v) self.data.i = v return self end
        local x1 = os.clock()
        for _ = 1, 10000, 1 do
            local b = setmetatable({}, { __index = class })
            b:a(1):b(2):c(3):d(4):e(5):f(6):g(7):h(8):i(9)
        end
        local x2 = os.clock()
        print(string.format("Time: %.6f\n", x2 - x1))
        print("R2=" .. (collectgarbage("count") - rem0) / 1024 .. ' MB')
    end

    r1()
    r2()

end)
