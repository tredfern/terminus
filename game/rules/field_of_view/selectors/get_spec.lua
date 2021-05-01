-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.selectors.get", function()
  local get = require "game.rules.field_of_view.selectors.get"

  it("retrieves a specific field of view from state", function()
    local entity, fov = {}, {}
    local state = {
      fieldOfView = {
        [entity] = fov
      }
    }

    assert.equals(fov, get(state, entity))
  end)

  it("return nil if no field of view state is available", function()
    assert.is_nil(get({}, {}))
  end)
end)