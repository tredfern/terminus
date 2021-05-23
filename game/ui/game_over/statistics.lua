-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local LabelPair = require "game.ui.widgets.label_pair"
local connect = require "moonpie.redux.connect"
local Stats = require "game.rules.stats"

local Statistics = Components("game_over_statistics", function(props)
  return {
    id = "game_over_statistics",
    LabelPair { id = "statTurnCounter", label = "Turns Played", value = props.turnCounter }
  }
end)

return connect(Statistics, function(state)
  return {
    turnCounter = Stats.selectors.getValue(state, Stats.keys.turnCounter)
  }
end)