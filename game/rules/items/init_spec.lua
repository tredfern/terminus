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
        key = "easy_to_use",
        usable = true
      }
      Items.describe {
        name = "Bandage",
        key = "bandage",
        skill = "firstaid",
        usable = true
      }
      Items.describe {
        name = "Unusable",
        key = "unusable"
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

    it("is not allowed to use unusable items", function()
      local c = { skills = { } }
      assert.is_false(Items.canUseItem(Items.list.unusable, c))
    end)
  end)

  describe("using items", function()
    it("calls the item useHandler", function()
      Items.describe { name = "UseFunction", key = "useFunction", usable = true,
        useHandler = spy.new(function() end)
      }
      local character = {}
      local store = require "game.store"

      Items.use(Items.list.useFunction, character)
      assert.spy(Items.list.useFunction.useHandler).was.called_with(
        Items.list.useFunction,
        character,
        store.dispatch
      )
    end)
  end)

  describe("cloning items", function()
    Items.describe { key = "cloneMe", name = "Clone me", propA = true, propB = false }
    it("can clone an item", function()
      local c = Items.list.cloneMe:clone()
      assert.equals("cloneMe", c.key)
      assert.equals("Clone me", c.name)
      assert.equals(true, c.propA)
      assert.equals(false, c.propB)
    end)

    it("can take additional values to cloning to overwrite values of the item", function()
      local c = Items.list.cloneMe:clone { x = 19, y = 18 }
      assert.equals(19, c.x)
      assert.equals(18, c.y)
    end)
  end)
end)