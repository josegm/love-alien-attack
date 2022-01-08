Alien = Class {}

function Alien:init(posX, posY, width, height)
  self.x = posX
  self.y = posY
  self.width = width
  self.height = height

  self.speedX = 0.0
  self.speedY = 0.0

  self:reset()
end

function Alien:reset()
  self.x = math.random(0, VIRTUAL_WIDTH - self.width)
  self.y = 0 - self.height
  self.speedX = math.random(-20, 20)
  self.speedY = 30
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
