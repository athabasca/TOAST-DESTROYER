require("Toast")
require("Knife")

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
	-- return x1 >= x2 and x1+w1 <= x2+w2 and y1 >= y2 and y1+h1 <= y2+h2
	return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

local plateImg
local knifeImg
local knife = nil
local toastImg
local toast = nil

local score
local timer
local gameOver
local firstButter
local mousePressedAlready

function love.load()
	love.mouse.setVisible(false)

	plateImg = love.graphics.newImage("plate.png")
	knifeImg = love.graphics.newImage("knife-spritesheet.png")
	toastImg = love.graphics.newImage("toast-spritesheet.png")

	knife = Knife.new(knifeImg, 128, 512, 4)
	toast = Toast.new(toastImg, 512, 512, 5, 30)

	score = 0
	timer = 30
	gameOver = true
	firstButter = true
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

	-- Else:
	timer = timer - dt
	if timer <= 0 then
		timer = 0
		gameOver = true
	end

	if not love.mouse.isDown(1) then
		mousePressedAlready = false
	elseif not mousePressedAlready and
			not toast:isDESTROYED() and
			CheckCollision(love.mouse.getX(), love.mouse.getY(), 1, 1,
					toast.xpos,toast.ypos,toast.width,toast.height) 
	then
		mousePressedAlready = true
		toast:butter()
		if firstButter then
			knife:setSmear()
			firstButter = false
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
