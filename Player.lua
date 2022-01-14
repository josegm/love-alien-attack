require 'Utils'

Player = Class {}

LEFT_KEYS = { 'a', 'h', 'left' }
RIGHT_KEYS = { 'd', 'l', 'right' }
UP_KEYS = { 'w', 'k', 'up' }
FIRE_KEYS = { 'n', 'space' }

MAX_SPEED_X = 2
MAX_SPEED_Y = 16
MAX_JUMP = 100

KEYS = {
  LEFT = LEFT_KEYS,
  RIGHT = RIGHT_KEYS,
  UP = UP_KEYS,
  FIRE = FIRE_KEYS
}

local SPRITES = {
  FRONT = love.graphics.newImage("sprites/player_front.png"),
  LEFT = love.graphics.newImage("sprites/player_left.png"),
  RIGHT = love.graphics.newImage("sprites/player_right.png"),
  UP = love.graphics.newImage("sprites/player_up.png")
}

local DIRECTIONS = {
  FRONT = 'FRONT',
  LEFT = 'LEFT',
  RIGHT = 'RIGHT',
  UP = 'UP'
}

local SOUNDS = {
  ['shock'] = love.audio.newSource('sounds/electric_shock.mp3', 'static'),
  ['jump_land'] = love.audio.newSource('sounds/jump_land.mp3', 'static'),
  ['jump'] = love.audio.newSource('sounds/jump.mp3', 'static'),
}


function Player:init(sprite)
  self:reset()
end

function Player:reset()
  self.width = 16
  self.height = 16
  self.x = (VIRTUAL_WIDTH / 2) - (self.width / 2)
  self.y = GROUND_LEVEL - self.height
  self.speed_x = 0.0
  self.speed_y = 0.0
  self.delta_x = 0.2
  self.delta_y = 4
  self.hit = false
  self.hit_timer = 0
  self.landed = true

  self.looking = DIRECTIONS.FRONT
end

function Player:check_hit(dt, alien)
  if self.hit_timer > 0 and self.hit_timer < 1 then
    self.hit_timer = self.hit_timer + dt
    return false
  end

  if self.hit_timer >= 1 then
    self.hit = false
    self.hit_timer = 0
    return false
  end

  self.hit = Overlaps(self, alien)
  if self.hit then
    self.hit_timer = 0.1
    return true
  end

  Playsound(SOUNDS.shock)
  return false
end

function Player:update(dt)
  local horizontal_impulse = false

  if love.keyboard.isDown(KEYS.LEFT) then
    if math.abs(self.speed_x) < MAX_SPEED_X then
      self.speed_x = self.speed_x - self.delta_x
    end
    self.looking = DIRECTIONS.LEFT
    horizontal_impulse = true
  elseif love.keyboard.isDown(KEYS.RIGHT) then
    if math.abs(self.speed_x) < MAX_SPEED_X then
      self.speed_x = self.speed_x + self.delta_x
      horizontal_impulse = true
    self.looking = DIRECTIONS.RIGHT
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
      self.looking = DIRECTIONS.FRONT
    else
--      Playsound(SOUNDS.walk)
    end
  end

  if self.y < GROUND_LEVEL - self.height then
    self.speed_y = (self.speed_y - GRAVITY)
  end

  if self.speed_y > 0 then
    self.landed = false
  end

  self.x = self.x + self.speed_x
  self.y = self.y - self.speed_y

  self:check_boundaries()
end

function Player:check_boundaries()
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
    if not self.landed then
      Playsound(SOUNDS.jump_land)
      self.landed = true
    end
  end

  -- check ceiling
  if self.y < GROUND_LEVEL - MAX_JUMP then
    self.y = GROUND_LEVEL - MAX_JUMP
    self.speed_y = -GRAVITY
  end
end

function Player:render()
  if self.hit then
    love.graphics.setColor(1, 0, 0, 1)
  else
    love.graphics.setColor(1, 1, 1, 1)
  end
  love.graphics.draw(SPRITES[self.looking], self.x, self.y)
end

function Player:keypressed(key)
  local up_pressed = Has_value(KEYS.UP, key)

  if up_pressed then
    self.looking = DIRECTIONS.UP
    if math.abs(self.speed_y) < MAX_SPEED_Y then
      self.speed_y = self.speed_y + self.delta_y
    end
    Playsound(SOUNDS.jump)
  end

end
