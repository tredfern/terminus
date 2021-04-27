-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local MessageLog = require "game.rules.message_log"
local tables = require "moonpie.tables"

local richText = components("richText", function(props)
  local layouts = require "moonpie.ui.layouts"
  return {
    text = props.text,
    layout = layouts.text
  }
end)

local message_log_widget = components("message_log", function(props)
  return {
    messages = props.messages,
    render = function(self)
      return tables.map(self.messages, function(msg)
        return {
          richText { text = msg.message }
        }
      end)
    end
  }
end)


return connect(message_log_widget, function(state)
  return {
    messages = MessageLog.selectors.getLast(state, 5),
  }
end)