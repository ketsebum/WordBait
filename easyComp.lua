---------------------------------------------------------------------------------
--
-- scene2.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local widget = require( "widget" ) -- Require the widget library
local tHeight		-- forward reference
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local defaultField, text1, text2, text3, memTimer

local centerX = display.contentCenterX
local centerY = display.contentCenterY

local isAndroid = "Android" == system.getInfo("platformName")
local inputFontSize = 18
local inputFontHeight = 30
tHeight = 30

if isAndroid then
	-- Android text fields have more chrome. It's either make them bigger, or make the font smaller.
	-- We'll do both
	inputFontSize = 14
	inputFontHeight = 42
	tHeight = 40
end

local submitButtonPress = function( event )
	print("Home button pressed")
	storyboard.gotoScene( "home", "slideRight", 400  )
end

local homeButtonPress = function( event )
	print("Home button pressed")
	storyboard.gotoScene( "home", "slideRight", 400  )
end

local backButtonPress = function( event )
	print("Back button pressed")
	storyboard.gotoScene( "play", "slideRight", 400  )
end


local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			print( textField().text )
			
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	local fields = display.newGroup()

	defaultField = native.newTextField( 50, 50, 180, tHeight )
	defaultField.font = native.newFont( native.systemFontBold, inputFontSize )
	defaultField:addEventListener( "userInput", fieldHandler( function() return defaultField end ) ) 
	
	playText = display.newText( "Enter your word", centerX-70, 0, native.systemFontBold, 24 )
	playText:setFillColor( 1 )

	homeButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Home",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = homeButtonPress,
	}
	submitButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Submit",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = submitButtonPress,
	}
	backButton = widget.newButton
	{
		id = "arrow",
		defaultFile = "buttonArrow.png",
		overFile = "buttonArrowOver.png",
		onEvent = backButtonPress,
	}

	submitButton.x =  display.contentCenterX - submitButton.contentWidth/2;	submitButton.y = 370
	homeButton.x = display.contentCenterX - homeButton.contentWidth/2;	homeButton.y = 435
	backButton.x = 0;	backButton.y = 0

	--fields:insert(defaultField)
	screenGroup:insert(defaultField)
	screenGroup:insert( homeButton )
	screenGroup:insert( backButton )
	screenGroup:insert( submitButton )
	screenGroup:insert( playText )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "2: enterScene event" )
	storyboard.removeAll()
	-- remove previous scene's view
	storyboard.purgeScene( "play" )
	
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