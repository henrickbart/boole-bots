_G.love = require "love"
local button = require "button"
local radio_button = require "radio_button"

States = {
    menu = "menu",
    sub_menu = "sub_menu",
    paused = "paused",
    running = "running",
    ended = "ended"
}

local game = {
    state = States.menu
}

local buttons = { -- basically a button default
    menu_state = {}, -- all the buttons that should be displayed when the menu is shown
    sub_menu_state = {}, -- all the buttons that should be displayed when the game is in the sub menu
}

local function changeState(state)
    game.state = state
end

function love.mousepressed(x, y, button, istouch, presses) -- if mouse is pressed, touch support for mobile can be given here as well
    if button == 1 then -- and the left mouse button is clicked
        if game.state == States.menu then -- if the state is menu
            for index in pairs(buttons.menu_state) do -- check if one of the buttons were pressed
                buttons.menu_state[index]:checkPressed(x, y) -- do your thing if pressed, otherwise ignore
            end
        elseif game.state == States.sub_menu then -- if the state is sub menu
            for index in pairs(buttons.sub_menu_state) do -- check if one of the buttons were pressed
                buttons.sub_menu_state[index]:checkPressed(x, y) -- do your thing if pressed, otherwise ignore
            end
        end
    end
end

function love.load()
    buttons.menu_state.play_game = button("Play Game", changeState, States.sub_menu, 120, 40) -- play game button
    buttons.menu_state.quit_game = button("Quit", love.event.quit, nil, 120, 40) -- play game button

    buttons.sub_menu_state.back = button("Back", changeState, States.menu, 120, 40) -- back button_x
    buttons.sub_menu_state.operations = radio_button({"or", "and", "not"}, 20) -- back button_x
end

function love.update(dt)
end

function love.draw()
    love.graphics.printf("FPS: " .. love.timer.getFPS(), love.graphics.newFont(16), 10, love.graphics.getHeight() - 30, love.graphics.getWidth())

    if game.state == States.sub_menu then
        buttons.sub_menu_state.operations:draw(10, 20)
        -- buttons.sub_menu_state.back:draw(10, 20, 17, 10)
        
    elseif game.state == States.menu then -- if we're at the menu, draw the buttons
        buttons.menu_state.play_game:draw(10, 20, 17, 10)
        buttons.menu_state.quit_game:draw(10, 70, 17, 10)

    end

end