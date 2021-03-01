-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.game_over", function()
  local gameOver = require "game.ui.screens.game_over"
  local mockStore = require "mock_store"

  it("can switch back to the title screen", function()
    local app = require "game.app"
    spy.on(app, "title")
    local screen = moonpie.test_render(gameOver())

    local btnTitleScreen = screen:findByID("btnTitleScreen")
    btnTitleScreen:click()
    assert.spy(app.title).was.called()
  end)

  it("says victory if there are no spawners or enemies left", function()
    mockStore {
      map = {
        enemySpawners = {}
      },
      characters = {}
    }
    local screen = moonpie.test_render(gameOver())
    assert.not_nil(screen:findByID("lblVictoryMessage"))

  end)
end)