--[[
  Item that spawns randomly and gradually descends toward the player. If it
  collides with the Paddle, two more Balls spawn, each behaving identically to
  the original, including all collision and scoring points for the player. The
  power up does not carry over to the next level - the player will start over
  with only one ball.
]]

Powerup = Class{}

local GRAVITY = .25

function Powerup:init(skin)
  self.width = 16
  self.height = 16

  self.x = math.random(VIRTUAL_WIDTH)
  self.y = -16
  self.dy = 0

  self.inPlay = false -- determine to render or not

  self.skin = skin
end

--[[
  Check to see if it has collided with the paddle.
]]
function Powerup:collides(target)
  -- first, check to see if the left edge of either is farther to the right
  -- than the right edge of the other
  if self.x > target.x + target.width or target.x > self.x + self.width then
      return false
  end

  -- then check to see if the bottom edge of either is higher than the top
  -- edge of the other
  if self.y > target.y + target.height or target.y > self.y + self.height then
      return false
  end

  -- if the above aren't true, they're overlapping
  return true
end

function Powerup:update(dt)
  self.dy = self.dy + GRAVITY * dt
  self.y = self.y + self.dy
end

function Powerup:render()
  if self.inPlay then
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin], self.x, self.y)
  end
end
