--[[
  A Brick that can be unlocked via the Lock Powerup. Also worth more than the standard Brick.
]]

LockedBrick = Class{__includes = Brick}

-- particle color RGB value (all the same since block is gray)
local particleRGB = .4 -- (102/255)

function LockedBrick:init(x, y)
  -- self.super.init(x, y) -- this doesn't work

  -- only initializing tier and color b/c superclass has them
  self.tier = 0
  self.color = 1

  self.x = x
  self.y = y
  self.width = 32
  self.height = 16

  self.inPlay = true
  self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
  self.psystem:setParticleLifetime(0.5, 1)
  self.psystem:setLinearAcceleration(-15, 0, 15, 80)
  self.psystem:setAreaSpread('normal', 10, 10)

  self.isLocked = true
  -- only worth points if block is unlocked
  self.points = 0
end

function LockedBrick:hit()
  -- fade the particles
  self.psystem:setColors(
    particleRGB,
    particleRGB,
    particleRGB,
    1,
    particleRGB,
    particleRGB,
    particleRGB,
    0
  )

  -- sound on hit
  gSounds['brick-hit-2']:stop()
  gSounds['brick-hit-2']:play()

  -- if block is hit when unlocked, then remove it
  if not self.isLocked then
    self.psystem:emit(64)
    self.inPlay = false
    gSounds['brick-hit-1']:stop()
    gSounds['brick-hit-1']:play()
  end
end

function LockedBrick:render()
  if self.inPlay then
    local brickKey = self.isLocked and 'locked' or 'unlocked'
    love.graphics.draw(gTextures['main'], gFrames['lockedBricks'][brickKey], self.x, self.y)
  end
end
