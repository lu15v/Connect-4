
require("redDisc")
require("orangeDisc")

local width = 1000
local heigth = 880

local column_size = width/11
columns = {}
x_possitions = {}
is_red_turn = false
is_orange_turn = false

discs = {}


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

  --for selecting what color begins with the game
  math.randomseed(os.time())
  turn = math.random(1, 100)


  if turn > 50 then
    is_red_turn = true
  else
    is_orange_turn = true
  end
end



function love.update(dt)

end


function love.draw()
  --love.graphics.draw(Reddiscs_controller.disc, 15,5,0)
  --love.graphics.draw(Orangediscs_controller.disc, 105,5,0)
  --love.graphics.draw(Reddiscs_controller.disc, 195,5,0)
  --love.graphics.draw(Orangediscs_controller.disc, 285,5,0)
  --love.graphics.print("Text", printx, printy)

--  for i, v in ipairs(x_possitions) do
--    love.graphics.draw(Reddiscs_controller.disc,v -74, 5, 0)
--    love.graphics.draw(Orangediscs_controller.disc,v -74, 5, 0)
--  end
  for i = 1, table.getn(discs), 3 do
    love.graphics.draw(discs[i], discs[i + 1], discs[i + 2], 0)
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
        if is_red_turn then
        --  table.insert(Reddiscs_controller.discs, Reddisc)
          table.insert(discs, Reddiscs_controller.disc)
          table.insert(discs, v- 74)
          table.insert(discs, 5)
          is_red_turn = false
          is_orange_turn = true
        else
        --  table.insert(Orangediscs_controller.discs, Orangedisc)
          table.insert(discs, Orangediscs_controller.disc)
          table.insert(discs, v- 74)
          table.insert(discs, 5)
          is_orange_turn = false
          is_red_turn = true
        end
        break
      end
    end
  end
end


printf = function(s,...)
           return io.write(s:format(...))
         end -- function
