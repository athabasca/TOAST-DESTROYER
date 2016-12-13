Sound = {}

local toastSounds = {
	love.audio.newSource("sound/toast1.ogg", "static"),
	love.audio.newSource("sound/toast2.ogg", "static"),
	love.audio.newSource("sound/toast3.ogg", "static"),
	love.audio.newSource("sound/toast4.ogg", "static"),
	love.audio.newSource("sound/toast5.ogg", "static"),
	love.audio.newSource("sound/toast6.ogg", "static"),
	love.audio.newSource("sound/toast7.ogg", "static"),
	love.audio.newSource("sound/toast8.ogg", "static"),
	love.audio.newSource("sound/toast9.ogg", "static"),
	love.audio.newSource("sound/toast10.ogg", "static"),
	love.audio.newSource("sound/toast11.ogg", "static"),
	love.audio.newSource("sound/toast12.ogg", "static"),
	love.audio.newSource("sound/toast13.ogg", "static"),
	love.audio.newSource("sound/toast14.ogg", "static"),
	love.audio.newSource("sound/toast15.ogg", "static"),
	love.audio.newSource("sound/toast16.ogg", "static"),
	love.audio.newSource("sound/toast17.ogg", "static"),
	love.audio.newSource("sound/toast18.ogg", "static"),
	love.audio.newSource("sound/toast19.ogg", "static"),
	love.audio.newSource("sound/toast20.ogg", "static"),
	love.audio.newSource("sound/toast21.ogg", "static"),
	love.audio.newSource("sound/toast22.ogg", "static"),
	love.audio.newSource("sound/toast23.ogg", "static"),
	love.audio.newSource("sound/toast24.ogg", "static"),
	love.audio.newSource("sound/toast25.ogg", "static"),
	love.audio.newSource("sound/toast26.ogg", "static"),
	love.audio.newSource("sound/toast27.ogg", "static"),
	love.audio.newSource("sound/toast28.ogg", "static"),
	love.audio.newSource("sound/toast29.ogg", "static"),
	love.audio.newSource("sound/toast30.ogg", "static"),
	love.audio.newSource("sound/toast31.ogg", "static"),
	love.audio.newSource("sound/toast32.ogg", "static"),
	love.audio.newSource("sound/toast33.ogg", "static")
}
local lastDuration = 0
local lastPlayTime = 0

function Sound.isPlaying()
	return love.timer.getTime() - lastPlayTime < lastDuration
end

function Sound.playRandom()
	local sound = toastSounds[math.random(#toastSounds)]
	lastDuration = sound:getDuration()
	lastPlayTime = love.timer.getTime()
	sound:play()
end

