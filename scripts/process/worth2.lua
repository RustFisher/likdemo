local process = Process("worth2")

process:onStart(function(this)

    local p = Player(1)
    p:worth("=", { copper = math.round(tonumber("79271347080")) })

    dump(p:worth())

end)

