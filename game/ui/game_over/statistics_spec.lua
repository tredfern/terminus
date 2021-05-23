-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.game_over.statistics", function()
  local Statistics = require "game.ui.game_over.statistics"
  local mockStore = require "moonpie.test_helpers.mock_store"

  it("creates a component", function()
    local c = Statistics()
    assert.is_table(c)
    assert.equals("game_over_statistics", c.id)
  end)

  it("shows the total number of turns played", function()
    mockStore {
      stats = {
        turnCounter = { value = 12 }
      }
    }

    local c = Statistics()

    local tc = c:findByID("statTurnCounterValue")

    assert.not_nil(tc)
    assert.equals("12", tc.text)
  end)
end)