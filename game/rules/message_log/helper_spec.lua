-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.message_log.helper", function()
  local Helper = require "game.rules.message_log.helper"

  it("can create an alert", function()
    local alert = Helper.alert("I have text")
    assert.equals("{color:msgAlert}I have text{color:msgText}", alert)
  end)

  it("can create a highlight", function()
    local highlight = Helper.highlight("Highlight")
    assert.equals("{color:msgHighlight}Highlight{color:msgText}", highlight)
  end)

  it("can wrap any color", function()
    local wrapped = Helper.colorText("some text", "blue")
    assert.equals("{color:blue}some text{color:msgText}", wrapped)
  end)
end)