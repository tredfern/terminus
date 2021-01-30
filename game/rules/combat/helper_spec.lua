-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.helper", function()
  local helper = require "game.rules.combat.helper"
  local mock_random = require "moonpie.test_helpers.mock_random"

  describe("attack rolls", function()
    it("if attack succeeds and defense fails, return true", function()
      mock_random.setreturnvalues { 25, 58 }
      assert.is_true(helper.resolve_attack(50, 50))
    end)

    it("returns false if attack misses", function()
      mock_random.setreturnvalues { 58, 58 }
      assert.is_false(helper.resolve_attack(50, 50))
    end)

    it("returns false if defend succeeds", function()
      mock_random.setreturnvalues { 58, 48 }
      assert.is_false(helper.resolve_attack(50, 50))
    end)

    it("returns the die roles", function()
      mock_random.setreturnvalues { 20, 30 }
      local success, atk, def = helper.resolve_attack(50, 50)
      assert.is_false(success)
      assert.equals(20, atk)
      assert.equals(30, def)
    end)
  end)
end)