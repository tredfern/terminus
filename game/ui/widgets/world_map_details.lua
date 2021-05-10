-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local connect = require "moonpie.redux.connect"
local store = require "game.store"
local FogOfWar = require "game.rules.fog_of_war"
local Map = require "game.rules.map"
local Position = require "game.rules.world.position"
local Colors = require "moonpie.graphics.colors"
local Keyboard = require "moonpie.keyboard"
local Player = require "game.rules.player"

local WorldMapDetails = Components("world_map_details", function(props)
  return {
    id = "world_map_details",
    height = "100%",
    currentLevel = props.player.position.z,
    player = props.player,
    mapSize = props.mapSize,

    drawComponent = function(self)
      local state = store.getState()
      local tileWidth = math.floor(self.box.width / self.mapSize.width)
      local tileHeight = math.floor(self.box.height / self.mapSize.height)

      for x = 1, self.mapSize.width do
        for y = 1, self.mapSize.height do
          local p = Position(x, y, self.currentLevel)
          local t = Map.selectors.getTile(state, p)
          if FogOfWar.selectors.get(state, self.player, p) and t then
            if t.terrain.key == "wall" then
              love.graphics.setColor(Colors(Colors.gray))
              love.graphics.rectangle("fill", (x - 1) * tileWidth, (y - 1) * tileHeight, tileWidth, tileHeight)
            elseif t.terrain.key == "room" then
              love.graphics.setColor(Colors(Colors.light_accent))
              love.graphics.rectangle("fill", (x - 1) * tileWidth, (y - 1) * tileHeight, tileWidth, tileHeight)
            elseif t.terrain.key == "corridor" then
              love.graphics.setColor(Colors(Colors.light_shade))
              love.graphics.rectangle("fill", (x - 1) * tileWidth, (y - 1) * tileHeight, tileWidth, tileHeight)
            end
          end
        end
      end
    end,

    mounted = function(self)
      Keyboard:hotkey(",", function()
        if self.currentLevel > 1 then
          self.component:update { currentLevel = self.currentLevel - 1 }
        end
      end)

      Keyboard:hotkey(".", function()
        if self.currentLevel < self.mapSize.levels then
          self.component:update { currentLevel = self.currentLevel + 1 }
        end
      end)
    end,
    unmounted = function()
      Keyboard:hotkey(",", nil)
      Keyboard:hotkey(".", nil)
    end

  }
end)


return connect(
  WorldMapDetails,
  function(state)
    return {
      mapSize = Map.selectors.getDimensions(state),
      player = Player.selectors.getPlayer(state)
    }
  end
)