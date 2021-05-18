-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.gear", function()
  local Gear = require "game.rules.items.gear"

  it("Health Pack", function()
    local hp = Gear.healthPack()
    assert.equals("Health Pack", hp.name)
    assert.equals("healthPack", hp.key)
    assert.not_nil(hp.sprite)
    assert.is_true(hp.item)
  end)

  it("Anti-Spawner Spray Bottle", function()
    local sb = Gear.sprayBottle()
    assert.equals("Anti-Spawner Spray", sb.name)
    assert.equals("sprayBottle", sb.key)
    assert.not_nil(sb.sprite)
    assert.is_true(sb.item)
  end)

  it("Keycard", function()
    local keycard = Gear.keycard()
    assert.equals("Keycard", keycard.name)
    assert.equals("keycard", keycard.key)
    assert.not_nil(keycard.sprite)
    assert.is_true(keycard.item)
  end)
end)