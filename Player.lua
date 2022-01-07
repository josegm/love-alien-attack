Player = Class {}

LEFT_KEYS = { 'a', 'h', 'left' }
RIGHT_KEYS = { 'd', 'l', 'right' }
UP_KEYS = { 'w', 'k', 'up' }

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
  self.deltaX = 0.2
  self:reset()
end

function Player:reset()
  self.y = GROUND_LEVEL - self.height
end

function Player:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Player:update(dt)
  local playerImpulsed = false
  
  print(self.speedX)
  if love.keyboard.isDown(KEYS.LEFT) then
    if math.abs(self.speedX) < MAX_SPEED_X then
      self.speedX = self.speedX - self.deltaX
    end
    playerImpulsed = true
  elseif love.keyboard.isDown(KEYS.RIGHT) then
    if math.abs(self.speedX) < MAX_SPEED_X then
      self.speedX = self.speedX + self.deltaX
      playerImpulsed = true
    end
  end

  -- If user is not moving the player apply friction so players slowly decelerates
  if playerImpulsed == false then
    if self.speedX > 0 then
      self.speedX = self.speedX - GROUND_FRICTION
    elseif  self.speedX < 0 then
      self.speedX = self.speedX + GROUND_FRICTION
    end

    if math.abs(self.speedX) < GROUND_FRICTION then
      self.speedX = 0
    end
  end

  self.x = self.x + self.speedX

  -- check screen boundaries
  self.x = math.max(0, self.x)
  self.x = math.min(VIRTUAL_WIDTH-10, self.x)
  if math.abs(self.speedX) > 0 and (self.x == 0 or self.x == VIRTUAL_WIDTH - 10) then
    self.speedX = 0
  end
end
