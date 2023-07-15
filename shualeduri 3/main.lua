push = require 'push'
Class = require 'class'

require 'StateMachine'

require 'BaseState'
require 'StartState'
require 'PlayState'

require 'Player'
require 'Bullet'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

counter = 0
spawnTimer = 0

function love.load()
    
    io.stdout:setvbuf("no")
    
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    medium_font = love.graphics.newFont('8bit_font.ttf', 8)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = true,
		vsync = true
	})

    stateMachine =  StateMachine {
		['start'] = function() return StartState() end,
		['play'] = function() return PlayState() end
	}

    stateMachine:change('start')

    love.graphics.setFont(medium_font)

    player = Player()
    bullets = {}
    paused = false
    score = 0
end

function love.update(dt)
    
    stateMachine:update(dt)

    if love.keyboard.isDown("space") then
        love.load()
    end
    
end

function love.draw()
    push:start()

    for i,v in ipairs(bullets) do
        v:render()
    end

    love.graphics.setColor(0.7,0.7,0.7)
    love.graphics.rectangle("fill",10,4*VIRTUAL_HEIGHT/5,VIRTUAL_WIDTH-20,VIRTUAL_HEIGHT/5)
    love.graphics.rectangle("fill",10,0,VIRTUAL_WIDTH-20,4*VIRTUAL_HEIGHT/5-150)

    love.graphics.setColor(0,0,0)
    love.graphics.setColor(1,1,1)
    love.graphics.printf('Dodged ' .. score .. ' bullets.', 0, 10, VIRTUAL_WIDTH, 'center')
    
    player:render()
    
    stateMachine:render()

    push:finish()
end

function love.keypressed(key)

    local prev_state = player.state

    if key == "w" then
        player:Jump(dt)
    elseif key == "s" then
        player:crouch(dt)
    end

    if player.state ~= prev_state then
        counter = 0
    end

end

function spawnBullets(dt)

    spawnTimer = spawnTimer + 2*dt

    if spawnTimer>1 then
        table.insert(bullets, Bullet())
        spawnTimer = 0
    end

end