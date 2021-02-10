-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local get_by_position = require "game.rules.character.selectors.get_by_position"
local set_position = require "game.rules.character.actions.set_position"
local skills = require "game.rules.skills"

return function(character, x, y)
  local combat = require "game.rules.combat"

  return setmetatable({
    type = types.character_move,
    character = character,
    x = x,
    y = y
  },
  {
    __call = function(self, dispatch, getState)
      local targets = get_by_position(getState(), self.x, self.y)
      if #targets > 0 then
        dispatch(combat.actions.attack(self.character, targets[1], skills.list.unarmed(self.character)))
      else
        dispatch(set_position(self.character, self.x, self.y))
      end
    end
  })
end