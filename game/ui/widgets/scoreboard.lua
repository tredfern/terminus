-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local npcs = require "game.rules.npcs"
local Aliens = require "game.rules.aliens"
local LabelPair = require "game.ui.widgets.label_pair"

local scoreboard = Components("scoreboard", function(props)
  return {
    enemyCount = props.enemyCount,
    spawnerCount = props.spawnerCount,
    render = function(self)
      return {
        LabelPair { id = "enemyCount", label = "Enemies", value = self.enemyCount },
        LabelPair { id = "spawnerCount", label = "Spawners", value = self.spawnerCount }
      }
    end
  }
end)


return connect(
  scoreboard,
  function(state)
    local enemies = npcs.selectors.getEnemies(state)
    local spawners = Aliens.selectors.getSpawners(state)
    return {
      enemyCount = #enemies,
      spawnerCount = #spawners
    }
  end
)