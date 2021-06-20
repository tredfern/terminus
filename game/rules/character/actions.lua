-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local sounds = require "assets.sounds"
local Thunk = require "moonpie.redux.thunk"
local tables = require "moonpie.tables"
local map = require "game.rules.map"
local World = require "game.rules.world"
local Selectors = require "game.rules.character.selectors"

local Actions = {}
Actions.types = require "game.rules.character.types"

function Actions.add(character)
  return {
    type = Actions.types.ADD,
    payload = {
      character = character
    }
  }
end

function Actions.heal(character)
  return function(dispatch)
    dispatch(Actions.setHealth(character, character.health + 5))
  end
end

function Actions.move(character, position)
  local Combat = require "game.rules.combat"

  return Thunk(Actions.types.MOVE, function(dispatch, getState)
    local targets = Selectors.getByPosition(getState(), position)
    if #targets > 0 then
      dispatch(Combat.actions.meleeAttack(character, targets[1]))
    else
      if character.isPlayerControlled then
        sounds.walk:play()
      end

      dispatch(Actions.setPosition(character, position))
    end
  end)
end

function Actions.remove(character)
  return {
    type = Actions.types.REMOVE,
    payload = {
      character = character
    }
  }
end

function Actions.setAttribute(character, attribute, value)
  return {
    type = Actions.types.SET_ATTRIBUTE,
    payload = {
      character = character,
      attribute = attribute,
      value = value
    }
  }
end

function Actions.setHealth(character, health)
  return {
    type = Actions.types.SET_HEALTH,
    payload = {
      character = character,
      health = health
    }
  }
end

function Actions.setName(character, name)
  return {
    type = Actions.types.SET_NAME,
    payload = {
      character = character,
      name = name
    }
  }
end


function Actions.setPosition(character, position)
  return {
    type = Actions.types.SET_POSITION,
    payload = {
      character = character,
      position = position
    },
    validate = function(_, state)
      local terrain = map.selectors.getTerrain(state, position)
      if terrain.blocksMovement then return false end

      -- search entities
      local entities = World.selectors.getByPosition(state, position)
      if not tables.isEmpty(entities) then
        return not tables.any(entities, function(e) return e.blocksMovement end)
      end

      return true
    end
  }
end

return Actions