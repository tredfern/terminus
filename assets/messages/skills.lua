-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Helper = require "game.rules.message_log.helper"
local highlight = Helper.highlight

return {
  opposed = {
    string.format(
      "%s({{aggSkill}}:%s/{{aggTarget}}) : %s({{defSkill}}:%s/{{defTarget}})",
      highlight("{{aggressor}}"),
      highlight("{{aggRoll}}"),
      highlight("{{defender}}"),
      highlight("{{defRoll}}")
    )
  },
  taskCheck = string.format("(%s+%s >= 8)",
    highlight("{{roll}}"),
    highlight("{{modifiers}}")
  )
}