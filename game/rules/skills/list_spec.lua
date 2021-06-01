-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.list", function()
  local list = require "game.rules.skills.list"
  local attributes = require "game.rules.character.attributes"

  describe("combat skills", function()
    it("has a dodge skill", function()
      assert.equals(attributes.agility, list.dodge.attribute)
    end)

    it("has a sword skill", function()
      assert.equals(attributes.agility, list.sword.attribute)
    end)

    it("has an unarmed skill", function()
      assert.equals(attributes.strength, list.unarmed.attribute)
    end)
  end)
end)