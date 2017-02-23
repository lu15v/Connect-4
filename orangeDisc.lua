Orangedisc = {}
Orangediscs_controller = {}
Orangediscs_controller.discs = {}
Orangediscs_controller.disc = love.graphics.newImage("images/orange.png")



function Orangediscs_controller:spawnOrangedisc(x, y)
  Orangedisc.x = x
  Orangedisc.y = y
  Orangedisc.width = self.disc:getWidth()
  Orangedisc.heigth = self.disc:getHeight()
  table.insert(self.discs, Orangedisc)
end
