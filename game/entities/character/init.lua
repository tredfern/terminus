-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local attr = require "game.entities.character.attribute"


local character = {}

function character:constructor(props)
  props = props or {}
  self.name = props.name
  self.strength = attr()
  self.dexterity = attr()
  self.endurance = attr()
  self.intelligence = attr()
  self.knowledge = attr()
  self.personality = attr()
end



return class(character)