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

-- testing
-- local testing_arrs = {
--     {36, 25, 49, 4, 1, 3, 9, 81, 16, 64},
--     {9, 8, 7, 6, 5, 4, 3, 2, 1},
--     {27, 109, 1083, 19, 20, 14},
--     shuffle(range(1, 40))
-- }

-- for i = 1, #testing_arrs do
--     print_table(testing_arrs[i])
--     print("Insertion sort:")
--     print_table(insertion_sort(testing_arrs[i]))
--     print("Selection sort:")
--     print_table(selection_sort(testing_arrs[i]))
--     print()
-- end
