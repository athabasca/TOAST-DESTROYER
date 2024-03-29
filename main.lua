require("Toast")
require("Knife")
require("Sound")

local plateImg
local knifeImg
local knife = nil
local toastImg
local toast = nil

local score
local timer
local gameOver
local firstButter

local mouseWasDown
local dx, dy
local lastx, lasty

function love.load()
	love.mouse.setVisible(false)

	plateImg = love.graphics.newImage("plate.png")
	knifeImg = love.graphics.newImage("knife-spritesheet.png")
	toastImg = love.graphics.newImage("toast-spritesheet.png")

	knife = Knife.new(knifeImg, 128, 512, 4)
	toast = Toast.new(toastImg, 512, 512, 5, 12)

	score = 0
	timer = 30
	gameOver = true
	firstButter = true

	dx = 0
	dy = 0
end

function love.update(dt)
	if gameOver then
		if love.keyboard.isDown('space') then
			score = 0
			timer = 60
			gameOver = false
		end

		toast:update()
		return
	end

	timer = timer - dt
	if timer <= 0 then
		timer = 0
		gameOver = true
	end

	if not love.mouse.isDown(1) and mouseWasDown then
		mouseWasDown = false
		-- Damage the toast if the knife travelled a distance at
		-- least equal to one quarter the diagonal of the toast.
		local toastDiag = math.sqrt(toast.width^2 + toast.height^2)
		if math.sqrt(dx^2 + dy^2) >= toastDiag/4 then
			dx = (dx-toast.width > 0) and dx-toast.width or 0
			dy = (dy-toast.height > 0) and dy-toast.height or 0
			toast:butter()
			if firstButter then
				knife:setSmear()
				firstButter = false
			end
			if not Sound.isPlaying() then
				Sound.playRandom()
			end
		end
		dx = 0
		dy = 0
	end

	if love.mouse.isDown(1) and
			not toast:isDESTROYED() and
			Knife.collidesRect(toast.xpos,toast.ypos,toast.width,toast.height) 
	then
		if not mouseWasDown then
			mouseWasDown = true
			lastx = love.mouse.getX()
			lasty = love.mouse.getY()
		else
			local x = love.mouse.getX()
			local y = love.mouse.getY()
			
			if (dx > 0) == ((lastx - x) > 0) then
				dx = dx + (lastx - x) end
			if (dy > 0) == ((lasty - y) > 0) then
				dy = dy + (lasty - y) end
			lastx = x
			lasty = y
		end
	end

	if toast:isDamaged() then
		knife:setCrummy()
	end
	if toast:isDESTROYED() then
		score = score + 1
		toast:respawn()
	end

	toast:update()
end

function love.draw()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	-- let's draw score and time
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("Score: " .. score, 10, 10)
	love.graphics.print("Time: " .. string.format("%.2f", timer), 10, height - 20)

	-- let's draw the plate
	love.graphics.draw(plateImg,
						width/2 - plateImg:getWidth()/2,
						height/2 - plateImg:getHeight()/2)
	-- let's draw toast
	toast:draw()

	-- let's draw the knife to follow the cursor
	knife:draw()

	if gameOver then
		love.graphics.setColor(0, 255, 0, 255)
		love.graphics.print("Press space to start!", width/2 - 70, height - 30)
	end
end
