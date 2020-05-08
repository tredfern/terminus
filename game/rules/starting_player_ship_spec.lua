-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.starting_player_ship", function()
  local app = require "game.app"
  local starting_player_ship = require "game.rules.starting_player_ship"

  it("creates a player ship", function()
    starting_player_ship(app)
    assert.not_nil(app.player)
  end)

  it("gives a basic cargo hold", function()
    starting_player_ship(app)
    assert.not_nil(app.player.cargo_hold)
    assert.equals(15, app.player.cargo_hold.size)
  end)
end)