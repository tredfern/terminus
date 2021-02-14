-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local Character = require "game.rules.character"
local Map = require "game.rules.map"

local scoreboard = Components("scoreboard", function(props)
  return {
    enemyCount = props.enemyCount,
    spawnerCount = props.spawnerCount,
    render = function(self)
      return {
        {
          Components.text { text = "Enemies:"},
          Components.text { id = "labelEnemyCount", text = self.enemyCount, style = "align-right" }
        },
        {
          Components.text { text = "Spawners:"},
          Components.text { id = "labelSpawnerCount", text = self.spawnerCount, style = "align-right" }
        }
      }
    end
  }
end)


return connect(
  scoreboard,
  function(state)
    local enemies = Character.selectors.getEnemies(state)
    local spawners = Map.selectors.getEnemySpawners(state)
    return {
      enemyCount = #enemies,
      spawnerCount = #spawners
    }
  end
)