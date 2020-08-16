-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local tables = require "moonpie.tables"

return components("container", function(props)
  return {
    tables.indexed(props)
  }
end)