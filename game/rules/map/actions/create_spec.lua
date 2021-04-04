-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.actions.create", function()
  local create = require "game.rules.map.actions.create"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local generator = spy.new(function() return {} end)

  before_each(function()
    mockDispatch:reset()
    mockDispatch.processComplex = true
  end)

  it("adds the map to the state", function()
    mockDispatch(create(100, 100, generator))
    assert.is_true(mockDispatch:received_action("MAP_SET"))
  end)

  it("uses a generator to create the map", function()
    mockDispatch(create(100, 100, generator))
    assert.spy(generator).was.called_with(100, 100)
  end)

  it("is defined as the MAP_CREATE thunk", function()
    local c = create(30, 20, function() end)
    assert.equals("MAP_CREATE", c.type)
  end)
end)