-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local setHealth = require "game.rules.character.actions.set_health"

return function(character)
  return function(dispatch)
    dispatch(setHealth(character, character.health + 5))
  end
end