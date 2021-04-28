-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Helper = {}
local defaultColor = "msgText"

function Helper.colorText(text, color)
  return string.format("{color:%s}%s{color:%s}", color, text, defaultColor)
end

function Helper.alert(text)
  return Helper.colorText(text, "msgAlert")
end

function Helper.highlight(text)
  return Helper.colorText(text, "msgHighlight")
end


return Helper