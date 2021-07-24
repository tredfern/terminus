-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.inputs.keyboard", function()
  local keyboard_map = require "game.ui.inputs.keyboard_map"
  local key_simulator = require "moonpie.keyboard"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local player = require "game.rules.player"
  local turn = require "game.rules.turn"
  local Position = require "game.rules.world.position"
  local TestStates = require "test_helpers.test_states"

  describe("MainScreen settings", function()
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

    it("can show the map screen", function()
      local app = require "game.app"
      stub(app, "worldMap")
      key_simulator:keyPressed("m")
      assert.spy(app.worldMap).was.called()
    end)

    it("can show the inventory screen", function()
      local app = require "game.app"
      stub(app, "inventory")
      key_simulator:keyPressed("i")
      assert.spy(app.inventory).was.called()
      app.inventory:revert()
    end)

    it("can show the journal screen", function()
      local app = require "game.app"
      stub(app, "journal")
      key_simulator:keyPressed("j")
      assert.spy(app.journal).was.called()
      app.journal:revert()
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

      describe("multistep commands", function()
        it("open doors triggers a mode where it waits for a directional command before dispatching command", function()
          local Orientation = require "game.rules.world.orientation"
          spy.on(player.actions, "openDoor")

          key_simulator:keyPressed("o")
          assert.spy(player.actions.openDoor).was.not_called()
          key_simulator:keyPressed("left")
          assert.spy(player.actions.openDoor).was.called_with(Orientation.west)
        end)
      end)
    end)

    describe("hotkey slots", function()
      local hotKeyHandler
      before_each(function()
        hotKeyHandler = spy.new(function() end)
        mockStore {
          player = {
            hotkeys = {
              ["1"] = {
                handler = hotKeyHandler
              }
            }
          }
        }
      end)

      it("dispatches the handler for a hot key if the hot key is encoded", function()
        key_simulator:keyPressed("1")
        assert.spy(hotKeyHandler).was.called()
      end)

      it("is ok if a hot key doesn't have a handler", function()
        assert.not_has_errors(function() key_simulator:keyPressed("2") end)
      end)
    end)
  end)

  describe("Cursor Mode", function()
    local Cursor = require "game.ui.cursor"

    before_each(function()
      mockStore({
        characters = {
          { isPlayerControlled = true, position = Position(3, 3, 3) }
        }
      })
    end)

    after_each(function()
      keyboard_map.endCursorMode()
    end)

    it("shows the cursor when starting cursor mode", function()
      keyboard_map.startCursorMode()
      assert.is_true(Cursor.isVisible)
      assert.is_true(keyboard_map.inCursorMode())
    end)

    it("sets the starting position of the cursor to the player", function()
      keyboard_map.startCursorMode()
      assert.equals(Position(3, 3, 3), Cursor.position)
    end)

    it("updates the cursor position when arrow keys are pressed", function()
      keyboard_map.startCursorMode()
      key_simulator:keyPressed("up")
      assert.equals(Position(3, 2, 3), Cursor.position)
      key_simulator:keyPressed("left")
      assert.equals(Position(2, 2, 3), Cursor.position)
      key_simulator:keyPressed("down")
      assert.equals(Position(2, 3, 3), Cursor.position)
      key_simulator:keyPressed("right")
      assert.equals(Position(3, 3, 3), Cursor.position)
    end)

    it("hides the cursor when ending cursor mode", function()
      keyboard_map.endCursorMode()
      assert.is_false(Cursor.isVisible)
      assert.is_false(keyboard_map.inCursorMode())
    end)

    it("enter ends cursor mode and can take a callback to trigger", function()
      local cb = spy.new(function() end)
      keyboard_map.startCursorMode(cb)
      key_simulator:keyPressed("return")

      assert.spy(cb).was.called()
      assert.is_false(keyboard_map.inCursorMode())
    end)
  end)

  describe("firing ranged weapon", function()
    before_each(function()
      TestStates.basicGameState()
    end)

    after_each(function()
      keyboard_map.endCursorMode()
    end)

    it("enters cursor mode when trigger key is pressed", function()
      key_simulator:keyPressed("f")
      assert.is_true(keyboard_map.inCursorMode())
    end)

    it("triggers the action when the enter key is pressed while in cursor mode", function()
      local Cursor = require "game.ui.cursor"
      spy.on(player.actions, "rangedAttack")
      key_simulator:keyPressed("f")
      key_simulator:keyPressed("return")
      assert.spy(player.actions.rangedAttack).was.called_with(Cursor.position)
      assert.is_false(keyboard_map.inCursorMode())
    end)

  end)
end)