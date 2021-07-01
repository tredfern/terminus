-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

local BasicInformation = Components("createCharacterBasicInformation", function()
  return {
    id = "basicInformation",
    Components.text { text = "Basic Information" }
  }
end)

return BasicInformation