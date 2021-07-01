-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

local CareerTerms = Components("createCharacterCareerTerms", function()
  return {
    id = "careerTerms",
    Components.text { text = "Career Terms"}
  }
end)

return CareerTerms