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

function Player:init()
  self:reset()
end

function Player:reset()
  self.width = 10
  self.height = 10
  self.x = (VIRTUAL_WIDTH / 2) - (self.width / 2)
  self.y = GROUND_LEVEL - self.height
  self.speed_x = 0.0
  self.speed_y = 0.0
  self.delta_x = 0.2
  self.delta_y = 4
end

function Player:update(dt)
  local horizontal_impulse = false

  if love.keyboard.isDown(KEYS.LEFT) then
    if math.abs(self.speed_x) < MAX_SPEED_X then
      self.speed_x = self.speed_x - self.delta_x
    end
    horizontal_impulse = true
  elseif love.keyboard.isDown(KEYS.RIGHT) then
    if math.abs(self.speed_x) < MAX_SPEED_X then
      self.speed_x = self.speed_x + self.delta_x
      horizontal_impulse = true
    end
  end

  -- If user is not moving the player apply friction so players slowly decelerates
  if horizontal_impulse == false then
    if self.speed_x > 0 then
      self.speed_x = self.speed_x - GROUND_FRICTION
    elseif  self.speed_x < 0 then
      self.speed_x = self.speed_x + GROUND_FRICTION
    end

    if math.abs(self.speed_x) < GROUND_FRICTION then
      self.speed_x = 0
    end
  end

  if self.y < GROUND_LEVEL - self.height then
    self.speed_y = (self.speed_y - GRAVITY)
  end

  self.x = self.x + self.speed_x
  self.y = self.y - self.speed_y

  -- check horizontal boundaries
  self.x = math.max(0, self.x)
  self.x = math.min(VIRTUAL_WIDTH-10, self.x)
  if math.abs(self.speed_x) > 0 and (self.x == 0 or self.x == VIRTUAL_WIDTH - 10) then
    self.speed_x = 0
  end

  -- check vertical boundaries
  if self.y >= (GROUND_LEVEL - self.height) then
    self.y = GROUND_LEVEL - self.height
    self.speed_y = 0
  end

  -- check ceiling

  if self.y < GROUND_LEVEL - MAX_JUMP then
    self.y = GROUND_LEVEL - MAX_JUMP
    self.speed_y = -GRAVITY
  end
end

function Player:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Player:keypressed(key)
  local up_pressed = Has_value(KEYS.UP, key)
  if up_pressed then
    if math.abs(self.speed_y) < MAX_SPEED_Y then
      self.speed_y = self.speed_y + self.delta_y
    end
  end
end

function Has_value(array, value)
  for _, val in ipairs(array) do
    if value == val then
      return true
    end
  end
  return false
end
