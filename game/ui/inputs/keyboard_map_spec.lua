-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.inputs.keyboard", function()
  local keyboard_map = require "game.ui.inputs.keyboard_map"
  local key_simulator = require "moonpie.keyboard"
  local mock_store = require "mock_store"
  local character = require "game.rules.character"
  local turn = require "game.rules.turn"

  describe("combat_map settings", function()
    before_each(function()
      spy.on(character.actions, "move")
      spy.on(turn.actions, "process")
      keyboard_map.enable_combat_map()
    end)

    it("can disable keyboard mapping", function()
      keyboard_map.disable_combat_map()
      key_simulator:keypressed("up")
      assert.spy(character.actions.move).was_not.called()
    end)

    describe("character movement", function()
      local player_character

      before_each(function()
        player_character = {
          is_player_controlled = true,
          x = 20,
          y = 32
        }

        mock_store({
          characters = {
            player_character
          }
        })
      end)

      it("can move up", function()
        key_simulator:keypressed("up")
        assert.spy(character.actions.move).was.called_with(player_character, 20, 31)
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move down", function()
        key_simulator:keypressed("down")
        assert.spy(character.actions.move).was.called_with(player_character, 20, 33)
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move right", function()
        key_simulator:keypressed("right")
        assert.spy(character.actions.move).was.called_with(player_character, 21, 32)
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move right", function()
        key_simulator:keypressed("left")
        assert.spy(character.actions.move).was.called_with(player_character, 19, 32)
        assert.spy(turn.actions.process).was.called()
      end)
    end)
  end)
end)