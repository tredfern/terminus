-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items", function()
  local Items = require "game.rules.items"

  it("can describe a new item", function()
    Items.describe {
      name = "Short sword",
      key = "shortsword"
    }

    assert.equals("Short sword", Items.list.shortsword.name)
  end)

  it("can specify what skill is necessary to use item", function()
    Items.describe {
      name = "Medkit",
      key = "medkit",
      skill = "firstaid"
    }

    assert.equals("firstaid", Items.list.medkit.skill)
  end)

  it("describes the slot an item can be equipped", function()
    Items.describe {
      name = "Crossbow",
      key = "crossbow",
      equipSlot = "ranged"
    }

    assert.equals("ranged", Items.list.crossbow.equipSlot)
  end)

  describe("checking character proficiency", function()
    before_each(function()
      Items.describe {
        name = "Easy to Use",
        key = "easy_to_use"
      }
      Items.describe {
        name = "Bandage",
        key = "bandage",
        skill = "firstaid"
      }
    end)

    it("allows anyone to use item if no skill specified", function()
      local c = { skills = {} }
      assert.is_true(Items.canUseItem(Items.list.easy_to_use, c))
    end)

    it("allows character to use item if has skill specified", function()
      local c = { skills = { firstaid = 0 } }
      assert.is_true(Items.canUseItem(Items.list.bandage, c))
    end)

    it("returns false if character does not have skill", function()
      local c = { skills = { } }
      assert.is_false(Items.canUseItem(Items.list.bandage, c))
    end)
  end)
end)