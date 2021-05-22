-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}
Actions.types = require "game.rules.stats.types"


function Actions.count(inc, stat)
  return {
    type = Actions.types.COUNT,
    payload = {
      count = inc,
      stat = stat
    }
  }
end

function Actions.set(val, stat)
  return {
    type = Actions.types.SET,
    payload = {
      value = val,
      stat = stat
    }
  }
end

return Actions