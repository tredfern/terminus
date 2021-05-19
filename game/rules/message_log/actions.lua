-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}

Actions.types = require "game.rules.message_log.types"

function Actions.add(message, formatData)
  return {
    type = Actions.types.ADD,
    payload = {
      message = message,
      formatData = formatData
    }
  }
end


return Actions