Bullet = Class {}

local SPEED = 100

function Bullet:init(x, y)
  self.x = x
  self.y = y
  self.width = 1
  self.height = 1
  self.speed = 0
  self.alive = true
  self:reset()
end

function Bullet:reset()
end

function Bullet:update(dt)
  if not self.alive then return end

  self.y = self.y - (SPEED * dt)

  if self.y < 0 then self.alive = false end
end

function Bullet:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.line(self.x, self.y, self.x, self.y + 1)
end
