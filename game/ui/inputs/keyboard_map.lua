-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local keyboard = require "moonpie.keyboard"
local store = require "moonpie.redux.store"
local player = require "game.rules.player"
local turn = require "game.rules.turn"
local moveDirections = require "game.rules.movement_directions"

local keySettings = {}

local function process_turn(player_action)
  store.dispatch(turn.actions.process(player_action))
end

keySettings.combatMap = {
  ["down"] = function()
    process_turn(player.actions.move(moveDirections.south))
  end,
  ["left"] = function()
    process_turn(player.actions.move(moveDirections.west))
  end,
  ["right"]= function()
    process_turn(player.actions.move(moveDirections.east))
  end,
  ["up"] = function()
    process_turn(player.actions.move(moveDirections.north))
  end,
  ["g"] = function()
    process_turn(player.actions.pickupItems())
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