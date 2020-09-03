-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("assets.stories.game_start", function()
  local event_types = require "game.rules.events.types"
  local events = require "moonpie.event_system"
  local game_start = require "assets.stories.game_start"

  before_each(function()
    events.clear()
  end)

  it("has one action that initiates the combat event", function()
    local cb = spy.new(function() end)
    events.subscribe(event_types.combat_start, spy_to_func(cb))
    game_start.choices[1].event()
    assert.spy(cb).was.called()
  end)
end)