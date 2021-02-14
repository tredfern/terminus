-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Audio = require "moonpie.audio"

local function wrapper(soundSource)
  return {
    play = function()
      soundSource:seek(0)
      local pitchMod = 0.9 + love.math.random(0, 10)/50
      soundSource:setPitch(pitchMod)
      soundSource:play()
    end,
    setVolume = function(v)
      soundSource:setVolume(v)
    end
  }
end

local sounds = {
  click = wrapper(Audio.getStatic("assets/sounds/click_sound.wav")),
  hover = wrapper(Audio.getStatic("assets/sounds/hover_sound.wav"))
}

sounds.click.setVolume(0.08)
sounds.hover.setVolume(0.03)


return sounds