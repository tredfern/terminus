-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "moonpie.graphics.colors"

local terrain = {
  list = {}
}

function terrain.describe(props)
  terrain.list[props.key] = props
end

terrain.describe {
  key = "blank",
  color = colors.oxford_blue,
  noImage = true,
  blocksMovement = true
}

return terrain