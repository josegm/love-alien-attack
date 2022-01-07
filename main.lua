local push = require 'push'
Class = require 'class'

require 'Player'

WINDOW_WIDTH=1280
WINDOW_HEIGHT=720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

GROUND_LEVEL = VIRTUAL_HEIGHT - 10
GROUND_FRICTION = 0.20

MAX_SPEED_X = 3

SOUND = true

SOUNDS = {
}

local player = Player(0, 0, 10, 10)

local playerX = VIRTUAL_WIDTH / 2
local playerY = GROUND_LEVEL - 10
local playerSpeedX = 0.0
local playerAccelX = 0.2
local groundFriction = 0.20

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

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
end

function PlaySound(key)
  if SOUND == true then
    love.audio.play(key)
  end
end

function love.update(dt)
  player:update(dt)
end

function love.draw()
  push:start()

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  displayFPS()

  -- draw background
  love.graphics.line(0, GROUND_LEVEL, VIRTUAL_WIDTH, GROUND_LEVEL)

  player:render()

  push:finish()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit();
  end
end
