-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Colors = require "game.rules.graphics.colors"
local Template = require "moonpie.utility.template"
local splitString = "{color:%w+}"
local getColor = "{color:(%w+)}"

return function(text, props)
  text = Template(text, props or {})
  local fields = {}
  local i, j = string.find(text, splitString)

  if i then
    if i > 1 then
      table.insert(fields, "{color:text}")
      table.insert(fields, string.sub(text, 1, i - 1))
    end

    local lastIndex
    while i do
      table.insert(fields, string.sub(text, i, j))
      lastIndex = j + 1
      i, j = string.find(text, splitString, i + 1)

      if i == nil and lastIndex < string.len(text) then
        table.insert(fields, string.sub(text, lastIndex))
      elseif i then
        table.insert(fields, string.sub(text, lastIndex, i - 1))
      end
    end
  else
    -- No color specified
    table.insert(fields, "{color:text}")
    table.insert(fields, text)
  end

  for index, v in ipairs(fields) do
    local color = string.match(v, getColor)
    if color then
      fields[index] = Colors(Colors[color])
    end
  end

  return fields
end