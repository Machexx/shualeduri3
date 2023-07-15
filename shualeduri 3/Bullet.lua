Bullet = Class{}

function Bullet:init()
    self.x = VIRTUAL_WIDTH + 100
    self.y = 4*VIRTUAL_HEIGHT/5-math.floor(love.math.random(0,2.99))*45

    self.size = 15

    self.dead = false
    self.speed = 450
end

function Bullet:render()

    love.graphics.setColor(1,0.15,0.15)
    love.graphics.circle("fill", self.x, self.y, self.size)
    love.graphics.setColor(1,1,1)

end

function Bullet:update(dt)

    self.x = self.x - self.speed*dt

    if self.x < 0 then
        self.dead = true
    end
    
end

function Bullet:hit(player)
	if self.x > player.x + player.width or player.x > self.x + self.width then
		return false
	end
	
	if self.y > player.y + player.height or player.y > self.y + self.height then
		return false
	end
	
	return true
end