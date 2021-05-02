-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.fog_of_war.reducer", function()
  local reducer = require "game.rules.fog_of_war.reducer"
  local actionTypes = require "game.rules.fog_of_war.actions.types"
  local Position = require "game.rules.world.position"

  it("can store updated information on a perspective", function()
    local state = {}
    local perspective = {}
    local position = Position(3, 4, 2)
    local tile = {}

    local action = {
      type = actionTypes.UPDATE_POSITION,
      payload = {
        perspective = perspective,
        position = position,
        tile = tile
      }
    }

    state = reducer(state, action)
    assert.not_nil(state[perspective])
    assert.not_nil(state[perspective][position.hashKey])
    assert.equals(tile, state[perspective][position.hashKey].tile)
  end)

  it("stores the information if a hashKey is provided to the update action", function()
    local state = {}
    local perspective, key, tile = {}, 1234, {}
    local action = {
      type = actionTypes.UPDATE_POSITION,
      payload = {
        perspective = perspective,
        positionHashKey = key,
        tile = tile
      }
    }

    state = reducer(state, action)
    assert.not_nil(state[perspective][key])
    assert.equals(tile, state[perspective][key].tile)
  end)
end)