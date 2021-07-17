-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local Character = require "game.rules.character"
local connect = require "moonpie.redux.connect"
local bind = require "moonpie.redux.bind"
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
    Components.icon { display = "inline", icon = Attributes.getIcon(attribute),
      style = "attribute-icon icon-medium align-middle" },
    {
      display = "inline",
      width = "75%",
      { Components.text { text = "{{attribute}}", style = "attribute-title align-center", attribute = attribute } },
      bind(Spinner({
        id = attribute .. "Spinner", value = score, style = "attribute-spinner align-center",
        minimum = Attributes.pointBuyMinimum(), maximum = Attributes.pointBuyMaximum(),
        onIncrease = function()
          store.dispatch(Character.actions.buyAttributePoint(character, attribute))
        end, onDecrease = function()
          store.dispatch(Character.actions.sellAttributePoint(character, attribute))
        end
      }), function(spin, state)
        local v = Character.selectors.getAttribute(state, character, attribute)
        spin:update { value = v }
      end)
    },
  }
end

local function characterName(props)
  return Row({
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
        onUpdate = function(textBox)
          store.dispatch(Character.actions.setName(props.character, textBox:getText()))
        end
      },
    }
  })
end

local function attributes(props)
  return Row({
    padding = { top = 3, bottom = 3 },
    columns = 4,
    {
      columnWidth = 1,
      { Components.h3 { text = "Attributes" } },
      bind(
        Components.text { id = "buyPoints", margin = { left = 15 } }, function(c, state)
          c:update { text = string.format("Points: %d", Character.selectors.getBuyPoints(state, props.character)) }
        end
      )
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
end

local BasicInformation = Components("createCharacterBasicInformation", function(props)
  return {
    character = props.character,
    attributes = props.attributes,
    characterName = props.characterName,
    id = "basicInformation",
    characterName(props),
    attributes(props)
  }
end)

return connect(BasicInformation, function(state, props)
  return {
    characterName = Character.selectors.getName(state, props.character),
    attributes = Character.selectors.getAttributes(state, props.character)
  }
end)