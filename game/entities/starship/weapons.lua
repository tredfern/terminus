-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local base = moonpie.class({})

function base:constructor(props)
  self.name = props.name
end

local weapons = {}

function weapons.register(key, props)
  weapons[key] = function()
    return base:new(props)
  end
end

return weapons