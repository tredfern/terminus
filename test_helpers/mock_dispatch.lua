-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local isCallable = require "moonpie.utility.is_callable"

local mockDispatch = setmetatable({

  dispatched = {},
  processComplex = false,
  received_action = function(self, action, count)
    if action == nil then
      print("searching for nil action in mock dispatch")
    end
    if count then
      local list = tables.select(self.dispatched, function(d) return d.type == action end)
      return list and count == #list
    else
      return tables.any(self.dispatched, function(d) return d.type == action end)
    end
  end,
  reset = function(self)
    self.dispatched = {}
    self.processComplex = false
  end
}, {
  __call = function(self, action)
    if isCallable(action) then
      if self.processComplex then
        local store = require "moonpie.redux.store"
        action(self, store.getState)
      end
    end

    if type(action) == "table" then
      self.dispatched[#self.dispatched + 1] = action
    end
  end
})

mockDispatch.asFunction = function(...)
  return mockDispatch(...)
end


return mockDispatch