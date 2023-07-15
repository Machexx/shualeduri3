PlayState = Class{__includes = BaseState}

function PlayState:render()
	spawnBullets(dt)

        player:update(dt)

        for i,v in ipairs(bullets) do
            v:update(dt)

            if v.dead then
                table.remove(bullets, i)
                score = score + 1
            end

            if v:hit(player) then
                paused = true
            end
        end
end

