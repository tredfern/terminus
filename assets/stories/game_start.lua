-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local story = require "game.entities.story"

return story:new {
  title = "Is this the end?",
  description = [[
Alarms ring out after the explosion ripped through the command deck taking out the captain.
As Number 1, it's up to you to take her place and save the ship from the marauder attacking you.
  ]],
  choices = {
    { title = "OK!", event = function() end }
  }
}