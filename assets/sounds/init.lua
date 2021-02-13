-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Audio = require "moonpie.audio"

local sounds = {
  click = Audio.getStatic("assets/sounds/click_sound.wav"),
}

sounds.click:setVolume(0.08)


return sounds