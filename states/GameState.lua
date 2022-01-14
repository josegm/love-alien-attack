require 'Player'
require 'Alien'
require 'Alien2'
require 'Health'
require 'Score'
require 'Bullet'
require 'Missile'

require 'states.PlayState'
require 'states.SplashState'
require 'states.GameOverState'

GameState = Class{}

function GameState:init()
  self.player = Player()
  self.health = Health()
  self.score = Score()
  self.aliens = {}
  self.bullets = {}
  self.missiles = {}
  self.state = SplashState(self)
end

function GameState:transition(newGameState)
  self.state = newGameState
end

function GameState:reset()
  self.player:reset()
  self.health:reset()
  self.score:reset()
  self.aliens = {}
  self.bullets = {}
end

function GameState:keypressed(key)
  self = self.state:keypressed(key)
end

function GameState:update(dt)
  self.state:update(dt)
end

function GameState:draw()
  self.state:draw()
end
