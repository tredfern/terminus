-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.themes.standard"

local styles = moonpie.ui.styles

styles["action_menu"] = { }

styles["action_menu_item"] = { }

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

--layouts

styles.main_menu = {
  width = 250,
  height = "40%"
}

styles.main_menu_button = {
  display = "block"
}

styles.panel = {
  color = "main",
  border_color = "main",
  margin = 2
}

styles.panel_red = {
  color = "base_red",
  border_color = "base_red"
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

styles.panel_contents = {
  color = "text",
  margin = { left = 8, right = 8, bottom = 8 },
  padding = 8,
  corner_radius_x = 16,
  corner_radius_y = 16,
  background_color = "background",
  font_name = "default",
  font_size = 14
}

styles.primary = {
  width = "80%",
  height = "90%"
}