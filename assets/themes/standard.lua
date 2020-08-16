-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

-- Fonts
-- Standard types "default", "default-bold", "headline", "headline-bold", "fixed", fixed-bold", "not-set"
local font = moonpie.graphics.font
moonpie.graphics.font:register("assets/fonts/square.ttf", "terminal")

font:register("assets/fonts/coolvetica-rg.ttf", "default")
font:register("assets/fonts/BalsamiqSans-Bold.ttf", "default-bold")
font:register("assets/fonts/nulshock.ttf", "headline")
font:register("assets/fonts/nulshock.ttf", "headline-bold")

-- Colors
local colors = moonpie.graphics.colors
colors.base_blue = colors.convert_hex("#3179bd")
colors.base_red = colors.convert_hex("#a91a1a")
colors.base_purple = colors.convert_hex("#9575a8")
colors.base_yellow = colors.convert_hex("#fec562")
colors.accent_yellow = colors.convert_hex("#f59d08")

colors.light_shade = "base_yellow"
colors.light_accent = "accent_yellow"
colors.main = "base_blue"
colors.dark_accent = "base_red"
colors.dark_shade = colors.convert_hex("#040503")

colors.button_default = "main"
colors.button_default_hover = colors.lighten(colors:get_color("main"), 0.2)
colors.button_text = colors.white
colors.primary = colors.main
colors.info = colors.steel_gray
colors.success = colors.convert_hex("#7b973e")
colors.warning = colors.convert_hex("#f88706")
colors.danger = colors.pomegranate

colors.background = "dark_shade"
colors.text = "ghost_white"
colors.accent = "dark_accent"
colors.invert_background = "light_shade"
colors.invert_text = "dark_shade"
