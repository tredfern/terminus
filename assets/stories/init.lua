-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local files = require "moonpie.utility.files"
local list = require "moonpie.collections.list"
local story_files = files.find("assets/stories/", "lua$", "_spec.lua$")
local stories = list:new()

for _, v in ipairs(story_files) do
  if string.find(v, "init.lua") == nil then
    local rp = string.gsub(v, "%.lua", "")
    rp = string.gsub(rp, "/", ".")
    stories:add(require(rp))
  end
end

return stories