-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local keyboard = require "moonpie.keyboard"
local store = require "moonpie.redux.store"
local player = require "game.rules.player"
local turn = require "game.rules.turn"
local Orientation = require "game.rules.world.orientation"
local Position = require "game.rules.world.position"

local keySettings = {}
local directionAction

local function process_turn(player_action)
  store.dispatch(turn.actions.process(player_action))
end

local function handleDirection(orientation)
  if directionAction then
    process_turn(directionAction(orientation))
    directionAction = nil
  else
    process_turn(player.actions.move(Position[orientation]))
  end
end

local function setDirectionHandler(action)
  directionAction = action
end


keySettings.combatMap = {
  ["down"] = function()
    handleDirection(Orientation.south)
  end,
  ["left"] = function()
    handleDirection(Orientation.west)
  end,
  ["right"]= function()
    handleDirection(Orientation.east)
  end,
  ["up"] = function()
    handleDirection(Orientation.north)
  end,
  ["."] = function()
    process_turn(player.actions.ladderUp())
  end,
  [","] = function()
    process_turn(player.actions.ladderDown())
  end,
  ["g"] = function()
    process_turn(player.actions.pickupItems())
  end,
  ["m"] = function()
    local App = require "game.app"
    App.worldMap()
  end,
  ["o"] = function()
    setDirectionHandler(player.actions.openDoor)
  end,
  ["shift+g"] = function()
    local Settings = require "game.settings"
    store.dispatch(Settings.actions.toggleOption("show_grid_lines"))
  end,
  ["tab"] = function()
    local app = require "game.app"
    app.characterDetails()
  end

}

local function setMapping(mapping)
  for k, v in pairs(mapping) do
    keyboard:hotkey(k, v)
  end
end

local function removeMapping(mapping)
  for k in pairs(mapping) do
    keyboard:hotkey(k, nil)
  end
end

function keySettings.enableCombatMap()
  setMapping(keySettings.combatMap)
end

function keySettings.disableCombatMap()
  removeMapping(keySettings.combatMap)
end

return keySettings