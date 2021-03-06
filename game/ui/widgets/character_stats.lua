-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local character = require "game.rules.character"

local character_stats = components("character_stats", function(props)
  return {
    character_name = props.character_name,
    character_health = props.character_health,
    render = function(self)
      return {
        {
          components.text { text = "Name: " },
          components.text { id = "character_name", text = self.character_name }
        },
        {
          components.text { text = "Health:    " },
          components.text { id = "character_health", text = self.character_health }
        }
      }
    end
  }
end)

return connect(character_stats, function(state)
  local player = character.selectors.getPlayer(state)
  if player then
    return {
      character_name = player.name,
      character_health = player.health
    }
  end
end)