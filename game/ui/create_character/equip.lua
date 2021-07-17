-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

local Equip = Components("createCharacterEquip", function()
  return {
    id = "equipCharacter",
    Components.text { text = "Equip Character" },
  }
end)

return Equip