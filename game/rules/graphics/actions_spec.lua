-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.actions", function()
  local Actions = require "game.rules.graphics.actions"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"

  describe("ACTION: playOnce", function()
    it("describes an animation to play", function()
      local animator = {}

      local action = Actions.animationPlayOnce(animator, "myAnimation")
      assert.equals("ANIMATION_PLAY_ONCE", action.type)
      assert.equals(animator, action.payload.animator)
      assert.equals("myAnimation", action.payload.animation)
    end)
  end)

  describe("ACTION: updateFrame", function()
    local state

    before_each(function()
      state = {
        world = {
          { animator = {
            isPlaying = true, update = spy.new(function() end),
            getCurrentFrame = function() return {} end }
          },
          { animator = {
            isPlaying = true, update = spy.new(function() end),
            getCurrentFrame = function() return {} end }
          },
        }
      }
      mockStore(state)
      mockDispatch.processComplex = true
    end)

    after_each(function()
      mockDispatch:reset()
    end)

    it("is treated as a thunk with an action type", function()
      local action = Actions.updateFrame(1)
      assert.equals("GRAPHICS_UPDATE_FRAME", action.type)
    end)

    it("fetches all entities with animators and updates their current frame", function()
      mockDispatch(Actions.updateFrame(29.3))
      assert.not_nil(state.world[1].sprite)
      assert.not_nil(state.world[2].sprite)
    end)

    it("does not update animators that have no animations playing", function()
      local noPlay = { animator = {
        isPlaying = false, update = spy.new(function() end),
        getCurrentFrame = function() return {} end }
      }
      table.insert(state.world, noPlay)
      mockDispatch(Actions.updateFrame(29.3))
      assert.spy(noPlay.animator.update).was.not_called()
    end)
  end)
end)