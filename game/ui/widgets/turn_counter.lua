-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local LabelPair = require "game.ui.widgets.label_pair"

local turn_counter = components("turn_counter", function(props)
  return {
    turn_counter = props.turn_counter,
    render = function(self)
      return LabelPair {
        id = "turnCounter",
        label = "Turn Counter",
        value = self.turn_counter
      }
    end
  }
end)


return connect(turn_counter, function(state)
  return {
    turn_counter = state.turn.counter
  }
end)