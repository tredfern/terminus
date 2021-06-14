-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Attributes = require "game.rules.character.attributes"
local List = {}

-- COMBAT SKILLS
List.dodge = { name = "Dodge", attribute = Attributes.dexterity }
List.sword = { name = "Sword", attribute = Attributes.dexterity }
List.unarmed = { name = "Unarmed", attribute = Attributes.strength }

return List