-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local factory = require "game.rules.character.factory"


return {
  actions = require "game.rules.character.actions",
  attributes = require "game.rules.character.attributes",
  create = factory.newCharacter,
  reducer = require "game.rules.character.reducer",
  selectors = require "game.rules.character.selectors"
}