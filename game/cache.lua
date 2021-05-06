-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local tables = require "moonpie.tables"
local unpack = require "moonpie.utility.unpack"
local Cache = {}

local cacheIds = {}
local results = {}

function Cache.getCacheID(cacheDef)
  local _, id = tables.findFirst(
    cacheIds,
    function(cd)
      return cd.source == cacheDef.source and
        tables.same(cd.parameters, cacheDef.parameters)
    end
  )

  if id == nil then
    cacheIds[#cacheIds + 1] = {
      source = cacheDef.source,
      parameters = cacheDef.parameters
    }
    id = #cacheIds
    Cache.addFlushCallbacks(id, cacheDef.flushOn)
  end

  return id
end

function Cache.lookup(cacheDef)
  local id = Cache.getCacheID(cacheDef)

  if results[id] == nil then
    local parameters = cacheDef.parameters or {}
    results[id] = cacheDef.source(cacheDef.state, unpack(parameters))
  end
  return results[id]
end

function Cache.clear()
  cacheIds = {}
  results = {}
end

function Cache.addFlushCallbacks(id, actions)
  if actions == nil then return end
  for _, v in ipairs(actions) do
    store.subscribeTo(v, function() results[id] = nil end)
  end
end

return setmetatable(Cache, {
  __call = function(self, cacheDef)
    return self.lookup(cacheDef)
  end
})