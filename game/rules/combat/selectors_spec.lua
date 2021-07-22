-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.selectors", function()
  local Selectors = require "game.rules.combat.selectors"
  local equipSlots = require "game.rules.inventory.equip_slots"

  describe("SELECTOR: getMeleeWeapon", function()
    it("returns the melee weapon equipped for the player", function()
      local entity, weapon = {}, {}
      local state = {
        inventory = {
          [entity] = {
            equipped = {
              [equipSlots.melee] = weapon
            }
          }
        }
      }

      assert.equals(weapon, Selectors.getMeleeWeapon(state, entity))
    end)

    it("returns an unarmed strike if no weapon is equipped", function()
      local entity = {}
      local state = {
        inventory = {
          [entity] = {
            equipped = { }
          }
        }
      }

      local unarmed = Selectors.getMeleeWeapon(state, entity)
      assert.equals("Unarmed Strike", unarmed.name)
      assert.equals("unarmed", unarmed.skill)
      assert.equals("1d3", unarmed.damage)
    end)
  end)

  describe("SELECTORS: getRangedWeapon", function()


  end)
end)