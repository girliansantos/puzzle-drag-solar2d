
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

piece_width = display.contentWidth*0.8
piece_height = display.contentHeight*0.15
piece_position_x = display.contentCenterX
piece_position_y = display.contentCenterY - display.contentHeight*0.2


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
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

        -- imagens para mostrar informações
        local time = display.newImageRect("button-timer.png", piece_width, piece_height)
        local score = display.newImageRect("button-timer.png", piece_width, piece_height)
        local best_score = display.newImageRect("button-timer.png", piece_width, piece_height)

        -- labels de informações
        local time_label = display.newText("Tempo: "..composer.getVariable("time"), 0, 0, native.systemFont, 20)
        local score_label = display.newText("Score: "..composer.getVariable("score"), 0, 0, native.systemFont, 20)
        local best_score_label = display.newText("Melhor score: "..composer.getVariable("score"), 0, 0, native.systemFont, 20)
        
        -- containers para inserir os itens na tela
        local timer_container = display.newContainer(piece_width, piece_height)
        timer_container:insert(time, true)
        timer_container:insert(time_label, true)
        timer_container.x = piece_position_x
        timer_container.y = piece_position_y

        local score_container = display.newContainer(piece_width,piece_height)
        score_container:insert(score, true)
        score_container:insert(score_label, true)
        score_container.x = piece_position_x
        score_container.y = timer_container.y + timer_container.height

        local best_sc_conteinar =  display.newContainer(piece_width,piece_height)
        best_sc_conteinar:insert(best_score, true)
        best_sc_conteinar:insert(best_score_label, true)
        best_sc_conteinar.x = piece_position_x
        best_sc_conteinar.y = score_container.y + score_container.height

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
        composer.removeScene(scene)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
