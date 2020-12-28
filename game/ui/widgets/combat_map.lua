-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local colors = require "moonpie.graphics.colors"
local character = require "game.entities.character"
local c = character()

local tile_width = 32
local tile_height = 32

local function draw_tile(x, y)
  love.graphics.setColor(colors.light_gray)
  love.graphics.rectangle("fill", x * tile_width, y*tile_height, tile_width, tile_height)
  love.graphics.setColor(colors.dark_gray)
  love.graphics.rectangle("line", x * tile_width, y*tile_height, tile_width, tile_height)
end

local function draw_character(x, y, is_enemy)
  if is_enemy then
    love.graphics.setColor(colors.red)
  else
    love.graphics.setColor(colors.green)
  end
  love.graphics.rectangle("fill", x * tile_width + 3, y * tile_height + 3, 26, 26)
end

local keyboard = require "moonpie.keyboard"
keyboard:hotkey("up", function()
  c:set_position(c.x, c.y - 1)
end)
keyboard:hotkey("down", function()
  c:set_position(c.x, c.y + 1)
end)
keyboard:hotkey("right", function()
  c:set_position(c.x + 1, c.y)
end)
keyboard:hotkey("left", function()
  c:set_position(c.x - 1, c.y)
end)


local enemies = {}
for i=1,4 do
  enemies[#enemies + 1] = character:new { is_enemy = true, x = math.random(10), y = math.random(10) }
end


return components("combat_map", function()
  return {
    draw_component = function()
      for x = 1,8 do
        for y = 1, 8 do
          draw_tile(x, y)
        end
      end

      draw_character(c.x, c.y)

      for i = 1, #enemies do
        draw_character(enemies[i].x, enemies[i].y, true)
      end
    end
  }
end)