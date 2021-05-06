-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local Cache = {}

local flushCallbacks = {}
local results = {}

function Cache.lookup(cacheDef)
  local name = cacheDef.name

  if flushCallbacks[name] == nil then
    Cache.addFlushCallbacks(cacheDef)
  end

  if results[name] == nil then
    results[name] = cacheDef.source()
  end
  return results[name]
end

function Cache.clear()
  flushCallbacks = {}
  results = {}
end

function Cache.addFlushCallbacks(cacheDef)
  if cacheDef.flushOn == nil then return end

  local flushes = {}

  for _, v in ipairs(cacheDef.flushOn) do
    local cb = function() results[cacheDef.name] = nil end
    table.insert(flushes, cb)
    store.subscribeTo(v, cb)
  end

  flushCallbacks[cacheDef.name] = flushes
end

return setmetatable(Cache, {
  __call = function(self, cacheDef)
    return self.lookup(cacheDef)
  end
})