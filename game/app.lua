-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local app = {}
app.assets = require "assets"
require "game.ui"

function app.load()
  local spaceport = require "game.entities.spaceport"
  local sp = spaceport:new{ name = "Spaceport Alpha" }

  print(#app.assets.trade_goods)
  for _, v in ipairs(app.assets.trade_goods) do
    sp:set_price(v.name, v.baseprice)
  end
  app.render(moonpie.ui.components.main_layout{ spaceport = sp })
end

function app.render(scene)
  moonpie.render(
    "ui",
    moonpie.ui.components.body(scene)
  )
end

return app