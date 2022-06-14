
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

piece_width = display.contentWidth*0.8
piece_height = display.contentHeight*0.15
piece_position_x = display.contentCenterX
piece_position_y = display.contentCenterY - display.contentHeight*0.3


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
        local best_time = display.newImageRect("button-timer.png", piece_width, piece_height)
        local best_score = display.newImageRect("button-timer.png", piece_width, piece_height)

        -- labels de informações
        --if(composer.getVariable("time") ~= nil) then
         --   local time_label = display.newText("Tempo: "..composer.getVariable("time"), 0, 0, native.systemFont, 20)
           -- local score_label = display.newText("Score: "..composer.getVariable("score"), 0, 0, native.systemFont, 20)
           -- local best_score_label = display.newText("Melhor score: "..composer.getVariable("score"), 0, 0, native.systemFont, 20)
        --else
            local time_label = display.newText("Tempo: 00:00", 0, 0, native.systemFont, 20)
            local score_label = display.newText("Score: 100", 0, 0, native.systemFont, 20)
            local best_time_label = display.newText("Melhor Tempo: 00:00", 0, 0, native.systemFont, 20)
            local best_score_label = display.newText("Melhor Score: 100", 0, 0, native.systemFont, 20)
        --end
        
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

        local best_time_container = display.newContainer(piece_width,piece_height)
        best_time_container:insert(best_time, true)
        best_time_container:insert(best_time_label, true)
        best_time_container.x = piece_position_x
        best_time_container.y = score_container.y + score_container.height

        local best_sc_container =  display.newContainer(piece_width,piece_height)
        best_sc_container:insert(best_score, true)
        best_sc_container:insert(best_score_label, true)
        best_sc_container.x = piece_position_x
        best_sc_container.y = best_time_container.y + best_time_container.height

        local new_game_img = display.newImageRect("button-restart.png",display.contentWidth*0.4, display.contentHeight*0.07)
        btn_text = display.newText("Novo Jogo", 0, 0, native.systemFontBold, 18)
        btn_text:setFillColor(1)
        btn_new_game_container = display.newContainer(new_game_img.width, new_game_img.height)
        btn_new_game_container:insert(new_game_img, true)
        btn_new_game_container:insert(btn_text, true)
        btn_new_game_container.x = piece_position_x
        btn_new_game_container.y = best_sc_container.y + best_sc_container.height

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
