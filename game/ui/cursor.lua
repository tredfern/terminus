-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Cursor = {}

function Cursor.show()
  Cursor.isVisible = true
end

function Cursor.hide()
  Cursor.isVisible = false
end

function Cursor.setPosition(pos)
  Cursor.position = pos
end

return Cursor