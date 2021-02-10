-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.character.skills"
local Attributes = require "game.rules.character.attributes"

Skills.describe { name = "Unarmed", key = "unarmed", attribute = Attributes.strength }
Skills.describe { name = "Blade", key = "blade", attribute = Attributes.agility }
Skills.describe { name = "Handgun", key = "handgun", attribute = Attributes.agility }
Skills.describe { name = "Throwing", key = "throwing", attribute = Attributes.agility }