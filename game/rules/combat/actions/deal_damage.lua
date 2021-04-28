-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Character = require "game.rules.character"
local Dice = require "moonpie.math.dice"
local MessageLog = require "game.rules.message_log"
local Messages = require "assets.messages"

return function(character, damageDice)
  return function(dispatch)
    local cup = Dice.parse(damageDice)
    local damage = cup()
    dispatch(Character.actions.setHealth(character, character.health - damage))
    dispatch(MessageLog.actions.add(
      Messages.combat.damage[1], {
        character = character.name,
        damage = damage
      })
    )
  end
end