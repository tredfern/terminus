-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local npcs = require "game.rules.npcs"
local Aliens = require "game.rules.aliens"

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
    local enemies = npcs.selectors.getEnemies(state)
    local spawners = Aliens.selectors.getSpawners(state)
    return {
      enemyCount = #enemies,
      spawnerCount = #spawners
    }
  end
)