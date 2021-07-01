-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.create_character", function()
  local CreateCharacter = require "game.ui.create_character"
  local testStates = require "test_helpers.test_states"

  before_each(function()
    testStates.basicGameState()
  end)

  it("starts on the basic information screen", function()
    local c = moonpie.testRender(CreateCharacter())
    local bi = c:findByID("basicInformation")
    assert.is_falsy(bi:isHidden())
  end)

  it("can move from the basic information screen to the career terms screen", function()
    local c = moonpie.testRender(CreateCharacter())
    local cc = c:findByID("createCharacterScreen")
    local bi = c:findByID("basicInformation")
    assert.is_falsy(bi:isHidden())
    cc:findByID("btnNext"):click()
    assert.equals(2, cc.currentStep)
    c = moonpie.testRender(cc)
    assert.is_nil(c:findByID("basicInformation"))

    local ct = c:findByID("careerTerms")
    assert.is_falsy(ct:isHidden())
  end)

  it("can move from the career terms to equip screen", function()
    local c = moonpie.testRender(CreateCharacter())
    local cc = c:findByID("createCharacterScreen")
    c:findByID("btnNext"):click()
    c:findByID("btnNext"):click()
    c = moonpie.testRender(cc)
    local es = c:findByID("equipCharacter")
    assert.is_falsy(es:isHidden())
    assert.is_true(c:findByID("btnNext"):isHidden())
    assert.is_falsy(c:findByID("btnDone"):isHidden())
  end)

  it("continues to the game start screen after done", function()
    local app = require "game.app"
    spy.on(app, "gameStart")

    local c = moonpie.testRender(CreateCharacter())
    c:findByID("btnDone"):click()
    assert.spy(app.gameStart).was.called()
  end)

  it("sets up the character state when done", function()
    pending()
  end)
end)