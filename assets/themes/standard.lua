-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

-- Fonts
-- Standard types "default", "default-bold", "headline", "headline-bold", "fixed", fixed-bold", "not-set"
local font = moonpie.graphics.font
moonpie.graphics.font:register("assets/fonts/square.ttf", "terminal")

font:register("assets/fonts/BalsamiqSans-Regular.ttf", "default")
font:register("assets/fonts/BalsamiqSans-Bold.ttf", "default-bold")
font:register("assets/fonts/LibreBaskerville-Regular.ttf", "headline")
font:register("assets/fonts/LibreBaskerville-Bold.ttf", "headline-bold")

-- Colors
local colors = moonpie.graphics.colors
colors.light_shade = colors.convert_hex("#FAFAFA")
colors.light_accent = colors.convert_hex("#7AB257")
colors.main = colors.convert_hex("#EF6000")
colors.dark_accent = colors.convert_hex("#AF594C")
colors.dark_shade = colors.convert_hex("#1B1B29")

colors.button_default = colors.gray_medium
colors.button_default_hover = colors.light_gray
colors.button_text = colors.white
colors.primary = colors.main
colors.info = colors.steel_gray
colors.success = colors.convert_hex("#7b973e")
colors.warning = colors.convert_hex("#f88706")
colors.danger = colors.pomegranate

colors.background = "dark_shade"
colors.text = "light_shade"
colors.accent = "dark_accent"
colors.invert_background = "light_shade"
colors.invert_text = "dark_shade"
