-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  random = function(baseprice)
    if not baseprice then return 0 end
    return love.math.random(math.floor(baseprice * 0.75), math.floor(baseprice * 1.25))
  end
}