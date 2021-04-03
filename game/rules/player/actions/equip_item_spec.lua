-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.equip_item", function()
  local equipItem = require "game.rules.player.actions.equip_item"
  local mockStore = require "test_helpers.mock_store"

  it("finds the player and creates the equip item action", function()
    local player = { isPlayerControlled = true }
    mockStore({ characters = { player } })
    local item = {}
    local action = equipItem(item)
    assert.equals(item, action.payload.item)
    assert.equals(player, action.payload.character)
  end)
end)