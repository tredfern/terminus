-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local tables = require "moonpie.tables"
local class = require "moonpie.class"
local tileMap = {}

function tileMap:constructor()
  self.width = 0
  self.height = 0
end

function tileMap:createTile(x, y)
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

function tileMap:updateTile(x, y, values)
  local t = self:getTile(x, y) or self:createTile(x, y)
  tables.copyKeys(values, t, true)
end

function tileMap:getTile(x, y)
  if self[x] == nil then return nil end
  return self[x][y]
end

function tileMap:getNeighbors(x, y)
  local out = {
    nw = self:getTile(x-1, y-1),
    n = self:getTile(x, y-1),
    ne = self:getTile(x+1, y-1),
    w = self:getTile(x-1, y),
    e = self:getTile(x+1, y),
    sw = self:getTile(x-1, y+1),
    s = self:getTile(x, y+1),
    se = self:getTile(x+1, y+1)
  }

  return out
end


return class(tileMap)