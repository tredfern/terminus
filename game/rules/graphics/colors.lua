-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "moonpie.graphics.colors"

colors.drawDefault = {1, 1, 1, 1}
colors.lowHealth = colors.danger


-- Message colors
colors.msgText = colors.text
colors.msgAlert = colors.danger
colors.msgDamage = colors.danger
colors.msgHighlight = colors.main

colors.fow = colors(colors.black, 0.4)
colors.playerBlip = colors(colors.aquamarine)
colors.cursor = colors(colors.orange, 0.6)

return colors