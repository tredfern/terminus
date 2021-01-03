-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local keyboard = require "moonpie.keyboard"
local store = require "moonpie.redux.store"
local filters = require "game.rules.filters"
local actions = {
  character_move = require "game.rules.actions.character_move"
}

local keysettings = {}

keysettings.combat_map = {
  ["up"] = function()
    local player_character = filters.find_player_character(store.get_state())
    store.dispatch(actions.character_move(
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