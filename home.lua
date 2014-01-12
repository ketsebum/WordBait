--
-- Project: Word Bait
--
-- Date: January 12, 2014
--
-- Version: .01
--
-- File name: home.lua
--
-- Author: Sean Nunley
--
-- Abstract: Front for new game

-- File dependencies:
--
---------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-------------------------------------------
-- *** Buttons Presses ***
-------------------------------------------

--Start Button Pressed
local startButtonPress = function( event )
	print("Start button pressed")
	storyboard.gotoScene( "scene2", "slideLeft", 800  )
end

local settingsButtonPress = function( event )
	print("Settings button pressed")
end

local standingsButtonPress = function( event )
	print("Standings button pressed")
end

-- Note: currently this feature works in device builds or Xcode simulator builds only (also works on Corona Mac Simulator)
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

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view

    -- Require the widget library
	local widget = require( "widget" )
	local tHeight		-- forward reference

	display.setDefault( "anchorX", 0.0 )	-- default to TopLeft anchor point for new objects
	display.setDefault( "anchorY", 0.0 )

    -----------------------------------------------------------------------------

    --  CREATE display objects and add them to 'group' here.
    --  Example use-case: Restore 'group' from previously saved state.

    -----------------------------------------------------------------------------

	display.setDefault( "background", 80/255 )
	local title = display.newText( "Word Bait", 50, 35, native.systemFont, 50 )
	title:setFillColor( 170/255, 170/255, 1 )

    -------------------------------------------
	-- *** Create Buttons ***
	-------------------------------------------

	-- "Remove Default" Button
	startButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Start",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = startButtonPress,
	}

	-- "Remove Number" Button
	settingsButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Settings",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = settingsButtonPress,
	}


	standingsButton = widget.newButton
	{
		defaultFile = "buttonBlue.png",
		overFile = "buttonBlueOver.png",
		label = "Global Standings",
		labelColor = 
		{ 
			default = { 1, 1, 1 }, 
		},
		fontSize = 20,
		emboss = true,
		onPress = standingsButtonPress,
	}

	-- Position the buttons on screen
	startButton.x = display.contentCenterX - startButton.contentWidth/2;	startButton.y = 305
	settingsButton.x =  display.contentCenterX - settingsButton.contentWidth/2;	settingsButton.y = 370
	standingsButton.x =  display.contentCenterX - standingsButton.contentWidth/2;	standingsButton.y = 435

	--Adding objects into the "group"
	--When scene ends, these items disappear
	group:insert(title)
	group:insert(startButton)
	group:insert(settingsButton)
	group:insert(standingsButton)

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    print("entered")

    -----------------------------------------------------------------------------

    --  INSERT code here (e.g. start timers, load audio, start listeners, etc.)

    -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    print("exit")

    display.setDefault( "anchorX", 0.5 )	-- default to TopLeft anchor point for new objects
	display.setDefault( "anchorY", 0.5 )
    -----------------------------------------------------------------------------

    --  INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

    -----------------------------------------------------------------------------
    startButton = nil
    settingsButton = nil
    standingsButton = nil
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local group = self.view
    print( "destroying")

    -----------------------------------------------------------------------------

    --  INSERT code here (e.g. remove listeners, widgets, save state, etc.)

    -----------------------------------------------------------------------------

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