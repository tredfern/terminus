-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.scoreboard", function()
  local scoreboard = require "game.ui.widgets.scoreboard"
  local mockStore = require "moonpie.test_helpers.mock_store"

  it("displays the total number of enemies", function()
    local state = {
      characters = {
        {}, {}, {}, {}
      },
      map = { enemySpawners = { } }
    }
    mockStore(state)

    local rendered = moonpie.testRender(scoreboard())

    assert.equals("4", rendered:findByID("enemyCountValue").text)
  end)

  it("displays the total number of spawners", function()
    local state = {
      characters = { },
      world = {
        { spawner = true }, { spawner = true }, { spawner = true }
      }
    }
    mockStore(state)

    local rendered = moonpie.testRender(scoreboard())

    assert.equals("3", rendered:findByID("spawnerCountValue").text)
  end)
end)