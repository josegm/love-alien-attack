Bullet = Class {}

local BULLET_SPEED = 349

local DIRECTIONS = {
  LEFT = 'LEFT',
  RIGHT = 'RIGHT',
  UP = 'UP',
  FRONT = 'FRONT'
}


function Bullet:init(player)
  if player.looking == DIRECTIONS.UP or player.looking == DIRECTIONS.FRONT then
    self.x = player.x + (player.width / 2)
    self.y = player.y
  elseif self.direction == DIRECTIONS.RIGHT then
    self.x = player.x + player.width
    self.y = player.y + (player.height / 2)
  else -- LEFT
    self.x = player.x
    self.y = player.y + (player.height / 2)
  end

  self.width = 1
  self.height = 1
  self.direction = player.looking
  self.alive = true
  self:reset()
end

function Bullet:reset()
end

function Bullet:update(dt)
  if not self.alive then return end

  if self.direction == DIRECTIONS.UP or self.direction == DIRECTIONS.FRONT then
    self.y = self.y - (BULLET_SPEED * dt)
  elseif self.direction == DIRECTIONS.RIGHT then
    self.x = self.x + (BULLET_SPEED * dt)
  else
    self.x = self.x - (BULLET_SPEED * dt)
  end

  if self.y < 0 or self.x > VIRTUAL_WIDTH or self.x < 0 then self.alive = false end
end

function Bullet:render()
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.line(self.x, self.y, self.x, self.y + 1)
end
