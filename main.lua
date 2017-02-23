
require("redDisc")
require("orangeDisc")

local width = 1000
local heigth = 880

local column_size = width/11
columns = {}
x_possitions = {}

function love.load()
  love.window.setMode(width, heigth, {resizable=true, vsync=false, minwidth=400, minheight=300})
  love.graphics.setBackgroundColor(44, 110, 225)
  background = love.graphics.newImage("images/board.png")
  love.window.setTitle("Connect 4")

  size = 0
  --array that saves the limits for every column
  for i = 0, 11 do
    columns[i] = size
    size = size + column_size
  end

  --for that creates the discs
  Reddiscs_controller:spawnReddisc(0,0)
  Orangediscs_controller:spawnOrangedisc(0,0)


end



function love.update(dt)

end


function love.draw()
  --love.graphics.draw(Reddiscs_controller.disc, 15,5,0)
  --love.graphics.draw(Orangediscs_controller.disc, 105,5,0)
  --love.graphics.draw(Reddiscs_controller.disc, 195,5,0)
  --love.graphics.draw(Orangediscs_controller.disc, 285,5,0)
  --love.graphics.print("Text", printx, printy)

  for i, v in ipairs(x_possitions) do
    love.graphics.draw(Reddiscs_controller.disc,v -75, 5, 0)
  end


  ---for background image
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end
end



function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    for i, v in ipairs(columns) do
      if x < v then
        table.insert(x_possitions, math.floor(v))
        table.insert(Reddiscs_controller.discs, Reddisc)
        print(table.getn(Reddiscs_controller.discs))
        break
      end
    end
  end
end


printf = function(s,...)
           return io.write(s:format(...))
         end -- function
