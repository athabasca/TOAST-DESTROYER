Toast = {}

Toast.new = function(image, framew, frameh, nframes, hp)
	local self = self or {}
	self.image = image
	self.width = framew
	self.height = frameh
	self.totalHP = hp
	self.hp = hp
	self.frames = {}
	self.nframes = nframes

	local imgw,imgh = image:getDimensions()
	local x,y = 0,0
	for i=1, nframes do
		self.frames[i] = love.graphics.newQuad(x,y,framew,frameh,imgw,imgh)
		x = x + framew
		if x >= imgw then
			x = 0
			y = y + frameh
		end
	end
	self.currentFrame = 1
	self.activeFrame = self.frames[self.currentFrame]

	self.xpos = love.graphics.getWidth()/2 - select(3,self.activeFrame:getViewport())/2
	self.ypos = love.graphics.getHeight()/2 - select(4,self.activeFrame:getViewport())/2

	-- member functions
	self.draw = function()
		love.graphics.draw(self.image,self.activeFrame,self.xpos,self.ypos)
	end
	
	self.isDESTROYED = function()
		return (self.hp < 1)
	end

	self.isDamaged = function()
		return (self.hp < self.totalHP * 0.75)
	end

	self.butter = function()
		self.hp = self.hp - 1
		-- move to the next frame/stage of destruction
		-- every (totalHP/nframes) butter strokes.
		if self.hp % (self.totalHP/nframes) == 0 then
			self.currentFrame = self.currentFrame + 1
		end
	end

	self.respawn = function()
		self.hp = self.totalHP
		self.currentFrame = 1
	end

	self.update = function()
		self.activeFrame = self.frames[self.currentFrame]
	end

	return self
end
