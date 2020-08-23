-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.story", function()
  local story = require "game.entities.story"

  it("has a title for the story", function()
    local s = story:new { title = "Adventure to the Deep" }
    assert.equals("Adventure to the Deep", s.title)
  end)

  it("has a description", function()
    local s = story:new { description = "Some long text thing" }
    assert.equals("Some long text thing", s.description)
  end)

  it("has a set of choices available", function()
    local c1, c2, c3 = {}, {}, {}
    local s = story:new { choices = {
      c1, c2, c3
    }}

    assert.array_includes(c1, s.choices)
    assert.array_includes(c2, s.choices)
    assert.array_includes(c3, s.choices)
  end)
end)