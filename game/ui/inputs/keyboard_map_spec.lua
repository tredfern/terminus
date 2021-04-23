-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.inputs.keyboard", function()
  local keyboard_map = require "game.ui.inputs.keyboard_map"
  local key_simulator = require "moonpie.keyboard"
  local mockStore = require "test_helpers.mock_store"
  local player = require "game.rules.player"
  local turn = require "game.rules.turn"
  local Position = require "game.rules.world.position"

  describe("combat_map settings", function()
    before_each(function()
      spy.on(player.actions, "move")
      spy.on(player.actions, "ladderUp")
      spy.on(player.actions, "ladderDown")
      spy.on(turn.actions, "process")
      keyboard_map.enableCombatMap()
    end)

    it("can disable keyboard mapping", function()
      keyboard_map.disableCombatMap()
      key_simulator:keyPressed("up")
      assert.spy(player.actions.move).was_not.called()
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
        assert.spy(player.actions.move).was.called_with(Position.north)
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move down", function()
        key_simulator:keyPressed("down")
        assert.spy(player.actions.move).was.called_with(Position.south)
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move right", function()
        key_simulator:keyPressed("right")
        assert.spy(player.actions.move).was.called_with(Position.east)
        assert.spy(turn.actions.process).was.called()
      end)

      it("can move right", function()
        key_simulator:keyPressed("left")
        assert.spy(player.actions.move).was.called_with(Position.west)
        assert.spy(turn.actions.process).was.called()
      end)

      it("can climb ladders up", function()
        key_simulator:keyPressed(".")
        assert.spy(player.actions.ladderUp).was.called()
        assert.spy(turn.actions.process).was.called()
      end)

      it("can climb ladders down", function()
        key_simulator:keyPressed(",")
        assert.spy(player.actions.ladderDown).was.called()
        assert.spy(turn.actions.process).was.called()
      end)

      it("can pickup items", function()
        spy.on(player.actions, "pickupItems")
        key_simulator:keyPressed("g")
        assert.spy(player.actions.pickupItems).was.called()
        assert.spy(turn.actions.process).was.called()
      end)
    end)
  end)
end)