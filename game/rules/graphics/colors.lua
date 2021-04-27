-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "moonpie.graphics.colors"

colors.drawDefault = {1, 1, 1, 1}
colors.lowHealth = colors.danger


-- Message colors
colors.messageText = colors.text
colors.messageDamage = colors.danger
colors.messageHighlight = colors.main

return colors