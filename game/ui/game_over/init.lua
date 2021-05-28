-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local fullScreenPanel = require "game.ui.widgets.full_screen_panel"
local connect = require "moonpie.redux.connect"
local app = require "game.app"
local Aliens = require "game.rules.aliens"
local Statistics = require "game.ui.game_over.statistics"

local function result(isVictory)
  if isVictory then
    return { Components.h2 { text = "Victory!!", id = "lblVictoryMessage" } }
  else
    return { Components.h2 { text = "Defeat!", id = "lblDefeatMessage" } }
  end
end

local gameOver = Components("gameOverScreen", function(props)
  return {
      id = "gameOverScreen",
      fullScreenPanel {
      style = "align-center align-middle",
      title = "Game Over",
      contents = {
        result(props.victory),
        Statistics(),
      },
      actions = {
        Components.button { id = "btnTitleScreen", caption = "Back to Title", click = app.title },
      }
    }
  }
end)


return connect(gameOver, function(state)
  local enemySpawners = Aliens.selectors.getSpawners(state)
  return {
    victory = #enemySpawners == 0
  }
end)