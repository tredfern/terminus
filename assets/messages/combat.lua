-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local Helper = require "game.rules.message_log.helper"
local highlight = Helper.highlight
local alert = Helper.alert

return {
  attacks = {
    melee = {
      hit = {
        string.format("%s swings the %s. It crunches into %s",
          highlight("{{attacker}}"),
          alert("{{weapon}}"),
          highlight("{{defender}}")
        )
      },
      miss = {
        string.format("%s swings the %s. It misses %s",
          highlight("{{attacker}}"),
          alert("{{weapon}}"),
          highlight("{{defender}}")
        )
      }
    },
  },
  damage = {
    string.format("%s took %s of damage!",
      highlight("{{character}}"),
      alert("{{damage}} points"))
  }
}