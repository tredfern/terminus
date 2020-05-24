-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local store = require "moonpie.redux.store"
local empty_reducer = spy.new(function() end)


return {
  new_game = function()
    store.create_store(empty_reducer, {
      spaceports = {
        { name = "Alpha" },
        { name = "Bravo" }
      },
      location = { name = "Bravo" }
    })
  end
}