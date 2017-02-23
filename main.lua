
require("redDisc")
require("orangeDisc")
function love.load()
  love.window.setMode(1000, 900, {resizable=true, vsync=false, minwidth=400, minheight=300})
  love.graphics.setBackgroundColor(44, 110, 225)
  love.window.setTitle("Connect 4")


  --Reddiscs_controller:spawnReddisc(0,0)
  --Orangediscs_controller:spawnOrangedisc(0,0)
end



function love.update(dt)

end


function love.draw()
  --love.graphics.draw(Orangediscs_controller.disc, 0,0,0)
end






printf = function(s,...)
           return io.write(s:format(...))
         end -- function
