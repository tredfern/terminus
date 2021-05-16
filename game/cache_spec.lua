-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.cache", function()
  local Cache = require "game.cache"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local store

  before_each(function()
    Cache.clear()
    Cache.enabled()
    store = mockStore { }
  end)

  after_each(function()
    Cache.disabled()
  end)

  it("calls the routine to resolve the cache state if new", function()
    local cb = spy.new(function() return {} end)
    Cache {
      name = "CACHE_1",
      source = cb,
    }

    assert.spy(cb).was.called()
  end)

  it("returns previous results if called a second time", function()
    local results = {}
    local cb = spy.new(function() return results end)
    local out1 = Cache { name = "CACHE_ME", source = cb }
    local out2 = Cache { name = "CACHE_ME", source = cb }
    local out3 = Cache { name = "CACHE_ME", source = cb }

    assert.equals(results, out1)
    assert.equals(results, out2)
    assert.equals(results, out3)
    assert.spy(cb).was.called(1)
  end)

  it("flushes out when actions are dispatched", function()
    local results = {}
    local cb = spy.new(function() return results end)
    local request = {
      name = "FLUSH_ME",
      source = cb,
      flushOn = { "ACTION_A", "ACTION_B", "ACTION_C" }
    }
    Cache(request)
    Cache(request)
    Cache(request)
    assert.spy(cb).was.called(1)
    store.dispatch { type = "ACTION_B" }
    Cache(request)
    Cache(request)
    Cache(request)
    assert.spy(cb).was.called(2)
    store.dispatch { type = "ACTION_C" }
    Cache(request)
    Cache(request)
    Cache(request)
    assert.spy(cb).was.called(3)
  end)

  it("can be disabled for testing purposes", function()
    Cache.disabled()
    local cb = spy.new(function() end)
    Cache { name = "CACHE_ME", source = cb }
    Cache { name = "CACHE_ME", source = cb }
    Cache { name = "CACHE_ME", source = cb }
    assert.spy(cb).was.called(3)
  end)
end)