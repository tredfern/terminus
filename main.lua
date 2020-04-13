love.filesystem.setRequirePath("?.lua;?/init.lua;ext/?.lua;ext/?/init.lua;ext/moonpie/?.lua;ext/moonpie/?/init.lua;")
moonpie = require "moonpie"


function love.update()
  -- moonpie.update handles the mouse and keyboard behaviors
  --
  -- It also will check if there is a component that has a render method and a need to
  -- refresh. If so, it will rerender that component, replacing it's children with
  -- the output from the render method. Layouts will be recomputed only for the children
  -- down
  moonpie.update()
end

function love.draw()
  -- moonpie.paint handles the drawing steps for all the visible components.
  --
  -- Because of how love.graphics.getStats() works, this is also tracked in the
  -- paint method. In general, I would expect that this should be the last call
  -- of any drawing since usually interface is on top of everything else, but
  -- if that is not the case the debug stats on the panel could be off.
  moonpie.paint()
end

function love.keypressed(key, scancode, isrepeat)
  moonpie.keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
  moonpie.keyreleased(key, scancode)
end
