-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local player = require "game.rules.player"
local LabelPair = require "game.ui.widgets.label_pair"

local character_stats = components("character_stats", function(props)
  return {
    character_name = props.character_name,
    character_health = props.character_health,
    render = function(self)
      return {
        LabelPair { id = "characterName", label = "Name", value = self.character_name },
        LabelPair { id = "characterHealth", label = "Health", value = self.character_health }
      }
    end
  }
end)

return connect(character_stats, function(state)
  local pc = player.selectors.getPlayer(state)
  if pc then
    return {
      character_name = pc.name,
      character_health = pc.health
    }
  end
end)