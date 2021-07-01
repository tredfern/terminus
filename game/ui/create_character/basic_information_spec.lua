-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.create_character.basic_information", function()
  local BasicInformation = require "game.ui.create_character.basic_information"

  it("renders a table", function()
    assert.is_table(BasicInformation())
  end)
end)