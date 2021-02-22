-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Terrain = require "game.rules.map.terrain"
local colors = require "moonpie.graphics.colors"

Terrain.describe { key = "corridor", color = colors(colors.light_accent) }
Terrain.describe { key = "room", color = colors.white }
Terrain.describe { key = "wall", color = colors.white, blocksMovement = true, type = "wall" }