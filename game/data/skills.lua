-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.character.skills"
local Attributes = require "game.rules.character.attributes"

Skills:define { name = "Unarmed", key = "unarmed", attribute = Attributes.strength }
Skills:define { name = "Blade", key = "blade", attribute = Attributes.agility }
Skills:define { name = "Handgun", key = "handgun", attribute = Attributes.agility }
Skills:define { name = "Throwing", key = "throwing", attribute = Attributes.agility }