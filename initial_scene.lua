local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

end

function scene:show( event )

    local sceneGroup = self.view
	local phase = event.phase

    if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
        local background = display.newImageRect("background.jpg", display.contentWidth,display.contentHeight)
        background.x = display.contentCenterX
        background.y = display.contentCenterY
    end
end

function scene:hide(event)
    local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
        composer.removeScene(scene)
	end
end

function scene:destroy(event)
    local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene