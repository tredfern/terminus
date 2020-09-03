-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local events = require "moonpie.event_system"
local event_types = require "game.rules.events.types"
local gsm = {}

function gsm.game_start()
  gsm.current = "start"
end

function gsm.combat_start()
  gsm.current = "combat"
end

function gsm.initialize()
  events.subscribe(event_types.combat_start, gsm.combat_start)
  events.subscribe(event_types.game_start, gsm.game_start)
  gsm.current = "start"
end



return gsm