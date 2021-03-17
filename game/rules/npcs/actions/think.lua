-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(enemy)
  return function(dispatch, getState)
    enemy:ai(dispatch, getState)
  end
end