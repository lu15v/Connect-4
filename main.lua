
require("redDisc")
require("orangeDisc")

local width = 650
local heigth = 560
local columns_n = 7
local column_size = width/columns_n
columns = {}
is_red_turn = false
is_orange_turn = false

local red_symbol = "O"
local orange_symbol = "X"
--Save the positions of the discs
discs = {}

--matrix of the discs
md = {}

--counters for every column
mc = {}


function love.load()
  love.window.setMode(width, heigth, {resizable=true, vsync=false, minwidth=400, minheight=300})
  love.graphics.setBackgroundColor(44, 110, 225)
  background = love.graphics.newImage("images/board.png")
  love.window.setTitle("Connect 4")

  size = 0
  --array that saves the limits for every column
  for i = 0, columns_n do
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

  --creating the matrix
  for i=1,columns_n do
    md[i] = {}
    for j=1,columns_n do
      md[i][j] = 0
    end
  end

  --counters for elements positions

  for i = 1, columns_n do
    mc[i] = 7
  end
end


function love.update(dt)

end


function love.draw()

--draw the discs
  for i = 1, table.getn(discs), 3 do
    love.graphics.draw(discs[i], discs[i + 1], discs[i + 2], 0)
  end

  draw_background(background)
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    separation = {77, 81, 85, 88, 91, 94, 97}
    y_positions = {5, 85, 165, 245, 325, 405, 485}
    for i, v in ipairs(columns) do
      if x < v then
        if is_red_turn then
          table.insert(discs, Reddiscs_controller.disc)
          is_red_turn = false
          is_orange_turn = true
          md[mc[i]][i] = red_symbol
        else
          table.insert(discs, Orangediscs_controller.disc)
          is_orange_turn = false
          is_red_turn = true
          md[mc[i]][i] = orange_symbol
        end
        table.insert(discs, v - separation[i])
        table.insert(discs, y_positions[mc[i]])
        mc[i] = mc[i] - 1
        printMatrix()
        break
      end
    end
  end
end

function printMatrix()
  for i=1,columns_n do
    printf("\n")
    for j=1,columns_n do
      printf("%s",md[i][j])
    end
  end
  printf("\n-------\n")
end


printf = function(s,...)
           return io.write(s:format(...))
         end -- function


function draw_background(background)
 ---for background image
 for i = 0, love.graphics.getWidth() / background:getWidth() do
   for j = 0, love.graphics.getHeight() / background:getHeight() do
       love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
   end
 end
end
