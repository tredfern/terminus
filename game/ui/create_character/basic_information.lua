-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Character = require "game.rules.character"
local connect = require "moonpie.redux.connect"
local Spinner = require "game.ui.widgets.spinner"
local store = require "game.store"
local Row = require "game.ui.widgets.row"
local Attributes = Character.attributes

local function getAttributeValues(attributes, attribute)
  return attributes[attribute].value, attributes[attribute].modifier
end

local function AttributeComp(character, attributes, attribute)
  local score = getAttributeValues(attributes, attribute)
  return {
    style = "attribute",
    {
      Components.text { text = "{{attribute}}", style = "attribute-title align-middle", attribute = attribute },
      Spinner {
        id = attribute .. "Spinner", value = score, style = "align-right",
        minimum = Attributes.pointBuyMinimum(), maximum = Attributes.pointBuyMaximum(),
        onIncrease = function()
          store.dispatch(Character.actions.buyAttributePoint(character, attribute))
        end, onDecrease = function()
          store.dispatch(Character.actions.sellAttributePoint(character, attribute))
        end
      },
    },
  }
end

local BasicInformation = Components("createCharacterBasicInformation", function(props)
  local updateName = function(textBox)
    store.dispatch(Character.actions.setName(props.character, textBox:getText()))
  end

  return {
    character = props.character,
    id = "basicInformation",
    Row({
      padding = { top = 3, bottom = 3 },
      columns = 4, {
        columnWidth = 1,
        Components.h3 { text = "Name" },
      }, {
        columnWidth = 3,
        Components.textbox {
          id = "characterName",
          text = props.characterName,
          click = function(self) self:setFocus() end,
          width = "100%",
          onUpdate = updateName
        },
      }
    }),
    Row({
      padding = { top = 3, bottom = 3 },
      columns = 4,
      {
        columnWidth = 1,
        { Components.h3 { text = "Attributes" } },
        Components.text { id = "buyPoints", margin = { left = 15 }, text = "Points: {{points}}",
        points = props.buyPoints }
      }, {
        columnWidth = 3,
        Row({
          columns = 3,
          {
            columnWidth = 1,
            AttributeComp(props.character, props.attributes, Attributes.strength),
          }, {
            columnWidth = 1,
            AttributeComp(props.character, props.attributes, Attributes.dexterity),
          }, {
            columnWidth = 1,
            AttributeComp(props.character, props.attributes, Attributes.endurance),
          }
        }),
        Row({
          columns = 3, {
            columnWidth = 1,
            AttributeComp(props.character, props.attributes, Attributes.knowledge),
          }, {
            columnWidth = 1,
            AttributeComp(props.character, props.attributes, Attributes.intelligence)
          }, {
            columnWidth = 1,
            AttributeComp(props.character, props.attributes, Attributes.charisma)
          }
        })
      }
    })
  }
end)

return connect(BasicInformation, function(state, props)
  return {
    characterName = Character.selectors.getName(state, props.character),
    attributes = Character.selectors.getAttributes(state, props.character)
  }
end)