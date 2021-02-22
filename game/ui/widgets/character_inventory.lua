-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = require "game.rules.items"
local Components = require "moonpie.ui.components"
local tables = require "moonpie.tables"
local store = require "moonpie.redux.store"


return Components("character_inventory", function(props)
  return {
    inventory = props.inventory,
    character = props.character,
    width = "15%",

    tables.map(props.inventory, function(item, index)
      local id = "inventoryItem" .. tostring(index)
      local useButton
      if Items.isUsable(item) then
        useButton = Components.button {
          caption = "Use",
          id = id .. "UseButton",
          style = "button-small align-right",
          click = function()
            store.dispatch(Items.actions.use(item, props.character))
          end
        }
      end

      return {
        Components.text { text = item.name, id = id },
        useButton
      }
    end)
  }
end)