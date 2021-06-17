-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local assert = require("luassert")
local say = require("say")
local tables = require "moonpie.tables"
local isCallable = require "moonpie.utility.is_callable"
-- local store = require "moonpie.redux.store"

local function createDispatcher()
  return setmetatable({
    dispatched = {}
  }, {
    __call = function(self, action)
      self.dispatched[#self.dispatched + 1] = action
    end }
  )
end

local function thunk_dispatches(_, arguments)
  local store = require "moonpie.redux.store"
  local expectedAction = arguments[1]
  local thunk = arguments[2]

  local dispatcher = createDispatcher()
  thunk(dispatcher, store.getState)

  return tables.any(dispatcher.dispatched, function(d)
    if isCallable(expectedAction) then
      return expectedAction(d)
    else
      return tables.deepCompare(d, expectedAction)
    end
  end)
end

local function thunk_dispatches_type(_, arguments)
  local store = require "moonpie.redux.store"
  local expectedType = arguments[1]
  local expectedCount = arguments[3]
  local thunk = arguments[2]

  local dispatcher = createDispatcher()
  thunk(dispatcher, store.getState)

  if expectedCount == nil then
    return tables.any(dispatcher.dispatched, function(d)
      if type(d) == "table" then
        return d.type == expectedType
      end
    end)
  end

  return tables.count(dispatcher.dispatched, function(d)
    if type(d) == "table" then
      return d.type == expectedType
    end
  end) == expectedCount
end

say:set("assertion.thunk_dispatches.positive", "Expected action %s to be dispatched from Thunk(%s)")
say:set("assertion.thunk_dispatches.negative", "Expected action %s to not be dispatched from Thunk(%s)")
assert:register("assertion", "thunk_dispatches", thunk_dispatches,
  "assertion.thunk_dispatches.positive", "assertion.thunk_dispatches.negative")

say:set("assertion.thunk_dispatches_type.positive", "Expected action type %s to be dispatched from Thunk(%s)")
say:set("assertion.thunk_dispatches_type.negative", "Expected action type %s to not be dispatched from Thunk(%s)")
assert:register("assertion", "thunk_dispatches_type", thunk_dispatches_type,
  "assertion.thunk_dispatches_type.positive", "assertion.thunk_dispatches_type.negative")