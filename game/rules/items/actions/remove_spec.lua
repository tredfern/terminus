-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.actions.remove", function()
  local remove = require "game.rules.items.actions.remove"

  it("describes an item to remove from the state", function()
    local item = {}
    local action = remove(item)

    assert.equals(item, action.payload.entity)
    assert.equals("ENTITY_REMOVE", action.type)
  end)

end)