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
      local character_name
      if self.character then
        character_name = self.character.name
      end

      return {
        components.text { text = "Name: " },
        components.text { id = "character_name", text = character_name }
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