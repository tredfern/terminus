-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local keyboard = require "moonpie.keyboard"
local store = require "moonpie.redux.store"
local character = require "game.rules.character"
local turn = require "game.rules.turn"

local keysettings = {}

local function process_turn(player_action)
  store.dispatch(turn.actions.process(player_action))
end

keysettings.combat_map = {
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
  end

}

local function set_mapping(mapping)
  for k, v in pairs(mapping) do
    keyboard:hotkey(k, v)
  end
end

local function remove_mapping(mapping)
  for k in pairs(mapping) do
    keyboard:hotkey(k, nil)
  end
end

function keysettings.enable_combat_map()
  set_mapping(keysettings.combat_map)
end

function keysettings.disable_combat_map()
  remove_mapping(keysettings.combat_map)
end

return keysettings