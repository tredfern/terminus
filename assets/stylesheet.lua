-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.themes.standard"

local styles = moonpie.ui.styles

styles.button = moonpie.tables.merge(
  {
    cornerRadiusX = 15,
    cornerRadiusY = 15,
    fontName = "headline",
    padding = { left = 15, right = 15, top = 8, bottom = 8 },
    vertical_align = "middle"
  },
  styles.button
)

styles.combat_map = {
  height = "100%"
}

styles["main_screen"] = {
  width = "75%"
}

styles["stats"] = {
  width = "25%",
  height = "100%",
  border = 2,
  borderColor = "light_accent",
  backgroundColor = "dark_accent"
}

styles["stats_content"] = {
  padding = 8
}

styles.textbox_text = {
  fontSize = 18,
}

--layouts
styles.main_menu = {
  width = 250,
  height = "40%"
}

styles.main_menu_button = {
  display = "block"
}

styles.message_log = {
  padding = 10,
  fontSize = 15
}

styles.panel = {
  color = "light_shade",
  borderColor = "light_accent",
  margin = 2
}

styles.panel_primary = {
  color = "main",
  borderColor = "main",
}

styles.panel_secondary = {
  color = "dark_accent",
  borderColor = "dark_shade"
}

styles.panel_title = {
  backgroundColor = "background",
  fontName = "headline",
  fontSize = 16,
  margin = { left = 25 },
  padding = { left = 6, right = 6, top = 2, bottom = 2 }
}

styles.panel_contents = {
  color = "text",
  margin = { left = 8, right = 8, bottom = 8 },
  padding = 8,
  cornerRadiusX = 16,
  cornerRadiusY = 16,
  backgroundColor = "background",
  fontName = "default",
  fontSize = 14
}

styles.primary = {
  width = "80%",
  height = "90%"
}

styles.textbox = moonpie.tables.merge({
    width = 250,
    height = 25,
    fontSize = 14,
    fontName = "default"
  },
  styles.textbox)