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
  self.levels = 0
end

function tileMap:createTile(position)
  local x, y, z = position.x, position.y, position.z
  if self[x] == nil then
    self[x] = {}
  end
  if self[x][y] == nil then
    self[x][y] = {}
  end
  if self[x][y][z] == nil then
    self[x][y][z] = {}
  end

  self[x][y][z] = {
    position = position
  }

  self.width = math.max(x, self.width)
  self.height = math.max(y, self.height)
  self.levels = math.max(z, self.levels)

  return self[x][y][z]
end

function tileMap:updateTile(position, values)
  local t = self:getTile(position) or self:createTile(position)
  tables.copyKeys(values, t, true)
end

function tileMap:getTile(position)
  if self[position.x] == nil then return nil end
  if self[position.x][position.y] == nil then return nil end
  return self[position.x][position.y][position.z]
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
    se = self:getTile(Position.southeast(position)),
    up = self:getTile(Position.up(position)),
    down = self:getTile(Position.down(position))
  }

  return out
end


return class(tileMap)