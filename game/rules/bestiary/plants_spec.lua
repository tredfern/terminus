-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.bestiary.plants", function()
  local Plants = require "game.rules.bestiary.plants"

  describe("Prickle Bushes", function()
    local pb = Plants.prickleBush()
    it("is immobile", function()
      assert.is_true(pb.immobile)
    end)

    it("blocks movement and sight", function()
      assert.is_true(pb.blocksMovement)
      assert.is_true(pb.blocksSight)
    end)

    it("attacks things that are next to it", function()
      pending()
    end)
  end)
end)