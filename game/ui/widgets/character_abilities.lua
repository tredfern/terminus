-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"


return Components("character_abilities", function(props)
  local abilities = props.character.abilities or {}
  return {
    width = "15%",
    {
      Components.text { text = "Strength:" },
      Components.text { id = "strengthStat", text = abilities.strength, style ="align-right" }
    },
    {
      Components.text { text = "Agility:" },
      Components.text { id = "agilityStat", text = abilities.agility, style = "align-right" }
    },
    {
      Components.text { text = "Endurance:" },
      Components.text { id = "enduranceStat", text = abilities.endurance, style = "align-right" }
    },
    {
      Components.text { text = "Wit:" },
      Components.text { id = "witStat", text = abilities.wit, style = "align-right" }
    },
    {
      Components.text { text = "Education:" },
      Components.text { id = "educationStat", text = abilities.education, style = "align-right" }
    },
    {
      Components.text { text = "Social:" },
      Components.text { id = "socialStat", text = abilities.social, style = "align-right" }
    },

  }
end)