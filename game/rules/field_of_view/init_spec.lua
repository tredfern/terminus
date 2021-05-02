-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view", function()
  local fieldOfView = require "game.rules.field_of_view"

  it("has actions to dispatch", function()
    assert.not_nil(fieldOfView.actions.calculateAll)
    assert.not_nil(fieldOfView.actions.calculate)
    assert.not_nil(fieldOfView.actions.update)
  end)

  it("has selectors", function()
    assert.not_nil(fieldOfView.selectors.get)
    assert.not_nil(fieldOfView.selectors.getVisiblePositions)
  end)
end)