-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

-- Fonts
-- Standard types "default", "default-bold", "headline", "headline-bold", "fixed", fixed-bold", "not-set"
local font = moonpie.graphics.font
moonpie.graphics.font:register("assets/fonts/square.ttf", "terminal")

font:register("assets/fonts/RedRose-Regular.ttf", "default")
font:register("assets/fonts/RedRose-Bold.ttf", "default-bold")
font:register("assets/fonts/atmospheric.ttf", "headline")
font:register("assets/fonts/atmospheric.ttf", "headline-bold")
font:register("assets/fonts/ShareTechMono-Regular.ttf", "monospace")
--font:register("assets/fonts/ShareTechMono-Regular.ttf", "default")
--font:register("assets/fonts/ShareTechMono-Regular.ttf", "default-bold")

-- Colors
local colors = moonpie.graphics.colors
colors.oxford_blue = colors.convert_hex("#0a2239")
colors.outer_space_crayola = colors.convert_hex("#132e32")
colors.cerulean_crayola = colors.convert_hex("#21a5d0")
colors.antique_bronze = colors.convert_hex("#665e29")
colors.beaver = colors.convert_hex("#ac9281")
colors.grullo = colors.convert_hex("#b69f90")
colors.baby_powder = colors.convert_hex("#fbfbf2")
colors.goldenrod = colors.convert_hex("#e6af2e")
colors.titanium_yellow = colors.convert_hex("#f0e100")
colors.lava = colors.convert_hex("#c42021")
colors.pakistan_green = colors.convert_hex("#2a7221")
colors.dark_spring_green = colors.convert_hex("#2c6e49")

colors.light_shade = "baby_powder"
colors.light_accent = "beaver"
colors.main = "cerulean_crayola"
colors.dark_accent = "outer_space_crayola"
colors.dark_shade = "oxford_blue"

colors.button_default = "main"
colors.button_default_hover = colors.lighten(colors:getColor("main"), 0.2)
colors.button_text = colors.light_shade
colors.primary = colors.main
colors.info = colors.beaver
colors.success = colors.dark_spring_green
colors.warning = colors.titanium_yellow
colors.danger = colors.lava

colors.background = "dark_shade"
colors.text = "light_shade"
colors.accent = "dark_accent"
colors.invert_background = "light_shade"
colors.invert_text = "dark_shade"
colors.grid_lines = colors.baby_powder
