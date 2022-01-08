Alien = Class {}

function Alien:init()
  -- self.width = math.random(3, 10)
  -- self.height = math.random(4, 10)
  -- self.x = math.random(0, VIRTUAL_WIDTH - self.width)
  -- self.y = (0 - self.height) - math.random(0, 150)
  -- self.speed_x = math.random(-20, 20)
  -- self.speed_y = math.random(8, 30)
  --
  self:reset()
end

function Alien:reset()
  self.width = math.random(3, 10)
  self.height = math.random(4, 10)
  self.x = math.random(0, VIRTUAL_WIDTH - self.width)
  self.y = (0 - self.height) - math.random(0, 150)
  self.speed_x = math.random(-20, 20)
  self.speed_y = math.random(8, 30)

end

function Alien:update(dt)
  if self:isAtGroundLevel() then
    self.x = self.x + self.speed_x * dt
  else
    self.y = self.y + self.speed_y * dt
  end
end

function Alien:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Alien:isAtGroundLevel()
  return self.y >= (GROUND_LEVEL - self.height)
end
