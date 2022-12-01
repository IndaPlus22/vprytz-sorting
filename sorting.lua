require "helper"

-- insertion sort
function insertion_sort(arr)
    -- lua starts indexes on 1 for some weird reason..
    local i = 2
    while i < #arr + 1 do
        local x = arr[i]
        local j = i - 1

        while j >= 1 and arr[j] > x do
            arr[j + 1] = arr[j]
            j = j - 1
        end
        arr[j + 1] = x
        i = i + 1
    end

    return arr
end

function insertion_sort_step(arr, i)
    local x = arr[i]
    local j = i - 1

    while j >= 1 and arr[j] > x do
        arr[j + 1] = arr[j]
        j = j - 1
    end
    arr[j + 1] = x
    i = i + 1

    return j + 1
end

-- selection sort
function selection_sort(arr)
    local i = 1
    while i < #arr - 2 do
        local min_index = i
        local j = i + 1
        while j < #arr do
            if arr[j] < arr[min_index] then
                min_index = j
            end
            j = j + 1
        end
        if min_index ~= i then
            -- swap arr[i] and arr[min_index]
            local temp = arr[i]
            arr[i] = arr[min_index]
            arr[min_index] = temp
        end
        i = i + 1
    end

    return arr
end

function selection_sort_step(arr, i)
    local min_index = i
    local j = i + 1
    while j < #arr do
        if arr[j] < arr[min_index] then
            min_index = j
        end
        j = j + 1
    end
    if min_index ~= i then
        -- swap arr[i] and arr[min_index]
        local temp = arr[i]
        arr[i] = arr[min_index]
        arr[min_index] = temp
    end
    i = i + 1
    return 0
end

-- merge sort (top-down)
function merge_sort(arr)
    if #arr <= 1 then
        return arr
    end

    local mid = math.floor(#arr / 2)
    local left = {}
    local right = {}
    for i = 1, mid do
        left[i] = arr[i]
    end

    for i = mid + 1, #arr do
        right[i - mid] = arr[i]
    end

    left = merge_sort(left)
    right = merge_sort(right)

    return merge(left, right)
end

function merge(a, b)
    local c = {}

    while #a > 0 and #b > 0 do
        if a[1] > b[1] then
            table.insert(c, b[1])
            table.remove(b, 1)
        else
            table.insert(c, a[1])
            table.remove(a, 1)
        end
    end

    while #a > 0 do
        table.insert(c, a[1])
        table.remove(a, 1)
    end
    while #b > 0 do
        table.insert(c, b[1])
        table.remove(b, 1)
    end

    return c
end

function merge(a, b)
    local c = {}
    local i = 1
    local j = 1
    while i <= #a and j <= #b do
        if a[i] < b[j] then
            c[#c + 1] = a[i]
            i = i + 1
        else
            c[#c + 1] = b[j]
            j = j + 1
        end
    end

    while i <= #a do
        c[#c + 1] = a[i]
        i = i + 1
    end

    while j <= #b do
        c[#c + 1] = b[j]
        j = j + 1
    end

    return c
end

function get_test_lists()
    return {{36, 25, 49, 4, 1, 3, 9, 81, 16, 64}, {9, 8, 7, 6, 5, 4, 3, 2, 1}, {27, 109, 1083, 19, 20, 14},
            shuffle(range(1, 40))}
end

print("Selection sort")
for i = 1, #get_test_lists() do
    local list = get_test_lists()[i]
    print_table(list)
    print_table(selection_sort(list))
end

print("Insertion sort")
for i = 1, #get_test_lists() do
    local list = get_test_lists()[i]
    print_table(list)
    print_table(insertion_sort(list))
end

print("Merge sort")
for i = 1, #get_test_lists() do
    local list = get_test_lists()[i]
    print_table(list)
    print_table(merge_sort(list))
end

