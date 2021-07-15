-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.reducer", function()
  local characters_reducer = require "game.rules.character.reducer"
  local types = require "game.rules.character.types"
  local Position = require "game.rules.world.position"
  local Attributes = require "game.rules.character.attributes"

  it("returns the same state if the action is not handled", function()
    local state = {}
    assert.equals(state, characters_reducer(state, { type = "random_action" }))
  end)

  it("adds new characters to the store through the ADD action", function()
    local new_char = {}
    local add = {
      type = types.ADD,
      payload = {
        character = new_char
      }
    }

    local new_state = characters_reducer({}, add)
    assert.array_includes(new_char, new_state)
  end)

  it("removes the character specified from the array", function()
    local character = {}
    local keep_character = {}
    local state = { character, keep_character }
    local action = { type = types.REMOVE, payload = { character = character } }

    local new_state = characters_reducer(state, action)
    assert.not_array_includes(character, new_state)
    assert.array_includes(keep_character, new_state)
  end)

  it("can set the character to the specified position", function()
    local character = { position = { x = 3, y = 8 } }
    local state = { character }
    local action = { type = types.SET_POSITION,
      payload = {
        character = character,
        position = Position(4, 9)
      }
    }

    local new_state = characters_reducer(state, action)
    local c = new_state[1]
    assert.equals(character, c)
    assert.equals(4, c.position.x)
    assert.equals(9, c.position.y)
  end)

  it("can set the character name", function()
    local character = {}
    local state = { character }
    local action = {
      type = types.SET_NAME,
      payload = {
        character = character,
        name = "Papageno"
      }
    }

    local new_state = characters_reducer(state, action)
    local c = new_state[1]
    assert.equals("Papageno", c.name)
  end)

  it("sets the initial state to empty table", function()
    local state = characters_reducer(nil, {})
    assert.same(0, #state)
  end)

  it("set the character health", function()
    local character = { health = 84 }
    local state = { characters = { character } }
    local new_state = characters_reducer(state, {
      type = types.SET_HEALTH,
      payload = {
        character = character,
        health = 54
      }
    })

    assert.equals(54, new_state.characters[1].health)
  end)

  it("sets attributes to specific values", function()
    local attributes = require "game.rules.character.attributes"
    local character = { attributes = { } }
    local state = { characters = { character } }

    local newState = characters_reducer(state, {
      type = types.SET_ATTRIBUTE,
      payload = {
        character = character,
        attribute = attributes.strength,
        value = 15
      }
    })

    assert.equals(15, newState.characters[1].attributes[attributes.strength])
  end)

  describe("Buy/Sell Attribute Points", function()
    local character, state

    before_each(function()
      character = { attributes = {
        buyPoints = 10,
        ["STRENGTH"] = 5
      } }
      state = { characters = { character } }
    end)

    it("increments the attribute and subtracts a buypoint", function()
      characters_reducer(state, {
        type = types.BUY_ATTRIBUTE_POINT,
        payload = {
          character = character,
          attribute = Attributes.strength
        }
      })

      assert.equals(6, character.attributes[Attributes.strength])
      assert.equals(9, character.attributes.buyPoints)
    end)

    it("does nothing if there are no buy points", function()
      character.attributes.buyPoints = 0
      characters_reducer(state, {
        type = types.BUY_ATTRIBUTE_POINT,
        payload = {
          character = character,
          attribute = Attributes.strength
        }
      })

      assert.equals(5, character.attributes[Attributes.strength])
      assert.equals(0, character.attributes.buyPoints)
    end)

    it("does not increase past the maximum", function()
      character.attributes[Attributes.strength] = Attributes.pointBuyMaximum()
      characters_reducer(state, {
        type = types.BUY_ATTRIBUTE_POINT,
        payload = {
          character = character,
          attribute = Attributes.strength
        }
      })

      assert.equals(Attributes.pointBuyMaximum(), character.attributes[Attributes.strength])
    end)

    it("decreases the attribute and adds a buypoint to the pool", function()
      characters_reducer(state, {
        type = types.SELL_ATTRIBUTE_POINT,
        payload = {
          character = character,
          attribute = Attributes.strength
        }
      })

      assert.equals(4, character.attributes[Attributes.strength])
      assert.equals(11, character.attributes.buyPoints)
    end)

    it("does nothing if decreasing below attribute minimum", function()
      character.attributes[Attributes.strength] = Attributes.pointBuyMinimum()
      characters_reducer(state, {
        type = types.SELL_ATTRIBUTE_POINT,
        payload = {
          character = character,
          attribute = Attributes.strength
        }
      })

      assert.equals(Attributes.pointBuyMinimum(), character.attributes[Attributes.strength])
      assert.equals(10, character.attributes.buyPoints)
    end)
  end)
end)