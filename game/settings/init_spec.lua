-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.settings", function()
  local Settings = require "game.settings"

  it("has actions available", function()
    assert.not_nil(Settings.actions.setOption)
    assert.not_nil(Settings.actions.toggleOption)
  end)

  it("has selectors to get values available", function()
    assert.not_nil(Settings.selectors.getOption)
  end)

  it("can return path to assets", function()
    assert.equals("assets/characters/character_idle.png", Settings.assetPath("characters/character_idle.png"))
  end)
end)