-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Serializer = {}
local binser = require "binser"

function Serializer.registerResources(bin)
  local image = require "moonpie.graphics.image"

  for k, v in pairs(image.store) do
    bin.registerResource(v, k)
  end
end

function Serializer.serialize(data)
  local bin = binser.newbinser()

  Serializer.registerResources(bin)
  return bin.serialize(data)
end

function Serializer.deserialize(data)
  local bin = binser.newbinser()

  Serializer.registerResources(bin)
  return bin.deserialize(data)
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