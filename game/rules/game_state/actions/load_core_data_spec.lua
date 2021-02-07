-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions.load_core_data", function()
  local loadCoreData = require "game.rules.game_state.actions.load_core_data"

  it("loads the core items", function()
    loadCoreData()
    local Items = require "game.rules.items"

    -- Check a couple of default ones
    assert.not_nil(Items.list.sword)
    assert.not_nil(Items.list.laserGun)
  end)
end)