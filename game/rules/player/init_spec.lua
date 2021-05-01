-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player", function()
  local player = require "game.rules.player"

  it("has the actions the player can perform", function()
    assert.not_nil(player.actions.add)
    assert.not_nil(player.actions.equipItem)
    assert.not_nil(player.actions.ladderDown)
    assert.not_nil(player.actions.ladderUp)
    assert.not_nil(player.actions.move)
    assert.not_nil(player.actions.openDoor)
    assert.not_nil(player.actions.pickupItems)
  end)

  it("has selectors to retrieve player values", function()
    assert.not_nil(player.selectors.getFieldOfView)
    assert.not_nil(player.selectors.getPlayer)
  end)
end)