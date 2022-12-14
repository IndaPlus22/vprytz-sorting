require "helper"
require "sorting"

app_state = {
    menu = true,
    algorithm = 0,
    arr = {},
    i = 2,
    j = 1,
    max_offset = 1,
    num_numbers = 300,
    speed = 0
}

app_state.speed = 8 / app_state.num_numbers

function beep(percentage)
    -- local tone = 500 / 10000 * percentage

    local rate = 44100 -- samples per second
    local length = 1 / 64 -- 0.03125 seconds
    -- local tone = 440.0 -- Hz
    local tone = percentage * 10000
    local p = math.floor(rate / tone) -- 100 (wave length in samples)
    local soundData = love.sound.newSoundData(math.floor(length * rate), rate, 16, 1)
    for i = 0, soundData:getSampleCount() - 1 do
        --	soundData:setSample(i, math.sin(2*math.pi*i/p)) -- sine wave.
        soundData:setSample(i, i % p < p / 2 and 1 or -1) -- square wave; the first half of the wave is 1, the second half is -1.
    end
    local source = love.audio.newSource(soundData)
    source:play()
end

function reset_arr()
    -- get array of numbers from 1 to num_numbers
    -- then shuffle it
    app_state.arr = shuffle(range(1, app_state.num_numbers))
end

function love.load()
    -- set title and window
    love.window.setMode(960, 720, {
        resizable = true,
        vsync = 0
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
        app_state.i = 2
        count = 0
        reset_arr()
    end
    if app_state.menu then
        if key == "1" then
            app_state.menu = false
            app_state.algorithm = 1
            app_state.max_offset = 1
        end
        if key == "2" then
            app_state.menu = false
            app_state.algorithm = 2
            app_state.i = 1
            app_state.max_offset = 0
        end
        if key == "3" then
            app_state.menu = false
            app_state.algorithm = 3
            app_state.i = 1
            app_state.max_offset = 0
        end
        if key == "+" then
            app_state.num_numbers = app_state.num_numbers + 10
            app_state.speed = 8 / app_state.num_numbers
            reset_arr()
        end
        if key == "-" then
            app_state.num_numbers = app_state.num_numbers - 10
            app_state.speed = 8 / app_state.num_numbers
            reset_arr()
        end
    end
end

function love.update(dt)
    if not app_state.menu then
        count = count + dt

        if app_state.algorithm == 3 then
            if app_state.j >= #app_state.arr then
                app_state.i = app_state.i + 1
                app_state.j = 1
            end
        end

        if app_state.i > #app_state.arr then
            -- reset j
            app_state.j = 0
        end

        if count > app_state.speed and app_state.i < #app_state.arr + app_state.max_offset then
            count = 0
            beep(app_state.j / #app_state.arr)
            if app_state.algorithm == 1 then
                app_state.j = insertion_sort_step(app_state.arr, app_state.i)
                app_state.i = app_state.i + 1
            end
            if app_state.algorithm == 2 then
                app_state.j = selection_sort_step(app_state.arr, app_state.i)
                app_state.i = app_state.i + 1
            end
            if app_state.algorithm == 3 then
                print("debug, i,j " .. app_state.i .. ", " .. app_state.j)
                bubble_sort_step(app_state.arr, app_state.i, app_state.j)
                app_state.j = app_state.j + 1
            end
        end
    end
end

function love.draw()
    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()), 10, 10)

    if app_state.menu then
        local menu_text = {"Press number to sort using specified algorithm", "Press R at any time to restart",
                           "1. Insertion sort", "2. Selection sort", "3. Bubble sort",
                           "Increase numbers of numbers with 10 pressing +, decrease with 10 by pressing -",
                           "Number of numbers to sort: " .. tostring(app_state.num_numbers)}

        for i = 1, #menu_text do
            love.graphics.print(menu_text[i], 10, 25 + 15 * (i - 1))
        end
    else
        -- get window dimensions
        local window_height = love.graphics.getHeight()
        local window_width = love.graphics.getWidth()

        -- box width will be window_width / num_numbers
        local box_width = window_width / app_state.num_numbers

        -- draw each num in arr as "box"
        for i = 1, #app_state.arr do
            -- box_height "percentage" of screen
            local box_height = app_state.arr[i] * (window_height / app_state.num_numbers)
            local x = (i - 1) * box_width

            if i == app_state.i then
                love.graphics.setColor(0, 255, 0)
            elseif i == app_state.j then
                love.graphics.setColor(255, 0, 0)
            else
                love.graphics.setColor(255, 255, 255)
            end

            love.graphics.rectangle("fill", x, window_height, box_width, -box_height)
        end
    end
end
