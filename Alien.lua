Alien = Class {}

function Alien:init()
  -- self.width = math.random(3, 10)
  -- self.height = math.random(4, 10)
  -- self.x = math.random(0, VIRTUAL_WIDTH - self.width)
  -- self.y = (0 - self.height) - math.random(0, 150)
  -- self.speedX = math.random(-20, 20)
  -- self.speedY = math.random(8, 30)
  --
  self:reset()
end

function Alien:reset()
  self.width = math.random(3, 10)
  self.height = math.random(4, 10)
  self.x = math.random(0, VIRTUAL_WIDTH - self.width)
  self.y = (0 - self.height) - math.random(0, 150)
  self.speedX = math.random(-20, 20)
  self.speedY = math.random(8, 30)

end

function Alien:update(dt)
  if self:isAtGroundLevel() then
    self.x = self.x + self.speedX * dt
  else
    self.y = self.y + self.speedY * dt
  end
end

function Alien:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Alien:keypressed(key)
  local upPressed = HasValue(KEYS.UP, key)
  if upPressed then
    if math.abs(self.speedY) < MAX_SPEED_Y then
      self.speedY = self.speedY + self.deltaY
    end
  end
end

function Alien:isAtGroundLevel()
  return self.y >= (GROUND_LEVEL - self.height)
end
