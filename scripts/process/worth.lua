local process = Process("worth")

process:onStart(function(this)

    time.setTimeout(1, function()
        Player(1):worth("=", { gold = 1, silver = 101, copper = 111 })
        Player(1):worth("-", { silver = 110 })
    end)

    print("对比测试")
    print('Compare1 ', Game():worthCompare({ silver = 1, gold = 1 }, { silver = 98, copper = 22 }))
    print('Compare2 ', Game():worthCompare({ silver = 10, copper = 1000 }, { copper = 2000 }))
    print('Compare3 ', Game():worthCompare({ gold = 2 }, { copper = 1001, silver = 190 }))

    print("上->下转换")
    dump(Game():worthU2L({ silver = 44, gold = 1 }))
    dump(Game():worthU2L({ gold = 1, silver = 2, copper = 3 }))
    dump(Game():worthU2L({ gold = 2, copper = 1234 }))

    print("下->上转换")
    dump(Game():worthL2U({ copper = 16400 }))
    dump(Game():worthL2U({ copper = 11203 }))
    dump(Game():worthL2U({ copper = 21374 }))

    print("比例计算")
    dump(Game():worthCale({ gold = 100 }, "*", 0.5))
    dump(Game():worthCale({ gold = 100 }, "/", 2))
    dump(Game():worthCale(3, "*", { gold = 100 }))
    dump(Game():worthCale({ gold = 100 }, "+", { gold = 100 }))
    dump(Game():worthCale({ gold = 100 }, "-", { gold = 100 }))


end)

