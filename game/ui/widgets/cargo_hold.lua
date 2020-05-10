-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

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

components("cargo_hold", function(props)
  return {
    id = "cargo_hold",
    player = props.player,
    render = function(self)
      self.logger.debug("rendering cargo hold")
      return moonpie.utility.tables.map(self.player.cargo_hold.cargo, function(v, k)
        return components.cargo_hold_item{ cargo_type = k, quantity = v }
      end)
    end
  }
end)