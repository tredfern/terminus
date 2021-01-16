-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions.setup", function()
  local setup = require "game.rules.game_state.actions.setup"
  local tables = require "moonpie.tables"
  local character = require "game.rules.character"

  local captured_actions
  local dispatch_spy = spy.new(function(action)
    captured_actions[#captured_actions + 1] = action
  end)

  before_each(function()
    captured_actions = {}
  end)

  it("dispatch create character action for player character", function()
    local s = setup()
    s(dispatch_spy)

    assert.is_true(tables.any(
      captured_actions,
      function(c) return
        c.type == character.actions.types.character_add and
        c.payload.character.is_player_controlled
      end)
    )
  end)

  it("adds some random enemies", function()
    local s = setup()
    s(dispatch_spy)

    assert.is_true(tables.any(
      captured_actions,
      function(c) return
        c.type == character.actions.types.character_add and
        c.payload.character.is_enemy
      end)
    )
  end)
end)