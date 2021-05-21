-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Thunk = require "moonpie.redux.thunk"
local Aliens = require "game.rules.aliens"
local FieldOfView = require "game.rules.field_of_view"
local Items = require "game.rules.items"
local Map = require "game.rules.map"
local MessageLog = require "game.rules.message_log"
local Player = require "game.rules.player"
local Position = require "game.rules.world.position"
local Selectors = require "game.rules.game_state.selectors"

local Actions = {}
Actions.types = {
  CHECK_GAME_OVER = "GAME_STATE_CHECK_GAME_OVER",
  GAME_OVER = "GAME_STATE_GAME_OVER",
  LOAD_CORE_DATA = "GAME_STATE_LOAD_CORE_DATA",
  SETUP = "GAME_STATE_SETUP",
  UPDATE_FRAME = "GAME_STATE_UPDATE_FRAME"
}

function Actions.checkGameOver()
  return Thunk(
    Actions.types.CHECK_GAME_OVER,
    function(dispatch, getState)
      local state = getState()

      if Selectors.isGameLost(state) then
        dispatch(Actions.gameOver())
      end

      if Selectors.isGameWon(state) then
        dispatch(Actions.gameOver())
      end
    end
  )
end

function Actions.gameOver()
  return Thunk(
    Actions.types.GAME_OVER,
    function()
      local app = require "game.app"
      app.gameOver()
    end
  )
end

function Actions.loadCoreData()
  return Thunk(
    Actions.types.LOAD_CORE_DATA,
    function()
      require "assets.characters.skills"
      require "assets.characters.names"
      require "assets.maps.terrains"
    end
  )
end

function Actions.setup()
  return Thunk(
    Actions.types.SETUP,
    function(dispatch, getState)
      dispatch(Map.actions.create(100, 100, Map.generators.dungeon))
      local rooms = Map.selectors.getRooms(getState())

      local playerStartRoom = tables.pickRandom(rooms)

      local x = playerStartRoom.x + math.floor(playerStartRoom.width / 2)
      local y = playerStartRoom.y + math.floor(playerStartRoom.height / 2)
      dispatch(Player.actions.add(Position(x, y, playerStartRoom.level)))
      dispatch(Player.actions.equipItem(Items.Weapons.sword()))

      for _ = 1,20 do
        local r = tables.pickRandom(rooms)
        dispatch(Aliens.actions.addSpawner(
          Position(
            r.x + love.math.random(r.width) - 1,
            r.y + love.math.random(r.height) - 1,
            r.level
      )))
      end

      dispatch(FieldOfView.actions.calculateAll())

      dispatch(MessageLog.actions.add(
        MessageLog.messages.tutorial.welcome
      ))
    end
  )
end

function Actions.updateFrame(deltaTime)
  local Graphics = require "game.rules.graphics"

  return Thunk(Actions.types.UPDATE_FRAME, function(dispatch)
    dispatch(Graphics.actions.updateFrame(deltaTime))
  end)
end

return Actions