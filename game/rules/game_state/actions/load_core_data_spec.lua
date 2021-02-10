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

  it("loads the core items", function()
    local Items = require "game.rules.items"

    -- Check a couple of default ones
    assert.not_nil(Items.list.sword)
    assert.not_nil(Items.list.laserGun)
  end)

  it("loads the core skills", function()
    local Skills = require "game.rules.character.skills"
    assert.not_nil(Skills.list.handgun)
    assert.not_nil(Skills.list.blade)
  end)
end)