-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.selectors", function()
  local Selectors = require "game.rules.skills.selectors"

  describe("SELECTOR: getItemSkill", function()
    local medicine = {}
    local state = {
      skills = {
        ["medicine"] = medicine
      }
    }

    local item = {
      skill = "medicine"
    }

    assert.equals(medicine, Selectors.getItemSkill(state, item))
  end)
end)