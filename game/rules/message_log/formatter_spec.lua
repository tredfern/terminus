-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.message_log.formatter", function()
  local Colors = require "game.rules.graphics.colors"
  local Formatter = require "game.rules.message_log.formatter"

  it("sets the default color to text color if nothing specific", function()
    local formatted = Formatter("Random String")
    assert.same(Colors(Colors.text), formatted[1])
    assert.equals("Random String", formatted[2])
  end)

  it("takes a message and can format the message for love2D text", function()
    local formatString = "{color:red}Oh!{color:white}some more text!"
    local formatted = Formatter(formatString)

    assert.same(Colors(Colors.red), formatted[1])
    assert.equals("Oh!", formatted[2])
    assert.same(Colors(Colors.white), formatted[3])
    assert.equals("some more text!", formatted[4])
  end)

  it("can also replace strings using a templated format", function()
    local formatString = "You take {color:blue}{{damage}}{color:text} points of ice damage!"
    local formatted = Formatter(formatString, { damage = 38 })
    assert.same(Colors(Colors.text), formatted[1])
    assert.equals("You take ", formatted[2])
    assert.same(Colors(Colors.blue), formatted[3])
    assert.equals("38", formatted[4])
    assert.same(Colors(Colors.text), formatted[5])
    assert.equals(" points of ice damage!", formatted[6])
  end)
end)