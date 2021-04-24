-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions.setup", function()
  require "assets.items"
  local setup = require "game.rules.game_state.actions.setup"
  local tables = require "moonpie.tables"
  local character = require "game.rules.character"
  local map = require "game.rules.map"

  local captured_actions
  local dispatch_spy = spy.new(function(action)
    if type(action) == "table" then
      captured_actions[#captured_actions + 1] = action
    end
  end)

  local getState = function()
    return {
      map = {
        outline = {
          rooms = {
            { x = 1, y = 1, width = 10, height = 10 }
          }
        }
      }
    }
  end

  before_each(function()
    captured_actions = {}

    local s = setup()
    s(dispatch_spy, getState)
  end)

  it("dispatch create character action for player character", function()
    assert.is_true(tables.any(
      captured_actions,
      function(c) return
        c.type == character.actions.types.ADD and
        c.payload.character.isPlayerControlled
      end)
    )
  end)

  it("adds some random enemies spawners", function()
    assert.is_true(tables.any(
      captured_actions,
      function(c) return
        c.type == "ENTITY_ADD" and c.payload.entity.spawner
      end)
    )
  end)

  it("creates a map", function()
    assert.is_true(tables.any(
      captured_actions,
      function(c) return
        c.type == map.actions.types.CREATE
      end)
    )
  end)
end)