-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.pickup_items", function()
  local pickupItems = require "game.rules.player.actions.pickup_items"
  local characters = require "game.rules.character"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local playerCharacter = { isPlayerControlled = true, position = { x = 10, y = 10 } }

  before_each(function()
    mockDispatch.processComplex = true
    mockStore({
      characters = { playerCharacter },
      items = {}
    })
  end)

  after_each(function()
    mockDispatch:reset()
  end)

  it("dispatches the pickupItems action with the player character", function()
    spy.on(characters.actions, "pickupItems")

    mockDispatch(pickupItems())
    assert.spy(characters.actions.pickupItems).was.called_with(playerCharacter)
  end)

end)