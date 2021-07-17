-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local app = require "game.app"
local player = require "game.rules.player"
local FullScreenPanel = require "game.ui.widgets.full_screen_panel"
local BasicInformation = require "game.ui.create_character.basic_information"
local CareerTerms = require "game.ui.create_character.career_terms"
local Equip = require "game.ui.create_character.equip"

local nextButton = function(props)
  return Components.button {
    id = "btnNext",
    wizard = props.wizard,
    caption = "Next",
    click = function()
      props.wizard:update { currentStep = props.wizard.currentStep + 1 }
    end,
    hidden = props.wizard.currentStep >= #props.wizard.steps
  }
end

local doneButton = function(props)
  return Components.button {
    id = "btnDone",
    caption = "Done",
    wizard = props.wizard,
    click = function()
      app.gameStart()
    end,
    hidden = props.wizard.currentStep < #props.wizard.steps
  }
end

local create_character = Components("create_character", function(props)
  return {
    id = "createCharacterScreen",
    editCharacter = props.character,
    steps = {
      BasicInformation { character = props.character },
      CareerTerms { character = props.character },
      Equip()
    },
    currentStep = 1,
    render = function(self)
      return FullScreenPanel {
        title = "Create Character",
        actions = {
          nextButton { wizard = self },
          doneButton { wizard = self }
        },
        contents = {
          padding = 6,
          self.steps[self.currentStep]
        },
      }
    end
  }
end)

return connect(create_character, function(state)
  local p = player.selectors.getPlayer(state)
  return {
    character = p
  }
end)