-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.app", function()
  -- App is the central glue module that loads up the modules and links things together
  local app = require "game.app"

  it("can render scenes", function()
    app.render({ id = "foo" })
    assert.not_nil(moonpie.ui.current.find_by_id("foo"))
  end)

end)