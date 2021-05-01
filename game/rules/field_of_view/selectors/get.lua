-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state, entity)
  if state.fieldOfView then
    return state.fieldOfView[entity]
  end
  return nil
end