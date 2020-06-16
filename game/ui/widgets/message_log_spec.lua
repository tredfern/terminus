-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.message_log", function()
  local message = require "game.entities.message"
  local message_log = require "game.ui.widgets.message_log"
  local mock_store = require "mock_store"
  local rendered

  before_each(function()
    mock_store({
      message_log = {
        message:new("An entry of text to display"),
        message:new("Another entry that is later"),
        message:new("The latest entry")
      }
    })
    rendered = moonpie.test_render(message_log())
  end)

  it("displays messages from most oldest to newest", function()
    local first_entry = rendered:find_by_id("message_text_1")
    local second_entry = rendered:find_by_id("message_text_2")
    local third_entry = rendered:find_by_id("message_text_3")

    assert.equals("An entry of text to display", first_entry.text)
    assert.equals("Another entry that is later", second_entry.text)
    assert.equals("The latest entry", third_entry.text)
  end)
end)