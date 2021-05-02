-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.fog_of_war.selectors.get", function()
  local get = require "game.rules.fog_of_war.selectors.get"
  local Position = require "game.rules.world.position"

  it("retrieves the perspectives fog of war for a position", function()
    local perspective, pos = {}, Position(1, 3, 2)
    local state = {
      fogOfWar = {
        [perspective] = {
          [pos.hashKey] = {
            a = 1, b = 2, c = 3
          }
        }
      }
    }

    local fow = get(state, perspective, pos)
    assert.equals(1, fow.a)
    assert.equals(2, fow.b)
    assert.equals(3, fow.c)
  end)

  it("return nil if position does not exist", function()
    local perspective = {}
    local state = {
      fogOfWar = {
        [perspective] = {}
      }
    }

    assert.is_nil(get(state, perspective, Position(1,1,1)))
  end)

  it("returns nil if perspective does not exist", function()
    local state = {
      fogOfWar = {}
    }

    assert.is_nil(get(state, {}, Position(1,2,1)))
  end)
end)