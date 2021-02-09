-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Names = {}
local list = require "moonpie.collections.list"
local tables = require "moonpie.tables"

Names.firstNames = list:new()
Names.lastNames = list:new()

function Names.registerFirstNames(...)
  Names.firstNames:add(...)
end

function Names.registerLastNames(...)
  Names.lastNames:add(...)
end

function Names.generate()
  if Names.firstNames:isEmpty() or Names.lastNames:isEmpty() then
    return { first = "Anonymous", "Corgi" }
  end
  return {
    first = tables.pickRandom(Names.firstNames),
    last = tables.pickRandom(Names.lastNames)
  }
end

return Names