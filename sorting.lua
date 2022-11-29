require "helper"

-- insertion sort
function insertion_sort(arr)
    -- lua starts indexes on 1 for some weird reason..
    local i = 2
    while i < #arr+1 do
        local x = arr[i]
        local j = i - 1

        while j >= 1 and arr[j] > x do
            arr[j + 1] = arr[j]
            j = j - 1
        end
        arr[j+1] = x
        i = i + 1
    end

    return arr
end

-- testing
local testing_arrs = {
    {3, 1, 4, 9, 16, 25, 36, 49, 64, 81},
    {9, 8, 7, 6, 5, 4, 3, 2, 1},
    {27, 109, 1083, 19, 20, 14}
}

for i = 1, #testing_arrs do
    print_table(testing_arrs[i])
    print_table(insertion_sort(testing_arrs[i]))
    print()
end
