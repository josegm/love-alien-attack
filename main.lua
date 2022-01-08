local push = require 'push'
Class = require 'class'

require 'states.GameState'

require 'Health'
require 'Player'
require 'Alien'

WINDOW_WIDTH=1280
WINDOW_HEIGHT=720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

GROUND_LEVEL = VIRTUAL_HEIGHT - 47
GROUND_FRICTION = 0.40
GRAVITY = 0.40

SOUND = true

local game = GameState()

local aliens = {}

local main_timer = 0

local showFPS= true

local function displayFPS()
  if showFPS == false then
    return
  end

  love.graphics.setFont(SmallFont)
  love.graphics.setColor(0, 255/255, 0, 255/255)
  love.graphics.print(tostring(love.timer.getFPS()), 10, 10)
  love.graphics.setColor(1, 1, 1, 1)
end

function love.load()
  math.randomseed(os.time())

  love.graphics.setDefaultFilter('nearest', 'nearest')

  ScoreFont = love.graphics.newFont('fonts/font.ttf', 32)
  SmallFont = love.graphics.newFont('fonts/font.ttf', 8)
  Background = love.graphics.newImage("sprites/backg.png")

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
  player = Player()

  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())
  table.insert(aliens, Alien())

  main_timer = love.timer.getTime()
end

function Playsound(key)
  if SOUND == true then
    love.audio.stop(key)
    love.audio.play(key)
  end
end

function love.update(dt)
  game:update(dt)
end

local function seconds_elapsed()
  return (love.timer.getTime() - main_timer)
end

function love.draw()
  push:start()

  displayFPS()
  game:draw()

  push:finish()
end

function love.keypressed(key)
  game:keypressed(key)
end
