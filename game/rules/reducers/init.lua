-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local combine_reducers = require "moonpie.redux.combine_reducers"

return combine_reducers{
  characters = require "game.rules.character.reducer"
}