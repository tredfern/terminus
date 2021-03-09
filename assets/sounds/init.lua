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
  attack = wrapper(Audio.getStatic("assets/sounds/attack.wav")),
  click = wrapper(Audio.getStatic("assets/sounds/click_sound.wav")),
  hit = wrapper(Audio.getStatic("assets/sounds/hit.wav")),
  hover = wrapper(Audio.getStatic("assets/sounds/hover_sound.wav")),
  titleTrack = Audio.getStreaming("assets/music/title.ogg"),
  walk = wrapper(Audio.getStatic("assets/sounds/walk.wav")),
}

sounds.attack.setVolume(0.05)
sounds.click.setVolume(0.08)
sounds.hit.setVolume(0.05)
sounds.hover.setVolume(0.03)
sounds.titleTrack:setLooping(true)
sounds.titleTrack:setVolume(0.5)
sounds.walk.setVolume(0.05)


return sounds