-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local connect = require "moonpie.redux.connect"
local components = moonpie.ui.components
components("cargo_hold_item", function(props)
  return {
    id = "player_cargo_hold",
    components.text {
      id = "{{name}}_name",
      text = "{{name}}",
      name = props.cargo_type.name
    },
    components.text {
      id = "{{name}}_quantity",
      text = "{{quantity}}",
      name = props.cargo_type.name,
      quantity = props.quantity
    }
  }
end)

local cargo_hold = components("cargo_hold", function(props)
  return {
    id = "cargo_hold",
    cargo_hold = props.cargo_hold,
    render = function(self)
      return moonpie.utility.tables.map(self.cargo_hold.cargo, function(v, k)
        return components.cargo_hold_item{ cargo_type = k, quantity = v }
      end)
    end
  }
end)

return connect(cargo_hold)