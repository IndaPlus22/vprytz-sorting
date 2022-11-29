require "helper"
require "sorting"

function love.load()
    -- set title and window
    love.window.setMode(960, 720, {
        resizable = true,
        vsync = 0,
        minwidth = 800,
        minheight = 600
    })
    love.window.setTitle("IndaPlus22/vprytz-sorting")

    num_numbers = 50

    -- get array of numbers from 1 to num_numbers
    arr = range(1, num_numbers)
    -- shuffle array
    arr = shuffle(arr)
    -- print array
    print_table(arr)
end

function love.draw()
    -- get window dimensions
    local window_height = love.graphics.getHeight()
    local window_width = love.graphics.getWidth()

    -- box width will be window_width / num_numbers
    local box_width = window_width / num_numbers

    -- draw each num in arr as "box"
    for i = 1, #arr do
        -- box_height "percentage" of screen
        local box_height = arr[i] * (window_height / num_numbers)
        local x = (i - 1) * box_width

        love.graphics.rectangle("fill", x, window_height, box_width, -box_height)
    end
end
