-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local panel = require "game.ui.widgets.panel"
local tables = require "moonpie.tables"

return components("story_popup", function(props)
  return {
    story = props.story,
    panel {
      title = props.story.title,
      style = "panel_red",
      contents = {
        components.text { id = "story_content", text = props.story.description },
        {
          tables.map(props.story.choices, function(c, i)
            return components.button { id = "choice_" .. tostring(i), caption = c.title, click = function()
                c:handler(props.story)
              end
            }
          end)
        }
      }
    },
  }
end)