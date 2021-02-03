-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local Character = require "game.rules.character"
local connect = require "moonpie.redux.connect"


local CharacterDetails = Components("character_details", function(props)
  local app = require "game.app"

  return {
    id = "character_details_screen",

    FullScreenPanel {
      id = "screenPanel",
      title = props.characterName,
      contents = {
        Components.button { id = "btnClose", caption = "Close", click = app.combat }
      }
    }

  }
end)

return connect(
  CharacterDetails,
  function(state)
    local player = Character.selectors.getPlayer(state)
    return {
      characterName = player.name
    }
  end
)