-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Serializer = {}
local binser = require "binser"

function Serializer.save(file, data)
  local out = binser.serialize(data)
  love.filesystem.write(file, out)
end


return Serializer