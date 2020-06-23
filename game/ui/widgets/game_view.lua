-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"

local empty_view = { id = "empty_view" }

local game_view = components("game_view", function(props)
  return {
    view = props.view or empty_view,
    render = function(self)
      return self.view
    end
  }

end)

return connect(game_view, function(state)
  if not state.game_view then return end
  return { view = state.game_view.current }
end)