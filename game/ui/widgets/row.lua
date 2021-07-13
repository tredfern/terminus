-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"


return Components("row", function(props)
  local r = {
    columns = props.columns
  }

  for i, v in ipairs(props) do
    if v.columnWidth then
      v.width = string.format("%d%%", math.floor((v.columnWidth / props.columns) * 100))
    end
    r[i] = v
  end

  return r
end)