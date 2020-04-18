-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function get_id(row, col)
  return string.format("term_%d_%d", row, col)
end

local function create_text_grid(rows, cols)
  local out = { style = "terminal_grid", height = "100%" }
  local width = string.format("%f%%", 100/cols)
  local height = string.format("%f%%", 100/rows)
  for i = 1,rows do
    out[i] = { height = height, id = "terminal_row_" .. i }
    for j = 1,cols do
      out[i][j] = moonpie.ui.components.terminal_character{
        id = get_id(i, j),
        text = ".",
        width = width,
      }
    end
  end
  return out
end

moonpie.ui.components("terminal_character", function(props)
  return moonpie.ui.components.text{
    text = props.text
  }
end)

moonpie.ui.components("terminal", function(props)
  assert(props.rows)
  assert(props.cols)

  return {
    create_text_grid(props.rows, props.cols),
    set = function(self, row, col, text)
      local c = self:get(row, col)
      c:update{ text = text }
    end,
    get_row = function(self, row)
      return self:find_by_id("terminal_row_" .. row)
    end,
    get = function(self, row, col)
      return self:find_by_id(get_id(row, col))
    end,
  }
end)