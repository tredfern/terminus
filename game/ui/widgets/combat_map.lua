-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local colors = require "moonpie.graphics.colors"
local connect = require "moonpie.redux.connect"
local character = require "game.rules.character"
local camera = require "game.ui.camera"
local store = require "moonpie.redux.store"
local Settings = require "game.settings"
local Map = require "game.rules.map"
local Image = require "moonpie.graphics.image"
local Items = require "game.rules.items"

local tile_width = 32
local tile_height = 32
local floorTiles = {
  Image.load("assets/graphics/floor-1.png"),
  Image.load("assets/graphics/floor-2.png")
}

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
}

local function drawWall(map, x, y, dx, dy)
  -- get neighbors that are corridor or rooms
  local neighbors = map:getNeighbors(x, y)
  local sx = dx * tile_width
  local sy = dy * tile_height

  love.graphics.setColor(colors.white)
  -- depending on that orientation, figure out the 4 quadrants of the wall to render
  -- Northwest corner
  if not neighbors.n.blocksMovement and not neighbors.w.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.northandwest, sx, sy)
  elseif not neighbors.n.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.north, sx, sy)
  elseif not neighbors.w.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.west, sx, sy)
  elseif not neighbors.nw.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.northwest, sx, sy)
  end

  -- Northeast corner
  if not neighbors.n.blocksMovement and not neighbors.e.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.northandeast, sx + 16, sy)
  elseif not neighbors.n.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.north, sx + 16, sy)
  elseif not neighbors.e.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.east, sx + 16, sy)
  elseif not neighbors.ne.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.northeast, sx + 16, sy)
  end

  -- South west corner
  if not neighbors.s.blocksMovement and not neighbors.w.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.southandwest, sx, sy + 16)
  elseif not neighbors.s.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.south, sx, sy + 16)
  elseif not neighbors.w.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.west, sx, sy + 16)
  elseif not neighbors.sw.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.southwest, sx, sy + 16)
  end

  -- southeast corner
  if not neighbors.s.blocksMovement and not neighbors.e.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.southandeast, sx + 16, sy + 16)
  elseif not neighbors.s.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.south, sx + 16, sy + 16)
  elseif not neighbors.e.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.east, sx + 16, sy + 16)
  elseif not neighbors.se.blocksMovement then
    love.graphics.draw(wallImage, wallQuads.southeast, sx + 16, sy + 16)
  end
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

local function draw_character(x, y)
  local characterImage = Image.load("assets/graphics/simple-character-1.png")
  love.graphics.setColor(colors.white)
  love.graphics.draw(characterImage, x * tile_width, y * tile_height)
end

local function draw_enemy(x, y)
  local alien = Image.load("assets/graphics/alien_1.png")
  love.graphics.draw(alien, x * tile_width, y * tile_height)
end

local function drawSpawner(x, y)
  love.graphics.setColor(colors.warning)
  love.graphics.rectangle("fill", x * tile_width + 3, y * tile_height + 3, 26, 26)
end

local function drawItem(item, x, y)
  if item.image then
    love.graphics.setColor(colors.white)
    love.graphics.draw(item.image, x * tile_width, y * tile_height)
  else
    love.graphics.setColor(colors(colors.main))
    love.graphics.rectangle("fill", x * tile_width + 3, y * tile_height + 3, 26, 26)
  end
end


local combat_map = components("combat_map", function(props)
  return {
    camera = props.camera,
    characters = props.characters,
    enemySpawners = props.enemySpawners,
    map = props.map,
    items = props.items,
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
      for x = 1, self.map.width do
        for y = 1, self.map.height do
          local terrain = self.map:getTerrain(x, y)
          if not terrain.noImage then
            if terrain.type == "wall" then
              drawWall(self.map, x, y, x - self.camera.x, y - self.camera.y)
            else
              draw_tile(
                x - self.camera.x,
                y - self.camera.y,
                terrain.color)
            end
          end
        end
      end

      for _, v in ipairs(self.enemySpawners) do
        drawSpawner(v.x - self.camera.x, v.y - self.camera.y)
      end

      for _, v in ipairs(self.items) do
        drawItem(v, v.x - self.camera.x, v.y - self.camera.y)
      end

      for _, v in ipairs(self.characters) do
        if v.isEnemy then
          draw_enemy(v.x - self.camera.x, v.y - self.camera.y)
        else
          draw_character(v.x - self.camera.x, v.y - self.camera.y, v.isEnemy)
        end
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
      characters = character.selectors.getAll(state),
      enemySpawners = Map.selectors.getEnemySpawners(state),
      map = state.map,
      items = Items.selectors.getAll(state),
      showGrid = Settings.selectors.getOption(state, "show_grid_lines")
  }
  end
)