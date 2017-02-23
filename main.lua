
require("redDisc")
require("orangeDisc")
function love.load()
  love.window.setMode(1000, 880, {resizable=true, vsync=false, minwidth=400, minheight=300})
  --love.graphics.setBackgroundColor(44, 110, 225)
  background = love.graphics.newImage("images/board.png")
  love.window.setTitle("Connect 4")
  printx = 0
  printy = 0

  Reddiscs_controller:spawnReddisc(0,0)
  Orangediscs_controller:spawnOrangedisc(0,0)
end



function love.update(dt)

end


function love.draw()
  love.graphics.draw(Orangediscs_controller.disc, 95,0,0)
  love.graphics.draw(Reddiscs_controller.disc, 15,5,0)
  love.graphics.print("Text", printx, printy)



  ---for background image
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end
end



function love.mousepressed(x, y, button, istouch)
  if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
     printx = x
     printy = y
  end
end


printf = function(s,...)
           return io.write(s:format(...))
         end -- function
