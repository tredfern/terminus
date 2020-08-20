-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local label_value = require "game.ui.widgets.label_value"

local general = components("character_general", function(props)
  return {
    character_name = props.character_name,
    render = function(self)
      return {
        label_value({ id = "character_name", label = "Name", value = self.character_name })
      }
    end
  }
end)

return connect(general,
  function(state) return {
      character_name = state.player.name
    }
  end)