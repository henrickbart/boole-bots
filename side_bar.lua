local love = require "love"

function side_bar(width, text)
    return {
        text = text or "No Text",
        width = width or 150,
        text_x = function (self)
            return (self.width / 2) - (love.graphics.getFont():getWidth(self.text) / 2)           
        end,
        text_y = 10,
        draw = function(self)
            love.graphics.setColor(0.6, 0.6, 0.6) -- set button color
            -- draw button
            love.graphics.rectangle("fill", 0, 0, self.width, love.graphics.getHeight())

            love.graphics.setColor(0, 0, 0) -- set text color
            -- draw text

            love.graphics.print(self.text, self:text_x(), self.text_y)
        end
    }
end

return side_bar