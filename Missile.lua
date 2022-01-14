Missile = Class {}

local MISSILE_SPEED = 149

function Missile:init(alien, target)
  self.alive = true
  self.width = 3
  self.height = 3
  self.x = alien.x + alien.width / 2
  self.y = alien.y + alien.height / 2
  self.toX = target.x + target.width / 2
  self.toY = target.y + target.height / 2

  local dist = math.sqrt(math.pow(self.toX - self.x,  2) + math.pow(self.toY - self.y, 2))
  self.speed_x = (self.toX - self.x)/dist
  self.speed_y = (self.toY - self.y)/dist

  self.speed_x = self.speed_x * MISSILE_SPEED
  self.speed_y = self.speed_y * MISSILE_SPEED
  print("nx: " .. self.speed_x .. "ny: " .. self.speed_y)

  self:reset()
end

function Missile:reset()
end

function Missile:update(dt)
  if not self.alive then return end
  self.x = self.x + (self.speed_x * dt)
  self.y = self.y + (self.speed_y * dt)
end

function Missile:render()
  love.graphics.setColor(1, math.random(0.1, 1), math.random(0.1, 1), 1)
  love.graphics.circle("fill", self.x, self.y, 3, 5)
end
