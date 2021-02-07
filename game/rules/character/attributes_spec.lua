-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.attributes", function()
  local attributes = require "game.rules.character.attributes"

  it("has types of attributes available", function()
    assert.equals("STRENGTH", attributes.strength)
    assert.equals("AGILITY", attributes.agility)
    assert.equals("ENDURANCE", attributes.endurance)
    assert.equals("WIT", attributes.wit)
    assert.equals("EDUCATION", attributes.education)
    assert.equals("SOCIAL", attributes.social)
  end)
end)