-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  actions = {
    attack = require "game.rules.combat.actions.attack",
    dealDamage = require "game.rules.combat.actions.deal_damage",
    meleeAttack = require "game.rules.combat.actions.melee_attack"
  }
}