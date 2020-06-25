-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local tables = require "moonpie.tables"
local connect = require "moonpie.redux.connect"

local action_item = components("action_menu_item", function(props)
  return components.button {
    id = "action_menu_item_" .. props.index,
    caption = props.text,
    click = props.action
  }
end)

local action_menu = components("action_menu", function(props)
  return {
    actions = props.actions or {},
    render = function(self)
      return tables.map(self.actions, function(v, i)
        return action_item { index = i, text = v.text, action = v.action }
      end)
    end
  }
end)

return connect(action_menu, function(state)
  if not state.game_view then return end
  return { actions = state.game_view.actions }
end)