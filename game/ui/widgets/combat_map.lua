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
local Image = require "moonpie.graphics.image"
local Items = require "game.rules.items"
local World = require "game.rules.world"

local tile_width = 32
local tile_height = 32
local floorTiles = {
  Image.load("assets/graphics/floor-1.png"),
  Image.load("assets/graphics/floor-2.png")
}

local function getScreenCoordinate(cam, x, y)
  return
    (x - cam.x) * tile_width,
    (y - cam.y) * tile_height
end

local function draw_tile(x, y, color)
  love.graphics.setColor(color)
  if (x + y) % 3 == 0 then
    love.graphics.draw(floorTiles[1], x * tile_width, y * tile_height)
  else
    love.graphics.draw(floorTiles[2], x * tile_width, y * tile_height)
  end
end

local wallImage = Image.load("assets/graphics/walls-sheet.png")
local wallQuads = {
  north = love.graphics.newQuad(0, 32, 16, 16, wallImage),
  south = love.graphics.newQuad(0, 48, 16, 16, wallImage),
  west = love.graphics.newQuad(0, 0, 16, 16, wallImage),
  east = love.graphics.newQuad(16, 0, 16, 16, wallImage),
  southeast = love.graphics.newQuad(32, 0, 16, 16, wallImage),
  southwest = love.graphics.newQuad(48, 0, 16, 16, wallImage),
  northeast = love.graphics.newQuad(32, 16, 16, 16, wallImage),
  northwest = love.graphics.newQuad(48, 16, 16, 16, wallImage),
  northandwest = love.graphics.newQuad(32, 32, 16, 16, wallImage),
  northandeast = love.graphics.newQuad(48, 32, 16, 16, wallImage),
  southandwest = love.graphics.newQuad(32, 48, 16, 16, wallImage),
  southandeast = love.graphics.newQuad(48, 48, 16, 16, wallImage),
  solid = love.graphics.newQuad(16, 32, 16, 16, wallImage)
}

local function drawWall(dx, dy)
  -- get neighbors that are corridor or rooms
  local sx = dx * tile_width
  local sy = dy * tile_height

  love.graphics.setColor(colors.white)
  love.graphics.draw(wallImage, wallQuads.solid, sx, sy)
  love.graphics.draw(wallImage, wallQuads.solid, sx + 16, sy)
  love.graphics.draw(wallImage, wallQuads.solid, sx, sy + 16)
  love.graphics.draw(wallImage, wallQuads.solid, sx + 16, sy + 16)
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
      for x = 1, self.map.outline.width do
        for y = 1, self.map.outline.height do
          local tile = self.map.tileMap:getTile(x, y)
          if tile then
            local terrain = tile.terrain
            if not terrain.noImage then
              if terrain.type == "wall" then
                drawWall(x - self.camera.x, y - self.camera.y)
              else
                draw_tile(
                  x - self.camera.x,
                  y - self.camera.y,
                  terrain.color)
              end
            end
          end
        end
      end

      for _, v in ipairs(self.drawableEntities) do
        local sx, sy = getScreenCoordinate(self.camera, v.x, v.y)
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
      drawableEntities = World.selectors.getAllWithComponents(state, "x", "y", "sprite"),
      map = state.map,
      items = Items.selectors.getAll(state),
      showGrid = Settings.selectors.getOption(state, "show_grid_lines")
  }
  end
)