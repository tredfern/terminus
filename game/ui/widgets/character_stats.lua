-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local character = require "game.rules.character"

local character_stats = components("character_stats", function(props)
  return {
    character = props.character,
    render = function(self)
      local character_name, character_health
      if self.character then
        character_name = self.character.name
        character_health = self.character.health
      end

      return {
        {
          components.text { text = "Name: " },
          components.text { id = "character_name", text = character_name }
        },
        {
          components.text { text = "Health:    " },
          components.text { text = character_health }
        }
      }
    end
  }
end)

return connect(character_stats, function(state)
  local player = character.selectors.get_player(state)
  return {
    character = player
  }
end)