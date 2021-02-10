-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local csv = require "moonpie.ext.csv"
local Names = require "game.rules.character.names"

local function parseCSV(fileName)
  local file = love.filesystem.read(fileName)
  local contents = csv.openstring(file)

  local out = {}
  for fields in contents:lines() do
    for _, v in ipairs(fields) do
      if string.len(v) > 0 then
        out[#out + 1] = v
      end
    end
  end

  return out
end

local femaleFirstNames = parseCSV("data/names/female_first_names.csv")
local maleFirstNames = parseCSV("data/names/male_first_names.csv")
local lastNames = parseCSV("data/names/last_names.csv")

for _, v in ipairs(femaleFirstNames) do
  Names.registerFirstNames(v)
end

for _, v in ipairs(maleFirstNames) do
  Names.registerFirstNames(v)
end

for _, v in ipairs(lastNames) do
  Names.registerLastNames(v)
end
