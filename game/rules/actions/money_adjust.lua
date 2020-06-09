-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
return function(amount)
  return {
    type = types.money_adjust,
    payload = {
      amount = amount
    }
  }
end