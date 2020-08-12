-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.game_view_action_add", function()
  local types = require "game.rules.actions.types"
  local game_view_action_add = require "game.rules.actions.game_view_action_add"

  it("takes a caption and function to perform for the action", function()
    local do_thing = function() end
    local act = game_view_action_add("Shoot Raygun", do_thing)
    assert.not_nil(act.type)
    assert.equals(types.game_view_action_add, act.type)
    assert.equals("Shoot Raygun", act.payload.text)
    assert.equals(do_thing, act.payload.action)
  end)
end)