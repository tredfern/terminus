-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

moonpie.ui.components("main_layout", function(props)
  return {
    moonpie.ui.components.market { market = props.spaceport }
  }
end)