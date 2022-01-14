PlayState = Class{}

DIRECTION_LEFT = -1
DIRECTION_RIGHT = 1

local SOUNDS = {
  ['bullet'] = love.audio.newSource('sounds/bullet.mp3', 'static'),
  ['alien_hit'] = love.audio.newSource('sounds/alien_hit.mp3', 'static'),
}

function PlayState:init(gameState)
  self.game = gameState
  self.state = 'play'

  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
  -- table.insert(self.game.aliens, Alien())
end

function PlayState:update(dt)
  local game_over = false

  self.game.player:update(dt)
  self.game.health:update(dt)

  for pos, bullet in ipairs(self.game.bullets) do
    bullet:update(dt)

    for _, alien in ipairs(self.game.aliens) do
      if alien.alive and Overlaps(bullet, alien) then
        alien.dying = 1
        alien.alive = false
        bullet.alive = false
        Playsound(SOUNDS.alien_hit)
        break
      end
    end

    if bullet.alive == false then
      table.remove(self.game.bullets, pos)
    end
  end

  -- TODO: this should be in a game class?
  for pos, alien in ipairs(self.game.aliens) do
    alien:update(dt)
    if not alien.alive and alien.dying < 0.2 then
      table.remove(self.game.aliens, pos)
      table.insert(self.game.aliens, Alien())
      self.game.score:count()
    end

    if self.game.player:check_hit(dt, alien) then
      if self.game.health:hit() <= 0 then
        game_over = true
      end
    end
  end

  -- losing condition?
  if game_over then
    self.game:transition(GameOverState(self.game))
  end
end

function PlayState:draw()
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  love.graphics.draw(Background)

  -- draw ground line
  --  love.graphics.line(0, GROUND_LEVEL, VIRTUAL_WIDTH, GROUND_LEVEL)

  local shadow = function(entity)
    local shadowLengthFactor = ((GROUND_LEVEL - entity.y) * 100 / GROUND_LEVEL) * 0.25
    shadowLengthFactor = math.min(entity.width / 2, shadowLengthFactor)
    love.graphics.setColor(0, 0, 0, 0.3)
    love.graphics.line(entity.x+shadowLengthFactor, GROUND_LEVEL+8, entity.x + entity.width - shadowLengthFactor, GROUND_LEVEL+8)
  end

  self.game.health:render()
  self.game.score:render()
  self.game.player:render()
  shadow(self.game.player)


  for _, alien in ipairs(self.game.aliens) do
    alien:render()
    shadow(alien)
  end

  for _, bullet in ipairs(self.game.bullets) do
    bullet:render()
  end
end

function PlayState:keypressed(key)
  local fire_pressed = Has_value(KEYS.FIRE, key)

  if fire_pressed then
    if #self.game.bullets < MAX_BULLETS then
      table.insert(self.game.bullets, Bullet(self.game.player))
      Playsound(SOUNDS.bullet)
    end
  end

  if key == 'escape' then
    self.game:transition(SplashState(self.game))
  else
    self.game.player:keypressed(key)
  end
  return self.game
end
