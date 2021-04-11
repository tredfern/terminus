-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.map.actions.types"

return function(outline, tileMap)
  return {
    type = types.ADD,
    payload = {
      outline = outline,
      tileMap = tileMap
    }
  }
end