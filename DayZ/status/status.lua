local sx, sy = guiGetScreenSize()

-- Render
------------>>

addEventHandler("onClientRender", root, function()
	drawStatus(100)
end)

-- Draw Status
----------------->>

function drawStatus(view)
	dxDrawImage(sx*0.89, sy*0.63, sx*0.1, sx*0.1, "status/images/bg.png")
	dxDrawImage(sx*0.89, sy*0.63, sx*0.1, sx*0.1, "status/images/fill.png")
	dxDrawImage(sx*0.91, sy*0.65, sx*0.06, sx*0.06, "status/images/eye.png")
end
