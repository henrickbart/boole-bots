local love = require "love"

function Button(text, func, func_param, width, height)
    return { -- return table
        width = width or 100, -- button width
        height = height or 100, -- button height
        -- the function that should be called when button is pressed
        func = func or function() print("This button has no function attached") end,
        -- function parameter that should be passed in when function is called
        func_param = func_param,
        text = text or "No Text", -- text to be displayed on the button
        button_x = 0, -- button x/y position
        button_y = 0, -- button x/y position
        text_x = 0, -- text x/y position
        text_y = 0, -- text x/y position
        
        checkPressed = function (self, mouse_x, mouse_y) -- check if button is pressed
            -- if the mouse x pos + it's radious (because player is a ball) fits into the button, then it is selected and can be pressed
            if (mouse_x >= self.button_x) and (mouse_x <= self.button_x + self.width) then
                if (mouse_y >= self.button_y) and (mouse_y <= self.button_y + self.height) then
                    -- execute the passed in function with/without parameter
                    if self.func_param then
                        self.func(self.func_param)
                    else
                        self.func()
                    end
                end
            end
        end,

        draw = function (self, button_x, button_y) -- draw the button
            self.button_x = button_x or self.button_x -- set the button at it's x/y position
            -- the above and below steps are important for the checkPressed method as well
            self.button_y = button_y or self.button_y -- set the button at it's x/y position
        
            -- calculate the text x/y position
            self.text_x = self.button_x + (self.width / 2) - (love.graphics.getFont():getWidth(self.text) / 2)
            self.text_y = self.button_y + (self.height / 2) - (love.graphics.getFont():getHeight(self.text) / 2)

        
            -- NOTE: The drawing order is important
            love.graphics.setColor(0.6, 0.6, 0.6) -- set button color
            -- draw button
            love.graphics.rectangle("fill", self.button_x, self.button_y, self.width, self.height)
        
            love.graphics.setColor(0, 0, 0) -- set text color
            -- draw text
            love.graphics.print(self.text, self.text_x, self.text_y)
        
            love.graphics.setColor(1, 1, 1) -- reset the colors
        end,
        getWidth = function (self) -- get the button width
            return self.width
        end,
        getHeight = function (self) -- get the button height
            return self.height
        end
    }
end

return Button
