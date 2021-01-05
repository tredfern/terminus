-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

return setmetatable({
  dispatched = {},
  received_action = function(self, action)
    return tables.any(self.dispatched, function(d) return d.type == action end)
  end
}, {
  __call = function(self, action)
    self.dispatched[#self.dispatched + 1] = action
  end
})