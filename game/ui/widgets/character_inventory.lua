-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local tables = require "moonpie.tables"


return Components("character_inventory", function(props)
  return {
    tables.map(props.inventory, function(item, index)
      return {
        Components.text { text = item.name, id = "inventoryItem" .. tostring(index) }
      }
    end)
  }
end)