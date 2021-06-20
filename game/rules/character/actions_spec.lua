-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions", function()
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local Actions = require "game.rules.character.actions"

  describe("ACTIONS: add", function()
    it("specifies the new character to add to the store", function()
      local c = {}
      local act = Actions.add(c)

      assert.equals("CHARACTER_ADD", act.type)
      assert.equals(c, act.payload.character)
    end)
  end)

  describe("game.rules.character.actions.heal", function()
    it("dispatches an update to set the character health to a higher value", function()
      local character = { health = 10 }
      local action = Actions.heal(character)

      action(mockDispatch)
      assert.is_true(mockDispatch:received_action(Actions.types.SET_HEALTH))
    end)
  end)

  describe("ACTION: move", function()
    local wrap_in_function = require "wrap_in_function"
    local Skills = require "game.rules.skills"
    local Attributes = require "game.rules.character.attributes"
    local Position = require "game.rules.world.position"

    before_each(function()
      Skills.list.unarmed = { name = "Unarmed", key = "unarmed", attribute = Attributes.strength }
    end)

    it("dispatches a set_position message to move the character to the correct coordinates", function()
      local c = { position = Position.new(18, 9) }
      local state = {
        characters = { c }
      }
      local action = Actions.move(c, Position(19, 10))

      action(mockDispatch, wrap_in_function(state))
      assert.is_true(mockDispatch:received_action(Actions.types.SET_POSITION))
    end)

    it("creates a melee attack action if there is another character in the square attempting to move to", function()
      local Combat = require "game.rules.combat"
      spy.on(Combat.actions, "meleeAttack")
      local player = { position = Position.new(19, 11) }
      local enemy = { position = Position.new(20, 11) }
      local state = {
        characters = {
          player, enemy
        }
      }

      local action = Actions.move(player, Position(20, 11))
      action(mockDispatch, wrap_in_function(state))

      assert.spy(Combat.actions.meleeAttack).was.called_with(player, enemy)
    end)
  end)

  describe("ACTION: remove", function()
    it("describes the character that needs to be removed", function()
      local c = {}
      local action = Actions.remove(c)

      assert.not_nil(action.type)
      assert.equals(Actions.types.REMOVE, action.type)
      assert.equals(c, action.payload.character)
    end)
  end)

  describe("ACTION: setAttribute", function()
    local attributes = require "game.rules.character.attributes"
    it("takes an attribute name and a value", function()
      local character = {}
      local action = Actions.setAttribute(character, attributes.strength, 15)
      assert.equals("CHARACTER_SET_ATTRIBUTE", action.type)
      assert.equals(character, action.payload.character)
      assert.equals(attributes.strength, action.payload.attribute)
      assert.equals(15, action.payload.value)
    end)
  end)

  describe("ACTION: setHealth", function()
    it("describes the new health level", function()
      local c = {}
      local action = Actions.setHealth(c, 48)
      assert.equals("CHARACTER_SET_HEALTH", action.type)
      assert.equals(c, action.payload.character)
      assert.equals(48, action.payload.health)
    end)

  end)

  describe("ACTION: setName", function()
    it("sets up an action that specifies the character name to change", function()
      local c = {}
      local action = Actions.setName(c, "Bar")

      assert.equals("CHARACTER_SET_NAME", action.type)
      assert.equals(c, action.payload.character)
      assert.equals("Bar", action.payload.name)
    end)
  end)

  describe("ACTION: setPosition", function()
    local Position = require "game.rules.world.position"

    it("specifies the position to update the character to", function()
      local c = {}
      local sp = Actions.setPosition(c, Position(89, 38))
      assert.not_nil(sp.type)
      assert.equals(Actions.types.SET_POSITION, sp.type)
      assert.equals(c, sp.payload.character)
      assert.equals(89, sp.payload.position.x)
      assert.equals(38, sp.payload.position.y)
    end)

    it("is invalid if terrain blocks movement", function()
      local sp = Actions.setPosition({}, Position(5, 3, 1))
      local map = {
        tiles = {
          [Position(5, 3, 1)] = { terrain = { blocksMovement = true } }
        }
      }
      assert.is_false(sp:validate({ map = map }))
    end)

    it("is valid if terrain allows movement", function()
      local sp = Actions.setPosition({}, Position(5, 3, 1))
      local state = {
        map = {
          tiles = {
            [Position(5, 3, 1)] = { terrain = {} }
          }
        }
      }

      assert.equals(Position(5, 3, 1), sp.payload.position)
      assert.is_true(sp:validate(state))
    end)

    it("is invalid if an entity blocks movement", function()
      local sp = Actions.setPosition({}, Position(5, 4, 1))
      local state = {
        map = {
          tileMap = {
            getTile = function() return { terrain = {} } end
          }
        },
        world = {
          { blocksMovement = true, position = Position(5, 4, 1) }
        }
      }
      assert.is_false(sp:validate(state))
    end)

  end)
end)