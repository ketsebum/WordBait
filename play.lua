---------------------------------------------------------------------------------
--
-- scene2.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" ) -- Require the widget library
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

local compButtonPress = function( event )
	print("Start button pressed")
end

local multiButtonPress = function( event )
	print("Settings button pressed")
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view

	image = display.newImage( "bg2.jpg", centerX, centerY )
	image.touch = onSceneTouch

	display.setDefault( "anchorX", 0.0 )	-- default to TopLeft anchor point for new objects
	display.setDefault( "anchorY", 0.0 )
	
	playText = display.newText( "Play", centerX, 50, native.systemFontBold, 24 )
	playText:setFillColor( 1 )

	compButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Solo Play",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = compButtonPress,
	}
	multiButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Multiplayer",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = multiButtonPress,
	}

		-- Position the buttons on screen
	compButton.x = display.contentCenterX - compButton.contentWidth/2;	compButton.y = 305
	multiButton.x =  display.contentCenterX - multiButton.contentWidth/2;	multiButton.y = 370
	
	screenGroup:insert( image )
	screenGroup:insert( playText )
	screenGroup:insert(compButton)
	screenGroup:insert(multiButton)
	print( "\n2: createScene event" )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "2: enterScene event" )
	storyboard.removeAll()
	-- remove previous scene's view
	storyboard.purgeScene( "home" )
	image:addEventListener( "touch", image )
	
	-- Update Lua memory text display
end


-- Called when scene is about to move offscreen:
function scene:exitScene()
	
	print( "2: exitScene event" )
	
	-- remove touch listener for image
	image:removeEventListener( "touch", image )
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