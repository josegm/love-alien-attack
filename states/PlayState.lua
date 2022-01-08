PlayState = Class{}

DIRECTION_LEFT = -1
DIRECTION_RIGHT = 1

function PlayState:init(gameState)
  self.game = gameState
  self.state = 'play'

  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
  table.insert(self.game.aliens, Alien())
end

function PlayState:update(dt)
  local game_over = false

  self.game.player:update(dt)
  self.game.health:update(dt)

  -- TODO: this should be in a game class
  for pos, alien in ipairs(self.game.aliens) do
    alien:update(dt)
    if alien.alive == false then
      table.remove(self.game.aliens, pos)
      table.insert(self.game.aliens, Alien())
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

  self.game.health:render()
  self.game.player:render()
  for _, alien in ipairs(self.game.aliens) do
    alien:render()
  end
end

function PlayState:keypressed(key)
  if key == 'escape' then
    self.game:transition(SplashState(self.game))
  else
    self.game.player:keypressed(key)
  end
  return self.game
end
