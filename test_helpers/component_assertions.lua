-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local assert = require("luassert")
local say = require("say")
local tables = require "moonpie.tables"
local isCallable = require "moonpie.utility.is_callable"

local function createDispatcher()
  return setmetatable({
    dispatched = {}
  }, {
    __call = function(self, action)
      self.dispatched[#self.dispatched + 1] = action
    end }
  )
end

local function component_dispatches(_, args)
  local store = require "moonpie.redux.store"
  local expectedAction = args[1]
  local testRoutine = args[2]

  local oldDispatch = store.dispatch
  store.dispatch = createDispatcher()

  testRoutine()

  local check = tables.any(store.dispatch.dispatched, function(d)
    if isCallable(expectedAction) then
      return expectedAction(d)
    else
      return tables.deepCompare(d, expectedAction)
    end
  end)

  store.dispatch = oldDispatch
  return check

end

say:set("assertion.component_dispatches.positive", "Expected action type %s to be dispatched from Component (%s)")
say:set("assertion.component_dispatches.negative", "Expected action type %s to not be dispatched from Component (%s)")
assert:register("assertion", "component_dispatches", component_dispatches,
  "assertion.component_dispatches.positive", "assertion.component_dispatches.negative")