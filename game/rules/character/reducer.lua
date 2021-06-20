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

  [types.REMOVE] = function(state, action)
    return tables.select(state,
    function(character)
      if character ~= action.payload.character then
        return character
      end
    end)
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