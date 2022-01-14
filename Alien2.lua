Alien2 = Class {}

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

function Alien2:init()
  self:reset()
end

function Alien2:reset()
  self.width = 16
  self.height = 16
  self.x = -30
  self.y = math.random(0, 100)
  self.speed_x = math.random(50, 100)
  self.speed_y = 0

  self.ready_to_fire = false
  self.pending_missiles = 10
  self.fire_at_height = 0

  self.alive = true
  self.looking = DIRECTIONS.DOWN
  self.dying = 0
end

function Alien2:update(dt)
  if self.dying > 0 then
    self.dying = self.dying - (4 * dt)
  end

  if not self.alive then return end

  self.x = self.x + self.speed_x * dt

  if self.pending_missiles > 0 and math.random(0, 75) == 1 then
    self.ready_to_fire = true
  end

  if self.x > VIRTUAL_WIDTH then
    self.alive = false
  end
end

function Alien2:render()
  if self.dying > 0 then
    love.graphics.setColor(1, 1, 1, self.dying)
    love.graphics.draw(SPRITES[self.looking], self.x, self.y, 0, self.dying, self.dying, 0, 0)
    return
  end

  love.graphics.setColor(0, 0.3, 1, 1)
  love.graphics.draw(SPRITES[self.looking], self.x, self.y)
end

