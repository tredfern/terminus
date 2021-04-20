-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.inputs.keyboard", function()
  local keyboard_map = require "game.ui.inputs.keyboard_map"
  local key_simulator = require "moonpie.keyboard"
  local mockStore = require "test_helpers.mock_store"
  local character = require "game.rules.character"
  local turn = require "game.rules.turn"
  local Position = require "game.rules.world.position"

  describe("combat_map settings", function()
    before_each(function()
      spy.on(character.actions, "move")
      spy.on(turn.actions, "process")
      keyboard_map.enableCombatMap()
    end)

    it("can disable keyboard mapping", function()
      keyboard_map.disableCombatMap()
      key_simulator:keyPressed("up")
      assert.spy(character.actions.move).was_not.called()
    end)

    it("can show/hide grid lines", function()
      mockStore({})
      local Settings = require "game.settings"
      spy.on(Settings.actions, "toggleOption")
      key_simulator:keyPressed("shift+g")
      assert.spy(Settings.actions.toggleOption).was.called_with("show_grid_lines")
    end)

    it("can show the character detail screen", function()
      local app = require "game.app"
      stub(app, "characterDetails")
      key_simulator:keyPressed("tab")
      assert.spy(app.characterDetails).was.called()
    end)

    describe("character movement", function()
      local player_character

      before_each(function()
        player_character = {
          isPlayerControlled = true,
          position = Position(20, 32),
          health = 1
        }

        mockStore({
          characters = {
            player_character
          },
          map = {
            getTerrain = function() return {} end
          },
          items = { }
        })
      end)

      it("can move up", function()
        key_simulator:keyPressed("up")
        assert.spy(character.actions.move).was.called_with(player_character, match.is_position(20, 31))
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move down", function()
        key_simulator:keyPressed("down")
        assert.spy(character.actions.move).was.called_with(player_character, match.is_position(20, 33))
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move right", function()
        key_simulator:keyPressed("right")
        assert.spy(character.actions.move).was.called_with(player_character, match.is_position(21, 32))
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move right", function()
        key_simulator:keyPressed("left")
        assert.spy(character.actions.move).was.called_with(player_character, match.is_position(19, 32))
        assert.spy(turn.actions.process).was.called()
      end)

      it("can pickup items", function()
        spy.on(character.actions, "pickupItems")
        key_simulator:keyPressed("g")
        assert.spy(character.actions.pickupItems).was.called_with(player_character)
        assert.spy(turn.actions.process).was.called()
      end)
    end)
  end)
end)