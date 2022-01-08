Score = Class {}

function Score:init()
  self.aliens_avoided = 0
  self:reset()
end

function Score:reset()
  self.aliens_avoided = 0
end

function Score:count()
  self.aliens_avoided = self.aliens_avoided + 1
end

function Score:update(dt)
end

function Score:render()
  love.graphics.setColor(1, 1, 1, 0.5)
  love.graphics.printf("Aliens avoided: " .. self.aliens_avoided, 10, 10, 100, "left")
end
