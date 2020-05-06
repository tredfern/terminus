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

  sp:set_price("item a", 28)
  sp:set_price("item b", 35)
  sp:set_price("item c", 43)
  app.render(moonpie.ui.components.main_layout{ spaceport = sp })
end

function app.render(scene)
  moonpie.render(
    "ui",
    moonpie.ui.components.body(scene)
  )
end

return app