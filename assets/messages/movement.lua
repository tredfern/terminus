-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Helper = require "game.rules.message_log.helper"
local alert = Helper.alert

return {
  door = {
    locked = string.format("The door is %s!", alert("locked")),
    unlocked = string.format("You %s the door with your keycard.", alert("unlocked"))
  }
}