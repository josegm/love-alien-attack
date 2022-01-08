Alien = Class {}

local SPRITES = {
  DOWN = love.graphics.newImage("sprites/alien_falling.png"),
  LEFT = love.graphics.newImage("sprites/alien_left.png"),
  RIGHT = love.graphics.newImage("sprites/alien_right.png"),
}

local DIRECTIONS = {
  DOWN = 'DOWN',
  LEFT = 'LEFT',
  RIGHT = 'RIGHT'
}

function Alien:init()
  self:reset()
end

function Alien:reset()
  -- self.width = math.random(3, 10)
  -- self.height = math.random(4, 10)
  self.width = 16
  self.height = 16
  self.x = math.random(0, VIRTUAL_WIDTH - self.width)
  self.y = (0 - self.height) - math.random(0, 150)
  self.speed_x = math.random(-80, 90)
  if math.abs(self.speed_x) < 15 then
    self.speed_x = self.speed_x * 4
  end
  self.speed_y = math.random(8, 50)
  self.alive = true
  self.looking = DIRECTIONS.DOWN
end

function Alien:update(dt)
  if self.alive == false then
    print("Alien dead")
    return
  end

  if self:isAtGroundLevel() then
    self.x = self.x + self.speed_x * dt

    if self.speed_x < 0 then
      self.looking = DIRECTIONS.LEFT
    else
      self.looking = DIRECTIONS.RIGHT
    end
  else
    self.y = self.y + self.speed_y * dt
    self.looking = DIRECTIONS.DOWN
  end

  if (self.x + self.width) < 0 + self.width or self.x > VIRTUAL_WIDTH then
    self.alive = false
  end
end

function Alien:render()
  love.graphics.setColor(1, 1, 1, 1)
--  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.draw(SPRITES[self.looking], self.x, self.y)
end

function Alien:isAtGroundLevel()
  return self.y >= (GROUND_LEVEL - self.height)
end
