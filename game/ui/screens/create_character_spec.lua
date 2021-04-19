-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.create_character", function()
  local create_character = require "game.ui.screens.create_character"
  local character = require "game.rules.character"
  local mockStore = require "test_helpers.mock_store"
  local player = {
    name = "Papageno",
    isPlayerControlled = true, position = { x = 19, y = 28 },
    attributes = {},
    skills = {}
  }
  local store

  before_each(function()
    store = mockStore ({
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
    c:findByID("button_done"):click()
    assert.spy(app.combat).was.called()
  end)

  it("dispatch set character name action on done", function()
    local c = moonpie.test_render(create_character())
    local textbox = c:findByID("character_name")
    textbox:set_text("Foo")

    c:findByID("button_done"):click()

    assert.equals(1, #store.get_actions(character.actions.types.SET_NAME))
    local action = store.get_actions(character.actions.types.SET_NAME)[1]
    assert.equals(player, action.payload.character)
    assert.equals("Foo", action.payload.name)
  end)

  it("displays the character abilities section", function()
    local c = moonpie.test_render(create_character())
    assert.not_nil(c:findByID("characterAttributes"))
  end)

  it("displays the character skills section", function()
    local c = moonpie.test_render(create_character())
    assert.not_nil(c:findByID("characterSkills"))
  end)

end)