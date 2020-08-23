-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"

local story = {}

function story:constructor(args)
  self.title = args.title
  self.description = args.description
  self.choices = args.choices
end

return class(story)