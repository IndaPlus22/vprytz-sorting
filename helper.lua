-- generate list of numbers between min and max
function range(min, max)
    local list = {}
    for i = min, max do
        table.insert(list, i)
    end
    return list
end

-- print table (array) to console
function print_table(t)
    local str = ""
    for i = 1, #t do
        str = str .. t[i] .. " "
    end
    print(str)
end

-- shuffle given array randomly
function shuffle(t)
    local n = #t
    while n >= 2 do
        local k = math.random(n)
        t[n], t[k] = t[k], t[n]
        n = n - 1
    end
    return t
end
