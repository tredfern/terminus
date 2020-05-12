-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local app = {}
app.assets = require "assets"
app.rules = require "game.rules"
app.state = require "game.state"
require "game.ui"

local function arrive_in_port(sp)
  for _, v in ipairs(app.assets.trade_goods) do
    sp:set_price(v, v.baseprice)
  end
end

function app.load()
  arrive_in_port(app.state.spaceports[1])
  app.render(moonpie.ui.components.main_layout{ spaceport = app.state.spaceports[1],
    player = app.state.player,
    destinations = app.state.spaceports
  })
end

function app.render(scene)
  moonpie.render(
    "ui",
    moonpie.ui.components.body(scene)
  )
end

app.rules.new_game(app.state)

return app