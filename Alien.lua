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
  self.width = 16
  self.height = 16
  self.x = math.random(0, VIRTUAL_WIDTH - self.width)
  self.y = (0 - self.height) - math.random(0, 150)
  self.speed_x = math.random(-90, 90)
  if self.speed_x == 0 then self.speed_x = 100 end
  if math.abs(self.speed_x) < 15 then
    self.speed_x = self.speed_x * 4
  end
  self.speed_y = math.random(8, 90)
  self.ready_to_fire = false
  if self.speed_y < 40 then
    self.pending_missiles = 1
    self.fire_at_height = math.random(50, GROUND_LEVEL - 100)
  else
    self.pending_missiles = 0
    self.fire_at_height = 0
  end

  self.alive = true
  self.looking = DIRECTIONS.DOWN
  self.dying = 0
end

function Alien:update(dt)
  if self.dying > 0 then
    self.dying = self.dying - (4 * dt)
  end

  if not self.alive then return end

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

    if self.pending_missiles > 0 and self.fire_at_height < self.y then
      self.ready_to_fire = true
    end
  end

  if (self.x + self.width) < 0 + self.width or self.x > VIRTUAL_WIDTH then
    self.alive = false
  end
end

function Alien:render()
  if self.dying > 0 then
    love.graphics.setColor(1, 1, 1, self.dying)
    love.graphics.draw(SPRITES[self.looking], self.x, self.y, 0, self.dying, self.dying, 0, 0)
    return
  end
  if self.looking == DIRECTIONS.DOWN and math.abs(self.speed_y) > 70 then
    love.graphics.setColor(1, 0, 0, 1)
  elseif (self.looking == DIRECTIONS.LEFT or self.looking == DIRECTIONS.RIGHT) and math.abs(self.speed_x) > 70 then
    love.graphics.setColor(1, 0, 0, 1)
  else
    love.graphics.setColor(1, 1, 1, 1)
  end
  love.graphics.draw(SPRITES[self.looking], self.x, self.y)
end

function Alien:isAtGroundLevel()
  return self.y >= (GROUND_LEVEL - self.height)
end
