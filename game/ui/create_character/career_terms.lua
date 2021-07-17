-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Row = require "game.ui.widgets.row"
local StatSummary = require "game.ui.create_character.stat_summary"

local CareerTerms = Components("createCharacterCareerTerms", function(props)
  return {
    id = "careerTerms",
    StatSummary { character = props.character },
    Row({
      columns = 4, {
        columnWidth = 1,
        Components.h2 { text = "Term 1" },
      }, {
        columnWidth = 3, {
          Components.button { caption = "Career 1" },
          Components.button { caption = "Career 2" },
          Components.button { caption = "Career 3" },
          Components.button { caption = "Career 4" },
        }
      }
    })

  }
end)

return CareerTerms