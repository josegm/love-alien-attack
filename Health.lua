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
  self.recover_speed = 1
end

function Health:hit()
  self.energy = self.energy - 5
  return self.energy
end

function Health:update(dt)
  if self.energy < 100 then
    self.energy = self.energy + self.recover_speed * dt
  end
end

function Health:render()
  love.graphics.setColor(0, 1, 0, 0.5)
  love.graphics.rectangle("fill", self.x, self.y, self.energy / 2, self.height)
end
