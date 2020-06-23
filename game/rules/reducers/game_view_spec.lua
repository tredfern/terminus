-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers.game_view", function()
  local game_view = require "game.rules.reducers.game_view"
  local types = require "game.rules.actions.types"

  it("sets that active_current_view on game_view_set action", function()
    local view = {}
    local state = game_view({}, { type = types.game_view_set, payload = view })
    assert.equals(view, state.current)
  end)

  it("handles when state is nil", function()
    local view = {}
    local state = game_view(nil, { type = types.game_view_set, payload = view })
    assert.equals(view, state.current)
  end)


end)