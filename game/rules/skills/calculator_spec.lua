-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.calculator", function()
  local calculator = require "game.rules.skills.calculator"
  local attributes = require "game.rules.character.attributes"

  it("returns the attribute for the character for skill", function()
    local c = {
      attributes = {
        [attributes.strength] = 7
      }
    }

    assert.equals(7, calculator(c, { attribute = attributes.strength }))
  end)
end)