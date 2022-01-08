local push = require 'push'
Class = require 'class'

require 'Health'
require 'Player'
require 'Alien'

WINDOW_WIDTH=1280
WINDOW_HEIGHT=720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

GROUND_LEVEL = VIRTUAL_HEIGHT - 47
GROUND_FRICTION = 0.20
GRAVITY = 0.40


SOUND = true

SOUNDS = {
}

local player = nil
local health = Health()

local aliens = {}

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
end

function Playsound(key)
  if SOUND == true then
    love.audio.play(key)
  end
end

function love.update(dt)
  player:update(dt)
  health:update(dt)

  -- TODO: this should be in a game class
  for pos, alien in ipairs(aliens) do
    alien:update(dt)
    if alien.alive == false then
      table.remove(aliens, pos)
      table.insert(aliens, Alien())
    end
    if player:check_hit(dt, alien) then
      if health:hit() <= 0 then
        love.event.quit()
      end
    end
  end
end

function love.draw()
  push:start()

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)
  love.graphics.draw(Background)

  displayFPS()

  -- draw background
--  love.graphics.line(0, GROUND_LEVEL, VIRTUAL_WIDTH, GROUND_LEVEL)

  health:render()
  player:render()
  for _, alien in ipairs(aliens) do
    alien:render()
  end

  push:finish()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit();
  end

  player:keypressed(key)
end
