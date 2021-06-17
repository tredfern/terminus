-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Dice = require "moonpie.math.dice"
local tables = require "moonpie.tables"
local Thunk = require "moonpie.redux.thunk"
local MessageLog = require "game.rules.message_log"
local Messages = require "assets.messages"

local TARGET_NUMBER = 8
local skillCheckCup = Dice.cup(Dice.d6, Dice.d6)
local Actions = {}
Actions.types = require "game.rules.skills.types"

function Actions.taskCheck(modifiers, successAction, failAction)
  return Thunk(Actions.types.TASK_CHECK, function(dispatch)
    local roll = skillCheckCup()
    local modScore = tables.sum(modifiers)
    dispatch(MessageLog.actions.add(Messages.skills.taskCheck, { roll = roll, modifiers = modScore }))
    if roll + modScore >= TARGET_NUMBER then
      dispatch(successAction)
    else
      dispatch(failAction)
    end
  end)
end

return Actions