--[[
  A Brick that can be unlocked via the Lock Powerup. Also worth more than the standard Brick.
]]

LockedBrick = Class{__includes = Brick}

-- particle color RGB value (all the same since block is gray)
local particleRGB = .4 -- (102/255)

function LockedBrick:init(x, y)
  self.super.init(x, y) -- TODO this doesn't work
  self.isLocked = true
  self.points = 5000
end

function LockedBrick:unlock()
  self.isLocked = false
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
    self.psystem.emit(64)
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
