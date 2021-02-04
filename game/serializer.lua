-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Serializer = {}
local binser = require "binser"

function Serializer.serialize(data)
  return binser.serialize(data)
end

function Serializer.deserialize(data)
  return binser.deserialize(data)
end

function Serializer.save(file, data)
  local out = Serializer.serialize(data)
  love.filesystem.write(file, out)
end

function Serializer.load(file)
  local fileData = love.filesystem.read(file)
  local data = Serializer.deserialize(fileData)
  return data[1]
end

return Serializer