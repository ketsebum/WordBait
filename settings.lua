---------------------------------------------------------------------------------
--
-- scene2.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local image, text1, text2, text3, memTimer

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		storyboard.gotoScene( "home", "slideRight", 400  )
		
		return true
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	image = display.newImage( "bg3.jpg", centerX, centerY )
	screenGroup:insert( image )
	
	image.touch = onSceneTouch
	
	text1 = display.newText( "Settings", centerX, 50, native.systemFontBold, 24 )
	text1:setFillColor( 1 )
	screenGroup:insert( text1 )
	
	text2 = display.newText( "MemUsage: ", centerX, centerY, native.systemFont, 16 )
	text2:setFillColor( 1 )
	screenGroup:insert( text2 )
	
	text3 = display.newText( "Touch to continue.", centerX, display.contentHeight - 100, native.systemFontBold, 18 )
	text3:setFillColor( 1 ); text3.isVisible = false
	screenGroup:insert( text3 )
	
	print( "\n2: createScene event" )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "2: enterScene event" )
	storyboard.removeAll()
	-- remove previous scene's view
	storyboard.purgeScene( "home" )
	
	-- Update Lua memory text display
	local showMem = function()
		image:addEventListener( "touch", image )
		text3.isVisible = true
		text2.text = text2.text .. collectgarbage("count")/1000 .. "MB"
		text2.x = centerX
	end
	memTimer = timer.performWithDelay( 1000, showMem, 1 )
end


-- Called when scene is about to move offscreen:
function scene:exitScene()
	
	print( "2: exitScene event" )
	
	-- remove touch listener for image
	image:removeEventListener( "touch", image )
	
	-- cancel timer
	timer.cancel( memTimer ); memTimer = nil;
	
	-- reset label text
	text2.text = "MemUsage: "
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 2's view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene