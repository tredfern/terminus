-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local World = require "game.rules.world"
local Sprite = require "game.rules.graphics.sprite"

local Keycard = {
  actions = {},
  selectors = {}
}

function Keycard.actions.add(position)
  return World.actions.addEntity {
    key = "keycard",
    name = "Keycard",
    position = position,
    sprite = Sprite.fromFile("assets/graphics/keycard.png"),
    item = true
  }
end



return Keycard