-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.scoreboard", function()
  local scoreboard = require "game.ui.widgets.scoreboard"
  local mockStore = require "mock_store"

  it("displays the total number of enemies", function()
    local state = {
      characters = {
        {}, {}, {}, {}
      },
      map = { enemySpawners = { } }
    }
    mockStore(state)

    local rendered = moonpie.test_render(scoreboard())

    assert.equals("4", rendered:findByID("labelEnemyCount").text)
  end)

  it("displays the total number of spawners", function()
    local state = {
      characters = { },
      map = {
        enemySpawners = {
          {}, {}, {}
        }
      }
    }
    mockStore(state)

    local rendered = moonpie.test_render(scoreboard())

    assert.equals("3", rendered:findByID("labelSpawnerCount").text)
  end)
end)