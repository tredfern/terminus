-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local app = {}
app.assets = require "assets"
require "game.ui"

function app.load()
  app.render(moonpie.ui.components.main_layout())
end

function app.render(scene)
  moonpie.render(
    "ui",
    moonpie.ui.components.body(scene)
  )
end

return app