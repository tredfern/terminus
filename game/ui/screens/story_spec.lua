-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.story", function()
  local story_screen = require "game.ui.screens.story"
  local story = require "game.entities.story"
  local sample = story:new {
    title = "Adventure",
    description = "Blah blah",
    choices = {
      { title = "Done", event = spy.new(function() end) },
      { title = "Run away", event = spy.new(function() end) },
    }
  }

  it("instantiates a component", function()
    assert.not_nil(story_screen { story = sample })
  end)

  it("displays the title for the story", function()
    local s = story_screen{ story = sample }
    assert.equals("Adventure", s:find_by_id("panel_title").text)
  end)

  it("displays the story", function()
    local s = story_screen{ story = sample }
    assert.equals("Blah blah", s:find_by_id("story_content").text)
  end)

  it("has buttons for each choice", function()
    local s = story_screen{ story = sample }
    local c1 = s:find_by_id("choice_1")
    c1:click()
    assert.spy(sample.choices[1].event).was.called_with(sample.choices[1], sample)

    local c2 = s:find_by_id("choice_2")
    c2:click()
    assert.spy(sample.choices[2].event).was.called_with(sample.choices[2], sample)

  end)
end)