-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local message_log = require "game.rules.message_log"
local tables = require "moonpie.tables"

local message_log_widget = components("message_log", function(props)
  return {
    messages = props.messages,
    render = function(self)
      return tables.map(self.messages, function(msg)
        return {
          components.text { text = msg.message }
        }
      end)
    end
  }
end)


return connect(message_log_widget, function(state)
  return {
    messages = message_log.selectors.get_last(state, 5),
  }
end)