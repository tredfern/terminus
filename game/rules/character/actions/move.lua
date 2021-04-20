-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local get_by_position = require "game.rules.character.selectors.get_by_position"
local set_position = require "game.rules.character.actions.set_position"
local sounds = require "assets.sounds"
local Thunk = require "moonpie.redux.thunk"

return function(character, position)
  local combat = require "game.rules.combat"

  return Thunk(types.MOVE, function(dispatch, getState)
    local targets = get_by_position(getState(), position)
    if #targets > 0 then
      dispatch(combat.actions.meleeAttack(character, targets[1]))
    else
      if character.isPlayerControlled then
        sounds.walk:play()
      end

      dispatch(set_position(character, position))
    end
  end)
end