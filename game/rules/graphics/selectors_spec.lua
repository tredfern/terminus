-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.selectors", function()
  local Selectors = require "game.rules.graphics.selectors"

  describe("SELECTOR: getAnimated", function()
    it("returns all entities that have the animator component defined", function()
      local state = {
        world = {
          { animator = {} },
          { animator = {} },
          { noAnimator = {} }
        }
      }

      local out = Selectors.getAnimated(state)
      assert.equals(2, #out)
    end)
  end)

  describe("SELECTOR: getDrawable", function()
    it("returns components with a sprite and position", function()
      local state = {
        world = {
          { sprite = {}, position = {} },
          { sprite = {}, position = {} },
          { sprite = {}, position = {} },
          { sprite = {} },
          { position = {} }
        }
      }

      local result = Selectors.getDrawable(state)
      assert.equals(3, #result)
    end)
  end)
end)