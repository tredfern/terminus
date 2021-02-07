-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = {}
Items.list = {}

function Items.describe(props)
  Items.list[props.key] = {
    name = props.name
  }
end

Items.describe { key = "sword", name = "Sword" }
Items.describe { key = "healthPack", name = "Health Pack" }
Items.describe { key = "keycard", name = "Keycard" }


return Items