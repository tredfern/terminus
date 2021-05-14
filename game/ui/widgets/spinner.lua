-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"

local Spinner = Components("spinner", function(props)
  local id = props.id or ""
  local spin = {
    value = props.value
  }

  spin.render = function(self)
    return {
      display = "inline",
      Components.button {
        style = "button-small spinner-button align-middle", caption = "<", id = "btnPrev" .. id,
        click = function() self:changeValue(-1) end },
      Components.text { style = "spinner-text align-middle", text = self.value },
      Components.button {
        style = "button-small spinner-button align-middle", caption = ">", id = "btnNext" .. id,
        click = function() self:changeValue(1) end }
    }
  end

  spin.changeValue = function(self, inc)
    self:update { value = self.value + inc }
  end

  return spin
end)

return Spinner