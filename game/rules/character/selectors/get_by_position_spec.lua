-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.selectors.get_by_position", function()
  local Position = require "game.rules.world.position"
  local get_by_position = require "game.rules.character.selectors.get_by_position"

  it("returns any characters from the state that match the coordinates", function()
    local find1 = { position = Position.new(38, 20) }
    local find2 = { position = Position.new(38, 20) }
    local skip1 = { position = Position.new(12, 22) }
    local skip2 = { position = Position.new(48, 11) }

    local state = {
      characters = {
        find1, skip2, skip1, find2
      }
    }
    local results = get_by_position(state, Position(38, 20))

    assert.array_includes(find1, results)
    assert.array_includes(find2, results)
    assert.not_array_includes(skip1, results)
    assert.not_array_includes(skip2, results)
  end)
end)