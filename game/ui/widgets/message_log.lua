-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local tables = require "moonpie.tables"

local message_entry = components("message_entry", function(props)
  return {
    components.text {
      text = props.message,
      id = "message_text_" .. props.entry_number,
    }
  }
end)

local message_log = components("message_log", function(props)
  return {
    id = "message_log",
    message_log = props.message_log,
    render = function(self)
      return tables.map(self.message_log, function(v, k)
        return message_entry{
          message = v.message,
          entry_number = k
        }
      end) or {} -- Kind of a hack job but it prevents errors
    end
  }
end)

return connect(message_log, function(state) return { message_log = state.message_log } end)