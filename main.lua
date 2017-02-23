


function love.load()
  love.window.setMode(1000, 900, {resizable=true, vsync=false, minwidth=400, minheight=300})
  love.graphics.setBackgroundColor(44, 110, 225)
  love.window.setTitle("Connect 4")

end



function love.update(dt)

end


function love.draw()

end






printf = function(s,...)
           return io.write(s:format(...))
         end -- function
