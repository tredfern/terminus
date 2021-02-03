-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Components = require "moonpie.ui.components"
local tables = require "moonpie.tables"

local VideoResolution = Components("video_resolution", function()
  local curWidth, curHeight = love.window.getMode()
  local modes = love.window.getFullscreenModes()
  local _, index = tables.findFirst(modes, function(m) return m.width == curWidth and m.height == curHeight end)

  local component
  local updateResolution = function(nextIndex)
    if nextIndex < 1 then nextIndex = #modes end
    if nextIndex > #modes then nextIndex = 1 end

    component:update({
      modeIndex = nextIndex,
      resolutionWidth = modes[nextIndex].width,
      resolutionHeight = modes[nextIndex].height
    })
  end

  component = {
    modeIndex = index,
    resolutionWidth = curWidth,
    resolutionHeight = curHeight,
    getResolution = function(self)
      return { width = self.resolutionWidth, height = self.resolutionHeight }
    end,
    render = function(self)
      return {
        Components.button { id = "btnPrev", caption = "<<-",
          click = function() updateResolution(self.modeIndex + 1) end},
        Components.text {
          id = "displayText",
          text = string.format("%d x %d", self.resolutionWidth, self.resolutionHeight) },
        Components.button { id = "btnNext", caption = "->>",
          click = function() updateResolution(self.modeIndex - 1) end },
      }
    end
  }

  return component
end)

return VideoResolution