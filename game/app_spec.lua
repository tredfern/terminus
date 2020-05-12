-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.app", function()
  local app = require "game.app"

  it("can render scenes", function()
    app.render({ id = "foo" })
    assert.not_nil(moonpie.ui.current.find_by_id("foo"))
  end)

  it("loads some global assets", function()
    assert.not_nil(app.assets)
  end)

  it("has a reference to the current state that tracks all the important entities", function()
    assert.not_nil(app.state)
  end)
end)