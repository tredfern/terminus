-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local keyboard = require "moonpie.keyboard"
local store = require "moonpie.redux.store"
local character = require "game.rules.character"
local turn = require "game.rules.turn"

local keySettings = {}

local function process_turn(player_action)
  store.dispatch(turn.actions.process(player_action))
end

keySettings.combatMap = {
  ["down"] = function()
    local player_character = character.selectors.getPlayer(store.getState())
    process_turn(character.actions.move(
      player_character,
      player_character.x,
      player_character.y + 1
    ))
  end,
  ["left"] = function()
    local player_character = character.selectors.getPlayer(store.getState())
    process_turn(character.actions.move(
      player_character,
      player_character.x - 1,
      player_character.y
    ))
  end,
  ["right"]= function()
    local player_character = character.selectors.getPlayer(store.getState())
    process_turn(character.actions.move(
      player_character,
      player_character.x + 1,
      player_character.y
    ))
  end,
  ["up"] = function()
    local player_character = character.selectors.getPlayer(store.getState())
    process_turn(character.actions.move(
      player_character,
      player_character.x,
      player_character.y - 1
    ))
  end,
  ["g"] = function()
    local player_character = character.selectors.getPlayer(store.getState())
    process_turn(character.actions.pickupItems(player_character))
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