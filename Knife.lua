Knife = {}

Knife.new = function(image, framew, frameh, nframes)
	local self = self or {}
	self.image = image
	self.width = framew
	self.height = frameh
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
	-- NB first frame of knife has no butter, skip it
	self.currentFrame = 2
	self.activeFrame = self.frames[self.currentFrame]

	-- member functions
	self.draw = function()
		love.graphics.draw(self.image,self.activeFrame,
							love.mouse.getX(),love.mouse.getY(),
							math.rad(45))
	end

	-- yes, these are magic numbers
	self.setSmear = function()
		self.currentFrame = 3
		self.activeFrame = self.frames[self.currentFrame]
	end

	self.setCrummy = function()
		self.currentFrame = 4
		self.activeFrame = self.frames[self.currentFrame]
	end
	
	return self
end
