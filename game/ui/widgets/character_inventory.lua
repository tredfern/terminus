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
    id = "characterInventory",
    inventory = props.inventory,
    character = props.character,
    width = "15%",

    render = function(self)
      return tables.map(self.inventory, function(slot, index)
        local item = slot.item
        local id = "inventoryItem" .. tostring(index)
        local useButton
        if Items.isUsable(item) then
          useButton = Components.button {
            caption = "Use",
            id = id .. "UseButton",
            style = "button-small align-right",
            click = function()
              self:forceRefresh()
              store.dispatch(Items.actions.use(item, self.character))
            end
          }
        end

        return {
          Components.text { text = slot.quantity , margin = { right = 5 }},
          Components.text { text = item.name, id = id },
          useButton
        }
      end)
    end
  }
end)