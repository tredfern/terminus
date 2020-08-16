-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.themes.standard"

local styles = moonpie.ui.styles

--layouts
styles.sidebar = {
  width = "20%",
  height = "90%"
}

styles.primary = {
  width = "80%",
  height = "90%"
}

styles["action_menu"] = { }

styles["action_menu_item"] = { }

styles["destination_button"] = {
  margin = 5,
  width = "20%"
}

styles["game_panel"] = {
  width = "80%",
  height = "90%",
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

styles.stretch_height = {
  height = "100%"
}

styles.panel = {
  color = "main",
  border_color = "main",
  margin = 2
}

styles.panel_yellow = {
  color = "base_yellow",
  border_color = "base_yellow"
}

styles.panel_title = {
  background_color = "background",
  font_name = "headline",
  font_size = 16,
  margin = { left = 25 },
  padding = { left = 6, right = 6, top = 2, bottom = 2 }
}

styles["panel_contents"] = {
  color = "text",
  margin = { left = 8, right = 8, bottom = 8 },
  padding = 8,
  corner_radius_x = 16,
  corner_radius_y = 16,
  background_color = "background"
}

styles["player_panel"] = { }

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

styles.button = moonpie.tables.merge(
  {
    corner_radius_x = 15,
    corner_radius_y = 15,
    font_name = "headline",
    padding = { left = 15, right = 15, top = 8, bottom = 8 },
    vertical_align = "middle"
  },
  styles.button
)