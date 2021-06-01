-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Skills = {}

Skills.actions = require "game.rules.skills.actions"
Skills.chooseSkill = require "game.rules.skills.choose_skill"
Skills.selectors = require "game.rules.skills.selectors"
Skills.reducer = require "game.rules.skills.reducer"
Skills.list = require "game.rules.skills.list"

return Skills