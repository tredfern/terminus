-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.selectors.get_attribute", function()
  local attributes = require "game.rules.character.attributes"
  local getAttribute = require "game.rules.character.selectors.get_attribute"

  it("returns the specific attribute", function()
    local c = { attributes = { STRENGTH = 32 } }
    assert.equals(32, getAttribute({}, c, attributes.strength))
  end)
end)