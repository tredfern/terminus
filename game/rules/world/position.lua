-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local meta = {
  __eq = function(self, compare)
    if compare.x then
      return self.x == compare.x and
        self.y == compare.y and
        self.z == compare.z
    else
      return self.x == compare[1] and
        self.y == compare[2] and
        self.z == compare[3]
    end
  end
}

local function new(x, y, z)
  return setmetatable({
    x = x,
    y = y,
    z = z
  }, meta)
end


return {
  new = new
}