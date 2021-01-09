-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(player_action)
  return function(dispatch)
    dispatch(player_action)
  end
end