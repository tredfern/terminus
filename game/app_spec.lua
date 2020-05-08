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

  it("has a player spaceship", function()
    assert.not_nil(app.player)
  end)

  it("has an array of spaceports", function()
    assert.not_nil(app.spaceports)
    assert.not_empty_array(app.spaceports)
  end)
end)