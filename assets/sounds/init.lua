-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Audio = require "moonpie.audio"
local pitchShifter = require "moonpie.audio.effects.random_pitch"

local sounds = {
  attack = Audio.getStatic("assets/sounds/attack.wav"),
  click = pitchShifter(Audio.getStatic("assets/sounds/click_sound.wav"), 0.9, 1.3),
  hit = Audio.getStatic("assets/sounds/hit.wav"),
  hover = pitchShifter(Audio.getStatic("assets/sounds/hover_sound.wav"), 0.9, 1.3),
  titleTrack = Audio.getStreaming("assets/music/title.ogg"),
  walk = Audio.getStatic("assets/sounds/walk.wav"),
}

sounds.attack.source:setVolume(0.05)
sounds.click.source:setVolume(0.08)
sounds.hit.source:setVolume(0.05)
sounds.hover.source:setVolume(0.03)
sounds.titleTrack.source:setLooping(true)
sounds.titleTrack.source:setVolume(0.5)
sounds.walk.source:setVolume(0.05)


return sounds