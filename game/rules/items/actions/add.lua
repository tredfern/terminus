-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(item, x, y)
  return {
    payload = {
      item = item:clone {
        x = x, y = y
      }
    }
  }
end