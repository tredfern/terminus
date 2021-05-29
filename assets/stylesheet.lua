-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "assets.themes.standard"

local styles = moonpie.ui.styles
local colors = require "moonpie.graphics.colors"
local sounds = require "assets.sounds"

styles.body.fontSize = 18
styles.button = moonpie.tables.merge({
    fontSize = 18,
    fontName = "default-bold",
    vertical_align = "middle",
    clickSound = sounds.click,
  },
  styles.button
)

styles["button-primary"] = {
  backgroundColor = "primary",
  color = "dark_shade",
 _hover_ = {
    backgroundColor = colors.lighten(colors("primary"), 1.2)
  }
}

styles.button_bar = {
  display = "inline",
  align = "right",
  margin = { right = 15 },
  padding = 0
}

styles.button_bar_button = {
  borderColor = "dark_accent",
  border = 5,
  padding = { left = 5, right = 5, top = 5, bottom = 5 },
  margin = 0,
  cornerRadiusX = 0, cornerRadiusY = 0
}

styles.button_increment = {
  padding = 3,
  cornerRadiusX = 0,
  cornerRadiusY = 0
}

styles["character-details-panel"] = {
  border = 1,
  borderColor = "light_accent",
  width = "25%"
}

styles["character-details-panel-title"] = {
  border = 1,
  borderColor = "light_accent",
}

styles.characterAttributeLabelPair = {
  padding = 4,
  margin = 6
}

styles.combat_map = {
  position = "absolute",
  x = 0,
  y = 0,
  height = "100%"
}

styles.full_screen_panel = {
  margin = 5,
  width = "100%",
  height = "100%"
}

styles.full_screen_panel_title = {
  backgroundColor = "main",
  cornerRadiusX = 16,
  cornerRadiusY = 16,
}

styles.full_screen_panel_title_text = {
  fontName = "headline",
  fontSize = 24,
  color = "light_shade",
  margin = { left = 25 },
  padding = { left = 9, right = 9, top = 10, bottom = 5 },
  backgroundColor = "background",
}

styles.full_screen_panel_contents = {
  color = "text",
  margin = { left = 8, right = 8, bottom = 8 },
  padding = 8,
  cornerRadiusX = 16,
  cornerRadiusY = 16,
  backgroundColor = "background",
  fontName = "default",
  fontSize = 16,
  height = "95%"
}

styles.game_start_screen = {
  height = "100%"
}

styles.logo_text = {
  color = colors.light_shade
}

styles.map_view = {
  width = "75%",
  height = "100%",
}

styles.main_menu = {
  width = 250,
  height = "40%"
}

styles.main_menu_button = {
  display = "block",
  clickSound = sounds.click,
  cornerRadiusX = 15,
  cornerRadiusY = 15,
  padding = { left = 15, right = 15, top = 8, bottom = 8 },
  vertical_align = "middle",
}

styles.message_log = {
  padding = 10,
  fontSize = 15,
  height = 100,
  verticalAlign = "bottom",
  backgroundColor = colors(colors.dark_shade, 0.7),
  borderColor = colors(colors.light_shade, 0.5),
  border = 1
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
  fontSize = 18,
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
  fontName = "default"
}

styles.primary = {
  width = "80%",
  height = "90%"
}

styles.spinner = {
  display = "inline"
}

styles["spinner-button"] = {
  margin = { left = 4, right = 4 },
  padding = { left = 4, right = 4 },
  fontSize = 18
}

styles["spinner-text"] = {
  border = 1,
  borderColor = colors.light_accent,
  padding = { left = 4, right = 4 },
  fontName = "monospace"
}

styles.splash = {
  height = "100%",
  backgroundColor = colors.light_accent
}

styles.stats = {
  width = "25%",
  height = "100%",
  border = 2,
  borderColor = "dark_accent",
  backgroundColor = colors.lighten(colors:getColor("dark_shade"), 1.5)
}

styles.stats_content = {
  padding = 8
}

styles.textbox = moonpie.tables.merge({
    width = 250,
    height = 25,
  },
  styles.textbox)

styles.textbox_text = {
  fontSize = 18,
}

styles.title_screen = {
  height = "100%"
}