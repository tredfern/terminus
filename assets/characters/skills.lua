-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = require "game.rules.skills"
local Attributes = require "game.rules.character.attributes"

-- Offensive Skills
Skills.describe { name = "Unarmed", key = "unarmed", attribute = Attributes.strength }
Skills.describe { name = "Blade", key = "blade", attribute = Attributes.agility }
Skills.describe { name = "Handgun", key = "handgun", attribute = Attributes.agility }
Skills.describe { name = "Throwing", key = "throwing", attribute = Attributes.agility }


-- Defensive Skills
Skills.describe { name = "Dodge", key = "dodge", attribute = Attributes.agility, untrained = -2 }
Skills.describe { name = "Parry", key = "parry", attribute = Attributes.agility, untrained = -4 }
Skills.describe { name = "Shield", key = "shield", attribute = Attributes.agility, untrained = -3 }