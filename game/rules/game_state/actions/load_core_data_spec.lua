-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions.load_core_data", function()
  local loadCoreData = require "game.rules.game_state.actions.load_core_data"

  before_each(function()
    local action = loadCoreData()
    action()
  end)

  it("loads the core skills", function()
    local Skills = require "game.rules.skills"
    assert.not_nil(Skills.list.handgun)
    assert.not_nil(Skills.list.blade)
  end)

  it("loads the core terrains", function()
    local Terrain = require "game.rules.map.terrain"
    assert.not_nil(Terrain.list.room)
    assert.not_nil(Terrain.list.corridor)
  end)
end)
