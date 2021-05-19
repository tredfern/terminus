-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local Aliens = require "game.rules.aliens"
local Camera = require "game.ui.camera"
local Character = require "game.rules.character"
local FieldOfView = require "game.rules.field_of_view"
local FogOfWar = require "game.rules.fog_of_war"
local GameState = require "game.rules.game_state"
local NPCs = require "game.rules.npcs"
local Player = require "game.rules.player"

local Actions = {}
Actions.types =  require "game.rules.turn.types"

function Actions.increment()
  return {
    type = Actions.types.INCREMENT
  }
end

function Actions.process(player_action)
  return Thunk(Actions.types.PROCESS, function(dispatch, getState)
    dispatch(Actions.increment())
    dispatch(player_action)

    local enemies = NPCs.selectors.getEnemies(getState())
    if enemies then
      for _, e in ipairs(enemies) do
        dispatch(NPCs.actions.think(e))
      end
    end

    local spawners = Aliens.selectors.getSpawners(getState())
    if spawners then
      for _, spawner in ipairs(spawners) do
        dispatch(NPCs.actions.checkSpawnEnemy(spawner))
      end
    end

    -- Check for dead characters
    local dead = Character.selectors.getDead(getState())
    if dead then
      for _, e in ipairs(dead) do
        dispatch(Character.actions.remove(e))
      end
    end

    -- Update camera position to follow character
    local cam = Camera.selectors.get(getState())
    if cam then
      dispatch(Camera.actions.centerOnPlayer(cam.width, cam.height))
    end


    -- Update FoV for characters
    dispatch(FieldOfView.actions.calculateAll())

    -- Player Fog of War
    local player = Player.selectors.getPlayer(getState())
    dispatch(FogOfWar.actions.updatePerspective(player))

    dispatch(GameState.actions.checkGameOver())
  end)
end
return Actions