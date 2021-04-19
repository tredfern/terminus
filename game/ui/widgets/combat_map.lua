-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local colors = require "moonpie.graphics.colors"
local connect = require "moonpie.redux.connect"
local camera = require "game.ui.camera"
local store = require "moonpie.redux.store"
local Settings = require "game.settings"
local Items = require "game.rules.items"
local Graphics = require "game.rules.graphics"

local tile_width = 32
local tile_height = 32

local function getScreenCoordinate(cam, x, y)
  return
    (x - cam.x) * tile_width,
    (y - cam.y) * tile_height
end

local function drawGrid(tilesWide, tilesHigh)
  love.graphics.setLineWidth(1)
  love.graphics.setColor(colors(colors.grid_lines))
  for x = 1, tilesWide do
    love.graphics.line(x * tile_width, 1, x * tile_width, tilesHigh * tile_height)
  end

  for y = 1, tilesHigh do
    love.graphics.line(1, y * tile_height, tilesWide * tile_width, y * tile_height)
  end
end

local combat_map = components("combat_map", function(props)
  return {
    camera = props.camera,
    drawableEntities = props.drawableEntities,
    map = props.map,
    showGrid = props.showGrid,

    afterLayout = function(self)
      -- Set Camera Dimensions
      self.tilesWide = math.ceil(self.box.width / tile_width)
      self.tilesHigh = math.ceil(self.box.height / tile_height)

      -- Disabling triggers prevents redundant events from triggering
      store.dispatch(camera.actions.setDimensions(self.tilesWide, self.tilesHigh), true)
      store.dispatch(camera.actions.centerOnPlayer(self.tilesWide, self.tilesHigh), true)
    end,

    drawComponent = function(self)

      -- Draw Map Tiles
      for x = 1, self.map.outline.width do
        for y = 1, self.map.outline.height do
          local tile = self.map.tileMap:getTile(x, y)
          if tile and tile.sprite then
            local sx, sy = getScreenCoordinate(self.camera, x, y)
            tile.sprite:draw(sx, sy)
          end
        end
      end

      -- Draw entities
      for _, v in ipairs(self.drawableEntities) do
        local sx, sy = getScreenCoordinate(self.camera, v.position.x, v.position.y)
        v.sprite:draw(sx, sy)
      end

      if self.showGrid then
        drawGrid(self.tilesWide, self.tilesHigh)
      end
    end
  }
end)

return connect(combat_map,
  function(state)
    return {
      camera = camera.selectors.get(state),
      drawableEntities = Graphics.selectors.getDrawable(state),
      map = state.map,
      items = Items.selectors.getAll(state),
      showGrid = Settings.selectors.getOption(state, "show_grid_lines")
  }
  end
)