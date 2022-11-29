require "helper"
require "sorting"

num_numbers = 200
speed = 8 / num_numbers

app_state = {
    menu = true,
    algorithm = 0,
    arr = {},
    i = 2,
    j = 0,
    max_offset = 1
}

function beep()
    local freq = math.random(500, 10000)

    local rate = 44100 -- samples per second
    local length = 1 / 64 -- 0.03125 seconds
    -- local tone = 440.0 -- Hz
    local tone = freq
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
    app_state.arr = shuffle(range(1, num_numbers))
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
    end
end

function love.update(dt)
    if not app_state.menu then
        count = count + dt

        if app_state.i > #app_state.arr then
            -- reset j
            app_state.j = 0
        end

        if count > speed and app_state.i < #app_state.arr + app_state.max_offset then
            count = 0
            beep()
            if app_state.algorithm == 1 then
                app_state.j = insertion_sort_step(app_state.arr, app_state.i)
                app_state.i = app_state.i + 1
            end
            if app_state.algorithm == 2 then
                app_state.j = selection_sort_step(app_state.arr, app_state.i)
                app_state.i = app_state.i + 1
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
