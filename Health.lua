Health = Class {}

function Health:init()
  self:reset()
end

function Health:reset()
  local margin = 10
  self.width = 50
  self.height = 10
  self.x = VIRTUAL_WIDTH - self.width - margin
  self.y = margin
  self.energy = 100
end

function Health:hit()
  self.energy = self.energy - 20
  return self.energy
end

function Health:update(dt)
end

function Health:render()
  love.graphics.setColor(0, 1, 0, 0.5)
  love.graphics.rectangle("fill", self.x, self.y, self.energy / 2, self.height)
end
