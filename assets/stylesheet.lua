-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

moonpie.graphics.font:register("assets/fonts/square.ttf", "terminal")

local styles = moonpie.ui.styles

styles.terminal = {
  background_color = "black",
  width = "100%",
  height = "100%"
}

styles.terminal_grid = {
  align = "center"
}

styles.terminal_character = {
  font_name = "terminal",
  font_size = 14,
  color = "white"
}