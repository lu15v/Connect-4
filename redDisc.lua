Reddisc = {}
Reddiscs_controller = {}
Reddiscs_controller.discs = {}
Reddiscs_controller.disc = love.graphics.newImage("images/red.png")



function Reddiscs_controller:spawnReddisc(x, y)
  Reddisc.x = x
  Reddisc.y = y
  Reddisc.width = self.disc:getWidth()
  Reddisc.heigth = self.disc:getHeight()
  table.insert(self.discs, Reddisc)
end
