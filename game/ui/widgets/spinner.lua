-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local safeCall = require "moonpie.utility.safe_call"

local Spinner = Components("spinner", function(props)
  local id = props.id or ""
  local spin = {
    value = props.value,
    minimum = props.minimum,
    maximum = props.maximum,
    onIncrease = props.onIncrease,
    onDecrease = props.onDecrease
  }

  spin.render = function(self)
    return {
      display = "inline",
      Components.button {
        style = "spinner-button", id = "btnPrev" .. id,
        click = function() self:decrease() end,
        caption = "-"
      },
      Components.text { style = "spinner-text", text = string.format("%02d", self.value) },
      Components.button {
        style = "spinner-button", id = "btnNext" .. id,
        click = function() self:increase() end,
        caption = "+"
      }
    }
  end

  spin.increase = function(self)
    safeCall(self.onIncrease, self)
  end

  spin.decrease = function(self)
    safeCall(self.onDecrease, self)
  end

  return spin
end)

return Spinner