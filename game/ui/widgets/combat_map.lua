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

local tile_width = 32
local tile_height = 32

local function draw_tile(x, y, color)
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", x * tile_width, y*tile_height, tile_width, tile_height)
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

local function draw_character(x, y, isEnemy)
  if isEnemy then
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
          draw_tile(
            x - self.camera.x,
            y - self.camera.y,
            self.map:getTerrain(x, y).color)
        end
      end

      for _, v in ipairs(self.characters) do
        draw_character(
          v.x - self.camera.x,
          v.y - self.camera.y,
          v.isEnemy)
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
      map = state.map,
      showGrid = Settings.selectors.getOption(state, "show_grid_lines")
  }
  end
)