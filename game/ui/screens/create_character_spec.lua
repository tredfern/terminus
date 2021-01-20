-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.create_character", function()
  local create_character = require "game.ui.screens.create_character"
  local character = require "game.rules.character"
  local mock_store = require "mock_store"
  local player = {
    is_player_controlled = true, x = 19, y = 28
  }
  local store

  before_each(function()
    store = mock_store({
      characters = {
        player
      },
      turn = { }
    })
  end)



  it("has a button that continues to the combat screen", function()
    local app = require "game.app"
    spy.on(app, "combat")

    local c = moonpie.test_render(create_character())
    c:find_by_id("button_done"):click()
    assert.spy(app.combat).was.called()
  end)

  it("dispatch set character name action on done", function()
    local c = moonpie.test_render(create_character())
    local textbox = c:find_by_id("character_name")
    textbox:set_text("Foo")

    c:find_by_id("button_done"):click()

    assert.equals(1, #store.get_actions(character.actions.types.character_set_name))
    local action = store.get_actions(character.actions.types.character_set_name)[1]
    assert.equals(player, action.payload.character)
    assert.equals("Foo", action.payload.name)
  end)

end)