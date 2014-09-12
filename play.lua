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

local image, text1, text2, text3

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		storyboard.gotoScene( "home", "slideRight", 400  )
		
		return true
	end
end

local homeButtonPress = function( event )
	print("Home button pressed")
	storyboard.gotoScene( "home", "slideRight", 400  )
end

local easyButtonPress = function( event )
	print("Start button pressed")
	storyboard.gotoScene( "easyComp", "slideLeft", 400  )
end

local mediButtonPress = function( event )
	print("Settings button pressed")
end

local hardButtonPress = function( event )
	print("Settings button pressed")
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view

	display.setDefault( "anchorX", 0.0 )	-- default to TopLeft anchor point for new objects
	display.setDefault( "anchorY", 0.0 )
	
	playText = display.newText( "Play", centerX-15, 50, native.systemFontBold, 24 )
	playText:setFillColor( 1 )

	easyButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Easy",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = easyButtonPress,
	}
	mediButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Medium",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = mediButtonPress,
	}
	hardButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Hard",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = mediButtonPress,
	}
	homeButton = widget.newButton
	{
		id = "arrow",
		defaultFile = "buttonArrow.png",
		overFile = "buttonArrowOver.png",
		onEvent = homeButtonPress,
	}


		-- Position the buttons on screen
	easyButton.x = display.contentCenterX - easyButton.contentWidth/2;	easyButton.y = 305
	mediButton.x =  display.contentCenterX - mediButton.contentWidth/2;	mediButton.y = 370
	hardButton.x =  display.contentCenterX - hardButton.contentWidth/2;	hardButton.y = 435
	homeButton.x = 0;	homeButton.y = 0

	screenGroup:insert( playText )
	screenGroup:insert(easyButton)
	screenGroup:insert(mediButton)
	screenGroup:insert(hardButton)
	screenGroup:insert(homeButton)
	print( "\n2: createScene event" )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "2: enterScene event" )
	storyboard.removeAll()
	-- remove previous scene's view
	storyboard.purgeScene( "home" )
	
	-- Update Lua memory text display
end


-- Called when scene is about to move offscreen:
function scene:exitScene()
	
	print( "2: exitScene event" )
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