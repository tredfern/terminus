-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local LabelPair = require "game.ui.widgets.label_pair"
local Stats = require "game.rules.stats"

local turn_counter = components("turn_counter", function(props)
  return {
    turnCounter = props.turnCounter,
    render = function(self)
      return LabelPair {
        id = "turnCounter",
        label = "Turn Counter",
        value = self.turnCounter
      }
    end
  }
end)


return connect(turn_counter, function(state)
  return {
    turnCounter = Stats.selectors.getValue(state, "turnCounter")
  }
end)