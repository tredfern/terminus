-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.themes.standard"

local styles = moonpie.ui.styles

styles["action_menu"] = { }

styles["action_menu_item"] = { }

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

styles.section_title = {
  margin = 3
}

styles["section_title_text"] = {
  background_color = "background",
  margin = { left = 20 },
  padding = { left = 6, right = 6, top = 2, bottom = 2 },
  font_name = "headline",
  font_size = 16
}