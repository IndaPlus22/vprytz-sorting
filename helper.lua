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
