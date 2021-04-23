-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local actionTypes = require "game.rules.player.actions.types"
local getPlayer = require "game.rules.player.selectors.get_player"
local getByPosition = require "game.rules.world.selectors.get_by_position"
local tables = require "moonpie.tables"
local move = require "game.rules.character.actions.move"
local Position = require "game.rules.world.position"


return function()
  return Thunk(actionTypes.LADDER_DOWN, function(dispatch, getState)
    local state = getState()
    local player = getPlayer(state)
    local entities = getByPosition(state, player.position)
    local ladder = tables.findFirst(entities, function(e) return e.ladderDown ~= nil end)

    if ladder then
      dispatch(move(player, Position.down(player.position)))
    end
  end)
end
