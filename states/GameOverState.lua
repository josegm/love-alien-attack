GameOverState = Class{}

function GameOverState:init(gameState)
  self.game = gameState
  self.state = 'win'
  self.victoryPlayed = false
end

function GameOverState:draw()
  love.graphics.draw(Background)
  love.graphics.setFont(ScoreFont)
  love.graphics.printf('GAME OVER', 0, (VIRTUAL_HEIGHT / 2) - VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(SmallFont)
  love.graphics.printf("You fought bravely and managed to avoid " .. self.game.score.aliens_avoided .. " aliens. Unfortunately, ", 0, (VIRTUAL_HEIGHT / 2) + 8, VIRTUAL_WIDTH, 'center')
  love.graphics.printf("Aliens conquered the Earth and ate everybody", 0, (VIRTUAL_HEIGHT / 2) + 16, VIRTUAL_WIDTH, 'center')
end

function GameOverState:update(dt)
end

function GameOverState:keypressed(key)
  if key == 'escape' or key == 'return' then
    self.game:reset()
    self.game:transition(SplashState(self.game))
  end

  return self.game
end
