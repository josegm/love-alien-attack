Player = Class {}

LEFT_KEYS = { 'a', 'h', 'left' }
RIGHT_KEYS = { 'd', 'l', 'right' }
UP_KEYS = { 'w', 'k', 'up' }

MAX_SPEED_X = 3
MAX_SPEED_Y = 16
MAX_JUMP = 100

KEYS = {
  LEFT = LEFT_KEYS,
  RIGHT = RIGHT_KEYS,
  UP = UP_KEYS
}

function Player:init(posX, posY, width, height)
  self.x = posX
  self.y = posY
  self.width = width
  self.height = height

  self.speedX = 0.0
  self.speedY = 0.0
  self.deltaX = 0.2
  self.deltaY = 30
  self:reset()
end

function Player:reset()
  self.x = 0
  self.y = GROUND_LEVEL - self.height
  self.speedX = 0.0
  self.speedY = 0.0
  self.deltaX = 0.2
  self.deltaY = 4
end

function Player:update(dt)
  local horizontalImpulse = false

  if love.keyboard.isDown(KEYS.LEFT) then
    if math.abs(self.speedX) < MAX_SPEED_X then
      self.speedX = self.speedX - self.deltaX
    end
    horizontalImpulse = true
  elseif love.keyboard.isDown(KEYS.RIGHT) then
    if math.abs(self.speedX) < MAX_SPEED_X then
      self.speedX = self.speedX + self.deltaX
      horizontalImpulse = true
    end
  end

  -- If user is not moving the player apply friction so players slowly decelerates
  if horizontalImpulse == false then
    if self.speedX > 0 then
      self.speedX = self.speedX - GROUND_FRICTION
    elseif  self.speedX < 0 then
      self.speedX = self.speedX + GROUND_FRICTION
    end

    if math.abs(self.speedX) < GROUND_FRICTION then
      self.speedX = 0
    end
  end

  if self.y < GROUND_LEVEL - self.height then
    self.speedY = (self.speedY - GRAVITY)
  end

  self.x = self.x + self.speedX
  self.y = self.y - self.speedY

  -- check horizontal boundaries
  self.x = math.max(0, self.x)
  self.x = math.min(VIRTUAL_WIDTH-10, self.x)
  if math.abs(self.speedX) > 0 and (self.x == 0 or self.x == VIRTUAL_WIDTH - 10) then
    self.speedX = 0
  end

  -- check vertical boundaries
  if self.y >= (GROUND_LEVEL - self.height) then
    self.y = GROUND_LEVEL - self.height
    self.speedY = 0
  end

  -- check ceiling

  if self.y < GROUND_LEVEL - MAX_JUMP then
    self.y = GROUND_LEVEL - MAX_JUMP
    self.speedY = -GRAVITY
  end
end

function Player:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Player:keypressed(key)
  local upPressed = HasValue(KEYS.UP, key)
  if upPressed then
    if math.abs(self.speedY) < MAX_SPEED_Y then
      self.speedY = self.speedY + self.deltaY
    end
  end
end

function HasValue(array, value)
  for _, val in ipairs(array) do
    if value == val then
      return true
    end
  end
  return false
end
