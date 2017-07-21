------------------------------------------>>
-- Date: 27 Oct 2015
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
------------------------------------------>>

local sX,sY = guiGetScreenSize()
local size = 0
local r,g,b

local death_tick
local isVisible

local WASTED_DELAY = 2500

for i=1,math.huge do
	size = 2^i
	if (size > sX/2) then size = 2^(i-1) break end
end

-- Death/Spawn Functions
------------------------->>

addEventHandler("onClientPlayerWasted", localPlayer, function(killer)
	if (not isPlayerLoggedIn()) then return end
	isVisible = isPlayerHudComponentVisible("radar")
	showPlayerHudComponent("radar", false)
	r,g,b = getPlayerNametagColor(localPlayer)
	setGameSpeed(0.5)
	playSound("player/files/gtav_wasted.mp3")
	death_tick = getTickCount()
	addEventHandler("onClientPreRender", root, renderScreen)
end)

addEventHandler("onClientPlayerSpawn", localPlayer, function()
	if (not isPlayerLoggedIn()) then return end
	setPlayerHudComponentVisible("radar", isVisible)
	setGameSpeed(1)
	removeEventHandler("onClientPreRender", root, renderScreen)
end)

-- Render Functions
-------------------->>

function renderScreen()
		-- Make Death Screen Flash
	local a1, a2, a3 = 125, 0, 1
	if (getTickCount() < death_tick + 750) then
		a2 = ( -math.abs( ( (getTickCount()-death_tick)*2 / 750 ) - 1 ) ) + 1
		a3 = (getTickCount()-death_tick)*2 / 750 - 1
		if (a3 < 0) then a3 = 0 end
	end
	dxDrawRectangle(0, 0, sX, sY, tocolor(r + (255-r)*a3, g + (255-g)*a3, b + (255-b)*a3, 60+(a2*125)))
	
		-- Draw Wasted Text
	if (getTickCount() >= death_tick + WASTED_DELAY) then
		a1 = 255
		local x,y = sX/2, sY/2
		dxDrawText("wasted", x+3, y+3, x+3, y+3, tocolor(0,0,0,255), 3, "pricedown", "center", "center")
		dxDrawText("wasted", x-3, y+3, x-3, y+3, tocolor(0,0,0,255), 3, "pricedown", "center", "center")
		dxDrawText("wasted", x+3, y-3, x+3, y-3, tocolor(0,0,0,255), 3, "pricedown", "center", "center")
		dxDrawText("wasted", x-3, y-3, x-3, y-3, tocolor(0,0,0,255), 3, "pricedown", "center", "center")
			dxDrawText("wasted", x, y, x, y, tocolor(230,60,70,255), 3, "pricedown", "center", "center")
	end

		-- Draw Outer Fade
	dxDrawImage(0, 0, size, size, "player/files/death_corners.png", 0, 0, 0, tocolor(255,255,255,a1))
	dxDrawImage(sX-size, 0, size, size, "player/files/death_corners.png", 90, 0, 0, tocolor(255,255,255,a1))
	dxDrawImage(sX-size, sY-size, size, size, "player/files/death_corners.png", 180, 0, 0, tocolor(255,255,255,a1))
	dxDrawImage(0, sY-size, size, size, "player/files/death_corners.png", 270, 0, 0, tocolor(255,255,255,a1))
end
