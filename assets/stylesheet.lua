-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.themes.standard"

local styles = moonpie.ui.styles

styles["market_panel"] = {
  width = "45%"
}

styles["destination_panel"] = {
  width = "45%"
}

styles["player_panel"] = {
  vertical_align = "bottom"
}

styles["market"] = {
}

styles["destination_button"] = {
  margin = 5,
  width = "20%"
}

styles["market-good-name"] = {
  padding = 10,
  font_name = "default",
  font_size = 20
}

styles["market-good-price"] = {
  padding = 10,
  font_name = "default",
  font_size = 20
}

styles["label-value-group"] = {
  border = 1,
  border_color = "light_accent",
  padding = 10
}

styles["label"] = {
  padding = 2,
  font_name = "default-bold",
  font_size = 15
}

styles["value"] = {
  padding = 2,
  font_name = "default",
  font_size = 15
}