-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.selectors.get_animated_entities", function()
  local getAnimatedEntities = require "game.rules.graphics.selectors.get_animated_entities"

  it("returns all entities that have the animator component defined", function()
    local state = {
      world = {
        { animator = {} },
        { animator = {} },
        { noAnimator = {} }
      }
    }

    local out = getAnimatedEntities(state)
    assert.equals(2, #out)
  end)
end)