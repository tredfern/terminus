-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.inputs.keyboard", function()
  local keyboard_map = require "game.ui.inputs.keyboard_map"
  local key_simulator = require "moonpie.keyboard"
  local mock_store = require "mock_store"
  local store
  local character = require "game.rules.character"

  describe("combat_map settings", function()
    before_each(function()
      store = mock_store({ })
      keyboard_map.enable_combat_map()
    end)

    it("can disable keyboard mapping", function()
      keyboard_map.disable_combat_map()
      key_simulator:keypressed("up")
      local msgs = store.get_actions(character.actions.types.character_move)
      assert.is_nil(msgs)
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
        local msgs = store.get_actions(character.actions.types.character_move)
        local move_up = msgs[1]

        assert.equals(player_character, move_up.payload.character)
        assert.equals(20, move_up.payload.x)
        assert.equals(31, move_up.payload.y)
      end)
    end)
  end)

end)