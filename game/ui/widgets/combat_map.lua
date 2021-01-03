-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local colors = require "moonpie.graphics.colors"
local connect = require "moonpie.redux.connect"
local character = require "game.rules.character"

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


local combat_map = components("combat_map", function(props)
  return {
    characters = props.characters,
    draw_component = function(self)
      for x = 1,8 do
        for y = 1, 8 do
          draw_tile(x, y)
        end
      end

      for _, v in ipairs(self.characters) do
        draw_character(v.x, v.y, v.is_enemy)
      end
    end
  }
end)

return connect(combat_map, function(state) return { characters = character.selectors.get_all_characters(state) } end)