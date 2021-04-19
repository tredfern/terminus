-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.move", function()
  local move = require "game.rules.player.actions.move"
  local directions = require "game.rules.movement_directions"
  local mockStore = require "test_helpers.mock_store"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local characters = require "game.rules.character"

  local playerCharacter
  before_each(function()
    playerCharacter = { position = { x = 10, y = 10 }, isPlayerControlled = true }
    mockStore({
      characters = {
        playerCharacter
      }
    })
    mockDispatch.processComplex = true
    spy.on(characters.actions, "move")
  end)

  after_each(function()
    mockDispatch:reset()
  end)

  it("can move the character north", function()
    mockDispatch(move(directions.north))
    assert.spy(characters.actions.move).was.called_with(playerCharacter, 10, 9)
  end)

  it("can move the character east", function()
    mockDispatch(move(directions.east))
    assert.spy(characters.actions.move).was.called_with(playerCharacter, 11, 10)
  end)

  it("can move the character south", function()
    mockDispatch(move(directions.south))
    assert.spy(characters.actions.move).was.called_with(playerCharacter, 10, 11)
  end)

  it("can move the character west", function()
    mockDispatch(move(directions.west))
    assert.spy(characters.actions.move).was.called_with(playerCharacter, 9, 10)
  end)
end)