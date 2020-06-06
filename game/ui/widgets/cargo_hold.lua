-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local connect = require "moonpie.redux.connect"
local components = moonpie.ui.components
local tables = require "moonpie.tables"

local cargo_hold_item = components("cargo_hold_item", function(props)
  return {
    id = "player_cargo_hold",
    components.text {
      id = "{{name}}_name",
      text = "{{name}}",
      name = props.cargo_name,
      style = "label"
    },
    components.text {
      id = "{{name}}_quantity",
      text = "{{quantity}}",
      name = props.cargo_name,
      quantity = props.quantity,
      style = "value"
    }
  }
end)

local cargo_hold = components("cargo_hold", function(props)
  return {
    id = "cargo_hold",
    cargo = props.cargo,
    render = function(self)
      local sorted_list = tables.sort_by(self.cargo, function(k) return k end)
      return {
        style = "label-value-group",
        tables.map(sorted_list, function(v)
          return cargo_hold_item{ cargo_name = v.value.name, quantity = v.value.quantity }
        end)
      }
    end
  }
end)

return connect(cargo_hold, function(state) return { cargo = state.player_cargo } end)