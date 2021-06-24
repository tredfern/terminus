-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ImageManager = require "game.rules.graphics.image_manager"
local Settings = require "game.settings"
local Animation = require "game.rules.graphics.animation"
local Orientation = require "game.rules.world.orientation"

local filename = Settings.assetPath("maps/features/doors.png")
local closed = ImageManager.load("DOOR_CLOSED_NS", filename, { 0, 0, 32, 32 })
local opening1 = ImageManager.load("DOOR_OPENING_NS_1", filename, { 32, 0, 32, 32 })
local opening2 = ImageManager.load("DOOR_OPENING_NS_2", filename, { 0, 32, 32, 32 })
local opened = ImageManager.load("DOOR_OPENED_NS", filename, { 32, 32, 32, 32 })

local opening = Animation:new()
opening:addFrame(opening1, 0.2)
opening:addFrame(opening2, 0.2)
opening:addFrame(opened, 0.2)

local closedEW = ImageManager.load("DOOR_CLOSED_EW", filename, { 64, 0, 32, 32 })
local openingEW1 = ImageManager.load("DOOR_OPENING_EW_1", filename, { 96, 0, 32, 32 })
local openingEW2 = ImageManager.load("DOOR_OPENING_EW_2", filename, { 64, 32, 32, 32 })
local openedEW = ImageManager.load("DOOR_OPENED_EW", filename, { 96, 32, 32, 32 })

local openingEW = Animation:new()
openingEW:addFrame(openingEW1, 0.2)
openingEW:addFrame(openingEW2, 0.2)
openingEW:addFrame(openedEW, 0.2)

return {
  [Orientation.northSouth] = {
    closed = closed,
    opening = opening,
    opened = opened
  },
  [Orientation.eastWest] = {
    closed = closedEW,
    opening = openingEW,
    opened = openedEW
  }
}