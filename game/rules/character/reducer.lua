-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.types"
local createSlice = require "moonpie.redux.create_slice"
local tables = require "moonpie.tables"

return createSlice {
  [types.ADD] = function(state, action)
    return tables.concatArray(state, { action.payload.character })
  end,

  [types.BUY_ATTRIBUTE_POINT] = function(state, action)
    local Attributes = require "game.rules.character.attributes"
    local c, attr = action.payload.character, action.payload.attribute

    if c.attributes.buyPoints > 0 and c.attributes[attr] < Attributes.pointBuyMaximum() then
      c.attributes[attr] = c.attributes[attr] + 1
      c.attributes.buyPoints = c.attributes.buyPoints - 1
    end

    return state
  end,

  [types.NEW] = function(state, action)
    return tables.concatArray(state, { action.payload.character })
  end,

  [types.REMOVE] = function(state, action)
    return tables.select(state,
    function(character)
      if character ~= action.payload.character then
        return character
      end
    end)
  end,

  [types.SELL_ATTRIBUTE_POINT] = function(state, action)
    local Attributes = require "game.rules.character.attributes"
    local c, attr = action.payload.character, action.payload.attribute

    if c.attributes[attr] > Attributes.pointBuyMinimum() then
      c.attributes[attr] = c.attributes[attr] - 1
      c.attributes.buyPoints = c.attributes.buyPoints + 1
    end

    return state
  end,

  [types.SET_ATTRIBUTE] = function(state, action)
    local character = action.payload.character
    character.attributes[action.payload.attribute] = action.payload.value
    return state
  end,

  [types.SET_HEALTH] = function(state, action)
    local colors = require "game.rules.graphics.colors"
    local c = action.payload.character
    c.health = action.payload.health
    if c.sprite then
      if c.health < 10 then
        c.sprite.color = colors.lowHealth
      else
        c.sprite.color = colors.drawDefault
      end
    end
    return state
  end,

  [types.SET_NAME] = function(state, action)
    local c = action.payload.character
    c.name = action.payload.name
    return state
  end,

  [types.SET_POSITION] = function(state, action)
    local c = action.payload.character
    c.position = action.payload.position
    return state
  end,
}