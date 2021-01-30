-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"

local character = {}

function character:constructor(props)
  props = props or {}
  self.x = props.x or 0
  self.y = props.y or 0
  self.is_player_controlled = props.is_player_controlled
  self.is_enemy = props.is_enemy
  self.health = 10
  self.attack = 50
  self.defense = 50
end

function character:set_position(x, y)
  self.x = x
  self.y = y
end

return class(character)