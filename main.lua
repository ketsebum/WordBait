--
-- Project: Word Bait
--
-- Date: January 12, 2014
--
-- Version: .01
--
-- File name: main.lua
--
-- Author: Sean Nunley
--
-- Abstract: Front for new game

-- File dependencies:
--
---------------------------------------------------------------------------------------
-- Require the widget library
display.setStatusBar( display.HiddenStatusBar )

-- require controller module
local storyboard = require "storyboard"
local widget = require "widget"

-- load first scene
storyboard.gotoScene( "home", "fade", 400 )