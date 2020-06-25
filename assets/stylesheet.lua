-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.themes.standard"

local styles = moonpie.ui.styles

styles["action_menu"] = {
  vertical_align = "bottom"
}

styles["action_menu_item"] = {

}

styles["destination_button"] = {
  margin = 5,
  width = "20%"
}

styles["game_panel"] = {
  width = "80%",
  height = "90%",
  border = 1,
  border_color = "light_accent",
}

styles["game_view"] = {
  height = "75%"
}

styles["label"] = {
  padding = 2,
  font_name = "default-bold",
  font_size = 15
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

styles["panel_contents"] = {
  padding = 6
}

styles["player_panel"] = {
  width = "20%",
  height = "90%",
  border = 1,
  border_color = "light_accent"
}

styles["value"] = {
  padding = 2,
  font_name = "default",
  font_size = 15
}