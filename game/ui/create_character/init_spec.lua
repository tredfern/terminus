-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.create_character", function()
  local create_character = require "game.ui.create_character"
  local character = require "game.rules.character"
  local testStates = require "test_helpers.test_states"
  local player, store

  before_each(function()
    store, player = testStates.basicGameState()
  end)

  it("has a button that continues to the game start screen", function()
    local app = require "game.app"
    spy.on(app, "gameStart")

    local c = moonpie.testRender(create_character())
    c:findByID("button_done"):click()
    assert.spy(app.gameStart).was.called()
  end)

  it("dispatch set character name action on done", function()
    local c = moonpie.testRender(create_character())
    local textbox = c:findByID("character_name")
    textbox:setText("Foo")

    c:findByID("button_done"):click()

    assert.equals(1, #store.get_actions(character.actions.types.SET_NAME))
    local action = store.get_actions(character.actions.types.SET_NAME)[1]
    assert.equals(player, action.payload.character)
    assert.equals("Foo", action.payload.name)
  end)

  it("displays the character abilities section", function()
    local c = moonpie.testRender(create_character())
    assert.not_nil(c:findByID("characterAttributes"))
  end)

  it("displays the character skills section", function()
    local c = moonpie.testRender(create_character())
    assert.not_nil(c:findByID("characterSkills"))
  end)

end)