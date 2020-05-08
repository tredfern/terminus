-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local app = {}
app.assets = require "assets"
app.rules = require "game.rules"
require "game.ui"

local function new_game()
  local spaceport = require "game.entities.spaceport"
  app.spaceports = {
    spaceport:new{ name = "Alpha Station" },
    spaceport:new{ name = "Beta Station" },
    spaceport:new{ name = "Charlie Station" },
    spaceport:new{ name = "Delta Station" },
    spaceport:new{ name = "Echo Station" },
  }

  -- set up markets
  app.rules.starting_player_ship(app)
end

local function arrive_in_port(sp)
  for _, v in ipairs(app.assets.trade_goods) do
    sp:set_price(v.name, v.baseprice)
  end
end

function app.load()
  arrive_in_port(app.spaceports[1])
  app.render(moonpie.ui.components.main_layout{ spaceport = app.spaceports[1], player = app.player })
end

function app.render(scene)
  moonpie.render(
    "ui",
    moonpie.ui.components.body(scene)
  )
end

new_game()

return app