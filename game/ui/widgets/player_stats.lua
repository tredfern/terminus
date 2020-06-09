-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"

local player_stats = components("player_stats", function(props)
  return {
    player = props.player,
    style = "player-panel-box",
    render = function(self)
      return {
        components.text{ text = "$$$", style = "label" },
        components.text{ id = "player_money", style = "value", text = self.player.money }
      }
    end
  }
end)


return connect(player_stats, function(state) return { player = state.player } end)