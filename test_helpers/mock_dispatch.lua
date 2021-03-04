-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

local mockDispatch = setmetatable({

  dispatched = {},
  processComplex = false,
  received_action = function(self, action)
    if action == nil then
      print("searching for nil action in mock dispatch")
    end
    return tables.any(self.dispatched, function(d) return d.type == action end)
  end,
  reset = function(self)
    self.dispatched = {}
    self.processComplex = false
  end
}, {
  __call = function(self, action)
    if type(action) == "function" then
      if self.processComplex then
        local store = require "moonpie.redux.store"
        action(self, store.getState)
      end
      return
    end
    self.dispatched[#self.dispatched + 1] = action
  end
})

mockDispatch.asFunction = function(...)
  return mockDispatch(...)
end


return mockDispatch