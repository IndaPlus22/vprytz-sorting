require "helper"
require "sorting"

num_numbers = 50

app_state = {
    menu = true,
    algorithm = 0,
    arr = {}
}

function reset_arr()
    -- get array of numbers from 1 to num_numbers
    -- then shuffle it
    app_state.arr = shuffle(range(1, num_numbers))
end

function love.load()
    -- set title and window
    love.window.setMode(960, 720, {
        resizable = true,
        vsync = 0,
        minwidth = 800,
        minheight = 600
    })
    love.window.setTitle("IndaPlus22/vprytz-sorting")

    -- reset_arr
    reset_arr()

    -- timer
    count = 0
end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "r" then
        app_state.menu = true
        app_state.algorithm = 0
        count = 0
        reset_arr()
    end
    if app_state.menu then
        if key == "1" then
            app_state.menu = false
            app_state.algorithm = 1
        end
        if key == "2" then
            app_state.menu = false
            app_state.algorithm = 2
        end
    end
end

function love.update(dt)
    if not app_state.menu then
        count = count + dt

        if count > 1 then
            count = 0
            if app_state.algorithm == 1 then
                insertion_sort(app_state.arr)
            end
            if app_state.algorithm == 2 then
                selection_sort(app_state.arr)
            end
        end
    end
end

function love.draw()
    if app_state.menu then
        local menu_text = {"Press number to sort using specified algorithm", "Press R at any time to restart",
                           "1. Insertion sort", "2. Selection sort"}

        for i = 1, #menu_text do
            love.graphics.print(menu_text[i], 10, 10 + 15 * (i - 1))
        end
    else
        -- get window dimensions
        local window_height = love.graphics.getHeight()
        local window_width = love.graphics.getWidth()

        -- box width will be window_width / num_numbers
        local box_width = window_width / num_numbers

        -- draw each num in arr as "box"
        for i = 1, #app_state.arr do
            -- box_height "percentage" of screen
            local box_height = app_state.arr[i] * (window_height / num_numbers)
            local x = (i - 1) * box_width

            love.graphics.rectangle("fill", x, window_height, box_width, -box_height)
        end
    end
end
