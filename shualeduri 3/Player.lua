Player = Class{}

function Player:init(x, y)
	self.x = VIRTUAL_WIDTH/5
	self.y = 4*VIRTUAL_HEIGHT/5
	
	self.width = 60
	self.height = 120

end

function Player:jump(dt)
	self.width = math.floor(player.width * (1 + 0.25))
    self.height = math.floor(player.height * (1 - 0.25))
    self.y = player.y - player.height*2*0.25
    counter = counter + dt
end

function Player:crouch(dt)
	self.width = math.floor(player.width * (1 + 1.5*0.25))
    self.height = math.floor(player.height * (1 - 1.5*0.25))
    player.y = player.y
    counter = counter + dt
end

function Player:render()
	love.graphics.setColor(1,1,0)
    love.graphics.rectangle("fill", self.x - self.width/2, self.y - self.height, self.width, self.height)
    love.graphics.setColor(1,1,1)
end

function Player:update(dt)

    if counter > 0.36 then
        self.state = "normal"
    end

end
