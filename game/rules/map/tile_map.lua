-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local tables = require "moonpie.tables"
local class = require "moonpie.class"
local Position = require "game.rules.world.position"
local tileMap = {}

function tileMap:constructor()
  self.width = 0
  self.height = 0
end

function tileMap:createTile(position)
  local x, y = position.x, position.y
  if self[x] == nil then
    self[x] = {}
  end
  if self[x][y] == nil then
    self[x][y] = {}
  end

  self[x][y] = {
    x = x, y = y
  }

  self.width = math.max(x, self.width)
  self.height = math.max(y, self.height)

  return self[x][y]
end

function tileMap:updateTile(position, values)
  local t = self:getTile(position) or self:createTile(position)
  tables.copyKeys(values, t, true)
end

function tileMap:getTile(position)
  if self[position.x] == nil then return nil end
  return self[position.x][position.y]
end

function tileMap:getNeighbors(position)
  local out = {
    nw = self:getTile(Position.northwest(position)),
    n = self:getTile(Position.north(position)),
    ne = self:getTile(Position.northeast(position)),
    w = self:getTile(Position.west(position)),
    e = self:getTile(Position.east(position)),
    sw = self:getTile(Position.southwest(position)),
    s = self:getTile(Position.south(position)),
    se = self:getTile(Position.southeast(position))
  }

  return out
end


return class(tileMap)