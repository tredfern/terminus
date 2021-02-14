-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = require "game.rules.items"
local Components = require "moonpie.ui.components"
local tables = require "moonpie.tables"


return Components("character_inventory", function(props)
  return {
    inventory = props.inventory,
    width = "15%",

    tables.map(props.inventory, function(item, index)
      local id = "inventoryItem" .. tostring(index)
      local useButton
      if item.usable then
        useButton = Components.button {
          caption = "Use",
          id = id .. "UseButton",
          style = "button-small align-right",
          click = function()
            Items.use(item)
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