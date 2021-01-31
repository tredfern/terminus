-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local colors = require "moonpie.graphics.colors"
local connect = require "moonpie.redux.connect"
local character = require "game.rules.character"
local camera = require "game.rules.camera"
local store = require "moonpie.redux.store"

local tile_width = 32
local tile_height = 32

local function draw_tile(x, y, color)
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", x * tile_width, y*tile_height, tile_width, tile_height)
  love.graphics.setColor(colors(colors.dark_accent))
  love.graphics.rectangle("line", x * tile_width, y*tile_height, tile_width, tile_height)
end

local function draw_character(x, y, is_enemy)
  if is_enemy then
    love.graphics.setColor(colors.danger)
  else
    love.graphics.setColor(colors.success)
  end
  love.graphics.rectangle("fill", x * tile_width + 3, y * tile_height + 3, 26, 26)
end


local combat_map = components("combat_map", function(props)
  return {
    camera = props.camera,
    characters = props.characters,
    map = props.map,

    afterLayout = function(self)
      -- Set Camera Dimensions
      local tilesWide = self.box.width / tile_width
      local tilesHigh = self.box.height / tile_height

      -- Disabling triggers prevents redundant events from triggering
      store.dispatch(camera.actions.setDimensions(tilesWide, tilesHigh), true)
      store.dispatch(camera.actions.centerOnPlayer(tilesWide, tilesHigh), true)
    end,

    drawComponent = function(self)

      for x = 1, self.map.width do
        for y = 1, self.map.height do
          draw_tile(
            x - self.camera.x,
            y - self.camera.y,
            self.map:get_terrain(x, y).color)
        end
      end

      for _, v in ipairs(self.characters) do
        draw_character(
          v.x - self.camera.x,
          v.y - self.camera.y,
          v.is_enemy)
      end
    end
  }
end)

return connect(combat_map,
  function(state)
    return {
      camera = camera.selectors.get(state),
      characters = character.selectors.getAll(state),
      map = state.map
  }
  end
)