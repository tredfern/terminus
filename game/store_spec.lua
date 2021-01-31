-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.store", function()
  it("sets up the store with all the correct reducers", function()
    local store = require "game.store"
    assert.is_table(store)
    assert.is_function(store.dispatch)
    assert.is_table(store.getState())
  end)

  it("can reset the store to the start state", function()
    local store = require "game.store"
    store.reset()
  end)
end)