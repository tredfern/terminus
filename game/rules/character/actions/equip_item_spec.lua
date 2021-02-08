-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.equip_item", function()
  local equipItem = require "game.rules.character.actions.equip_item"

  it("specifies the item in inventory to equip", function()
    local character = {}
    local item = {}
    local action = equipItem(character, item)

    assert.equals("CHARACTER_EQUIP_ITEM", action.type)
    assert.equals(character, action.payload.character)
    assert.equals(item, action.payload.item)
  end)

  it("is invalid if the item is nil or has no equipment slot", function()
    local character = {}
    local item = {}
    local action = equipItem(character, item)
    assert.is_false(action:validate())
    action = equipItem(character, nil)
    assert.is_false(action:validate())
  end)

  it("is valid if the item has an equip slot", function()
    local character = {}
    local item = { equipSlot = "melee" }
    local action = equipItem(character, item)

    assert.is_true(action:validate())
  end)


end)