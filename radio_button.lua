local button = require "button"

function radio_button(options, button_size)
    return{
        button_size = button_size or 20,
        selected_option = 1,
        button_x = 0, -- button x/y position
        button_y = 0, -- button x/y position

        checkPressed = function (self, mouse_x, mouse_y) -- check if button is pressed
            -- if the mouse x pos + it's radious (because player is a ball) fits into the button, then it is selected and can be pressed
            for i, option in ipairs(options) do
                if mouse_x > self.button_x and mouse_x < self.button_x + self.button_size and mouse_y > self.button_y + (i-1)*self.button_size and mouse_y < self.button_y + i*self.button_size then
                    self.selected_option = i
                end
            end
        end,

        draw = function (self, button_x, button_y) -- draw the button
            self.button_x = button_x or self.button_x -- set the button at it's x/y position
            -- the above and below steps are important for the checkPressed method as well
            self.button_y = button_y or self.button_y -- set the button at it's x/y position

            for i, option in ipairs(options) do
                if i == self.selected_option then
                    love.graphics.setColor(1, 0, 0) -- red color if selected
                else
                    love.graphics.setColor(1, 1, 1) -- white color if not selected
                end
                love.graphics.rectangle("fill", self.button_x, self.button_y + (i-1)*self.button_size, self.button_size, self.button_size)
                love.graphics.setColor(0, 0, 0) -- black color for the circle
                love.graphics.circle("fill", self.button_x + self.button_size/2, self.button_y + (i-1)*self.button_size + self.button_size/2, self.button_size/4)
                -- draw text
                love.graphics.setColor(1, 1, 1) -- white color for the text
                love.graphics.print(option, self.button_x + self.button_size + 10, self.button_y + (i-1)*self.button_size)
        
            end
        end,
    }
end

return radio_button