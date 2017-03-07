
require("redDisc")
require("orangeDisc")
require("cron")

local width = 650
local heigth = 560
local columns_n = 7
local column_size = width/columns_n
columns = {}
is_red_turn = false
is_orange_turn = false

--Save the positions of the discsmd
discs = {}

--matrix of the positions of the discs
md = {}

--counters for every column
mc = {}

-- valid elements of the game

current_symbol = {"X", "O"}
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
    symbol = current_symbol[2]
  else
    is_orange_turn = true
    symbol =  current_symbol[1]
  end

  --creating the matrix
  for i=1,columns_n do
    md[i] = {}
    for j=1,columns_n do
      md[i][j] = "."
    end
  end

  --counters for elements positions

  for i = 1, columns_n do
    mc[i] = 7
  end
end


function love.update(dt)
  check_winner(md, columns_n)
  tie()
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
    gameLogic(x)
    print("thinking........")
  --  gameLogic(randomMachinePlaying())
    gameLogic(simulateAnnealing())

  end
end

function gameLogic(x)
  separation = {77, 81, 85, 88, 91, 94, 97}
  y_positions = {5, 85, 165, 245, 325, 405, 485}
  for i, v in ipairs(columns) do
    if x < v and mc[i] > 0 then
      if is_red_turn  then
        table.insert(discs, Reddiscs_controller.disc)
        is_red_turn = false
         symbol = current_symbol[2]
        is_orange_turn = true
      else
        table.insert(discs, Orangediscs_controller.disc)
        is_orange_turn = false
        symbol = current_symbol[1]
        is_red_turn = true
      end
      table.insert(discs, v - separation[i])
      table.insert(discs, y_positions[mc[i]])
      md[mc[i]][i] = symbol
      mc[i] = mc[i] - 1
      displayTerminalGame(md, columns_n)
      break
    elseif mc[i] <= 0 then
      printf("you can't insert another disc in the column %d\n", i)
    end
  end
end

local win = false
local red_win = false
local orange_win = false

function tie()
  for i, v in pairs(mc) do
    if v == 0 then
      if i == 7 then
        print("It's a tie, nobody won the game")
        love.game.quit()
      end
    else
      break
    end
  end
end
function check_winner(matrix, n)
  --vertical & horizontal validation
  for i=1, n - 3 do
    for j=1, n do
        if matrix[i][j] == matrix[i + 1][j] and matrix[i][j] == matrix[i + 2][j] and matrix[i][j] == matrix[i + 3][j]   and matrix[i][j] ~= "."  then
          if matrix[i][j] == current_symbol[1] then
            orange_win = true
          else
            red_win = true
          end
          win = true
        end
        if matrix[j][i] == matrix[j][i + 1 ] and matrix[j][i] == matrix[j][i + 2] and matrix[j][i] == matrix[j][i + 3]   and matrix[j][i] ~= "." then
          if matrix[i][j] == current_symbol[1] then
            orange_win = true
          else
            red_win = true
          end
          win = true
        end
    end
  end
  --diagonal validation n

  for i=4, n do
    for j=4, n do
      if matrix[i][j] == matrix[i -1][j -1]  and matrix[i][j]  == matrix[i -2][j -2] and matrix[i][j] == matrix[i -3][j - 3] and matrix[i][j] ~= "."  then
        if matrix[i][j] == current_symbol[1] then
          orange_win = true
        else
          red_win = true
        end
        win = true
        break
      end
    end
  end

  --diagonal validation p

  for i = 4, n do
    for j=1, n -3 do
      if matrix[i][j] == matrix[i - 1][j + 1] and matrix[i][j] == matrix[i - 2][j + 2]  and matrix[i][j] == matrix[i - 3][j + 3] and matrix[i][j] ~= "." then
        if matrix[i][j] == current_symbol[1] then
          orange_win = true
        else
          red_win = true
        end
        win = true
        break
      end
    end
  end

  if win == true then
    if red_win then
    print("the Red discs won the game")
    else
      print("the Orange discs won the game")
    end
    love.event.quit()
  end
end


function randomMachinePlaying()
  math.randomseed(os.time())
  return math.random(4, 600)
end

local first_element = true

local op_sol = {}
local prueba = true

function simulateAnnealing()

  if win == false and table.getn(op_sol) == 0  then
    prueba = true
  end

  if prueba then
    op_sol = heuristic_closer_node()
    prueba = false
  end

  return table.remove(op_sol, 1)

end


function heuristic_closer_node()
  local pos = {17, 109, 199, 293, 378, 468, 558}
  local solution = {}

  math.randomseed(os.time())
  local election = math.random(1, 4)

  for i = 1, 4 do
    solution[i] = pos[election]
    election = election + 1
  end

  return solution
end


function printMatrix(matrix, n)
  for i=1,n do
    print()
    for j=1,n do
      printf(" %s ",matrix[i][j])
    end
    print()
  end
  printf("\n---------------------\n")
end

function displayTerminalGame(matrix, n)
  if is_red_turn then
    print("It's Red's turn")
  else
    print("It's Orange's turn")
  end
  printMatrix(matrix, n)
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
