-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Dice = require "moonpie.math.dice"
local tables = require "moonpie.tables"
local Thunk = require "moonpie.redux.thunk"
local skillCheck = Dice.cup(Dice.d6, Dice.d6, Dice.d6)
local MessageLog = require "game.rules.message_log"
local Messages = require "assets.messages"
local Calculator = require "game.rules.skills.calculator"

local skillCheckCup = Dice.cup(Dice.d6, Dice.d6)
local Actions = {}
Actions.types = require "game.rules.skills.types"

function Actions.opposedCheck(aggressor, aggSkill, defender, defSkill, callback)
  return Thunk(Actions.types.OPPOSED_CHECK, function(dispatch)
    local aggTarget = Calculator(aggressor, aggSkill)
    local defTarget = Calculator(defender, defSkill)

    local aggRoll = skillCheck()
    local defRoll = skillCheck()
    local aggSucceed = aggRoll < aggTarget
    local defSucceed = defRoll < defTarget

    dispatch(MessageLog.actions.add(
      Messages.skills.opposed[1],
      {
        aggressor = aggressor.name,
        aggSkill = aggSkill.name,
        aggRoll = aggRoll,
        aggTarget = aggTarget,
        defender = defender.name,
        defSkill = defSkill.name,
        defRoll = defRoll,
        defTarget = defTarget
      })
    )

    if aggSucceed and not defSucceed then
      callback(aggressor, defender)
    else
      callback(defender, aggressor)
    end
  end)
end

function Actions.perform(skill, character, successCallback, failCallback)
  return Thunk(Actions.types.PERFORM_CHECK, function()
    local target = Calculator(character, skill)
    local roll = skillCheck()
    if roll <= target then
      successCallback(target, roll)
    else
      failCallback(target, roll)
    end
  end)
end

function Actions.taskCheck(targetNumber, modifiers, successAction, failAction)
  return Thunk(Actions.types.TASK_CHECK, function(dispatch)
    local roll = skillCheckCup()
    local modScore = tables.sum(modifiers)
    if roll + modScore >= targetNumber then
      dispatch(successAction)
    else
      dispatch(failAction)
    end
  end)
end

return Actions