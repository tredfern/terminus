-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Graphics = require "game.rules.graphics"
local Thunk = require "moonpie.redux.thunk"

return function(deltaTime)
  return Thunk("GAME_STATE_UPDATE_FRAME", function(dispatch)
    dispatch(Graphics.actions.updateFrame(deltaTime))
  end)
end