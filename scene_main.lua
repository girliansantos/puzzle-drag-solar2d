-- Your code here
local util = require("util")
local core = require("core")
local composer = require("composer");

local scene_main = composer.newScene()

-- criação da cena principal
function scene_main:create(event)
    local sceneGroup = self.view

        -- sons do jogo
    slash = audio.loadSound("slash.mp3")
    -- local finish = audio.loadSound("finish.mp3")
    sucess = audio.loadSound("sucess-trumpet.mp3")
    alert = audio.loadSound("notification.mp3")

    positions_active = {}

    empty_pos = 16

    moves = 0

    velocity = 100

    start = true

    --local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    local background = display.newImageRect("background.jpg",display.contentWidth,display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

        -- cria o tabuleiro
    --local tabuleiro = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.6)
    tabuleiro = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.6, 4)
    tabuleiro:setFillColor(0.8)
    tabuleiro.stroke = {0, 0, 0.3}
    tabuleiro.strokeWidth = 5

    -- Timer para cronometrar o jogo
    timerCount = display.newText("00:00", 0,  0, native.systemFont, 25)
    timerCount:setFillColor(1)

    -- container para cronômetro
    timer_image = display.newImageRect("button-timer.png",display.contentWidth*0.4,display.contentHeight*0.1)
    timer_container = display.newContainer(200, 80)
    timer_container:insert(timer_image, true)
    timer_container:insert(timerCount, true)
    timer_container:translate(display.contentCenterX- 0.28*tabuleiro.width, display.contentCenterY - 0.6 * tabuleiro.height)
    clockTimer = {}

    -- view para mostrar quantidade de movimentos
    movesView = display.newText(moves, 0, 0, native.systemFontBold, 25)
    movesView:setFillColor(1)

    -- container para movimentos
    moves_img = display.newImageRect("button-timer.png", display.contentWidth*0.3, display.contentHeight*0.1)
    moves_container = display.newContainer(moves_img.width, moves_img.height)
    moves_container:insert(moves_img, true)
    moves_container:insert(movesView, true)
    moves_container:translate(timer_container.x+display.contentWidth*0.5, timer_container.y)

    -- container para botão de reiniciar jogo
    btn_restart_img = display.newImageRect("button-restart.png",display.contentWidth*0.4,display.contentHeight*0.07)
    btn_text = display.newText("Recomeçar", 0, 0, native.systemFontBold, 18)
    btn_text:setFillColor(1)
    btn_restart_container = display.newContainer(btn_restart_img.width, btn_restart_img.height)
    btn_restart_container:insert(btn_restart_img, true)
    btn_restart_container:insert(btn_text, true)
    btn_restart_container:translate(tabuleiro.x, tabuleiro.y + display.contentHeight*0.42)

    -- cria e distribui as peças do jogo
    containers = util:getItems()

end

function scene_main:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if(phase == "will") then
    elseif(phase == "did")then
        add_events()
        inicializa_positions()
    end
end

function scene_main:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        composer.removeScene(scene_main)
    end
end

function scene_main:destroy(event)
    local sceneGroup = self.view
    -- code here
    for i=1, #containers do
        display.remove(containers[i])
        containers[i].removeSelf()
    end
    display.remove(moves_container)
    display.remove(timer_container)
    display.remove(background)
    moves_img.removeSelf()
    movesView.removeSelf()
    moves_container.removeSelf()
end

-- função para iniciar o cronômetro
function startTimer(e)
    function timerCount:timer(event)
        local count = event.count
        segundos = math.floor(count/10)
        segundos = math.floor(segundos % 60)
        minutos = math.floor(count/600)
        minutos = math.floor(minutos % 60)
    
        padraoTexto = string.format("%02d:%02d",minutos, segundos)
        timerCount.text = padraoTexto
    end
    clockTimer = timer.performWithDelay(100,timerCount,-1)
end

-- função para parar o cronômetro
function stopTimer()
    timer.cancel(clockTimer)
end

-- função para incrementar os movimentos e atualizar a tela
function movesPlus()
    moves = moves +1
    movesView.text = moves
end

-- função para mover a peça para direita
function move_rigth(pos)
    for i=1, #containers do
        if containers[i].id == pos then
            transition.moveTo(containers[i],{x = containers[i].x + util.pieceWidth, y = containers[i].y, time = velocity})
            containers[i].id = pos+1
            movesPlus()
            audio.play(slash)
        end
    end
    game()
end

-- função para mover a peça para esquerda
function move_left(pos)
    for i=1, #containers do
        if containers[i].id == pos then
            transition.moveTo(containers[i],{x = containers[i].x - util.pieceWidth, y = containers[i].y, time = velocity});
            containers[i].id = pos-1
            movesPlus()
            audio.play(slash)
        end
    end
    game()
end

-- função para mover a peça para baixo
function move_down(pos)
    for i=1, #containers do
        if containers[i].id == pos then
            transition.moveTo(containers[i], {x = containers[i].x, y = containers[i].y + util.pieceHeight, time = velocity})
            containers[i].id = pos+4
            movesPlus()
            audio.play(slash)
        end
    end
    game()
end

-- função para mover a peça para cima
function move_up(pos)
    for i=1, #containers do
        if containers[i].id == pos then
            transition.moveTo(containers[i], {x = containers[i].x, y = containers[i].y - util.pieceHeight, time = velocity})
            containers[i].id = pos-4
            movesPlus()
            audio.play(slash)
        end
    end
    game()
end

-- função central que coordena os movimentos das peças
function move(pos)
    if(positions_active[pos] == 1)then
        previous_pos = empty_pos
        empty_pos = pos
        if(pos == previous_pos - 1) then
            move_rigth(pos)
        elseif(pos == previous_pos + 1)then
            move_left(pos)
        elseif(pos == previous_pos - 4)then
            move_down(pos)
        elseif(pos == previous_pos + 4)then
            move_up(pos)
        end
        for i=1, #positions_active do
            positions_active[i] = 0
        end 
        if(empty_pos - 4 > 0)then
            positions_active[empty_pos-4] = 1
        end
        if(empty_pos + 4 <= 16)then
            positions_active[empty_pos+4] = 1
        end
        if((empty_pos - 1 > 0) and ((empty_pos - 1) % 4 ~= 0))then
            positions_active[empty_pos-1] = 1
        end
        if((empty_pos + 1 <= 16) and ((empty_pos + 1) % 4 ~= 1))then
            positions_active[empty_pos+1] = 1
        end    
    end
end

function game()
    --verifica se o jogo está ganho, ou seja, se todas as posições estão corretas
    won = true
    for i=1, #containers do
        if(containers[i].id ~= tonumber(containers[i].value,10)) then
           won = false 
           break 
        end
    end

    if(won) then
        audio.play(sucess)
        stopTimer()
        endGame()
    end
end

-- toda lógica do jogo
function onTouch(self, event)
    if(event.phase == "began") then
        move(self.id)
        if(start) then
            startTimer()
            start = false
        end
    elseif(event.phase == "ended") then
        -- fazer algo se necessário
    end
end

-- função a acionar quando clicar no botão para recomeçar jogo
function onRestart(event)
    if(event.phase == "began") then
        -- mostrar alerta antes de fazer qualquer coisa
        audio.play(alert)
        native.showAlert("Reiniciar Jogo","Tem certeza que deseja recomeçar?",{"Não", "Sim"},onComplete)
    end
end

function endGame()
    composer.setVariable("score",moves)
    composer.setVariable("time",timerCount.text)
    composer.gotoScene("highscore", {time = 2000, effect="crossFade"})
end

function onComplete(event)
    if ( event.action == "clicked" ) then
        local i = event.index
        if ( i == 1 ) then
            -- Do nothing; dialog will simply dismiss
        elseif ( i == 2 ) then
            for i=1, #containers do
                containers[i]:removeSelf()
            end
            containers = util:getItems()
            positions_active = {}
            empty_pos = 16
            moves = 0
            movesView.text = moves
            add_events()
            inicializa_positions()
            --zera cronômetro
            if(clockTimer ~= nil) then
                stopTimer()
            end
            start = true
            timerCount.text = "00:00"
        end
    end
end

function inicializa_positions()
    -- inicia posições válidas para toque nos itens
    for i=1, #containers+1 do
        positions_active[i] = 0
    end
    positions_active[empty_pos-1] = 1
    positions_active[empty_pos-4] = 1
end

-- adiciona eventos aos itens
function add_events()
    for i=1, #containers do
        if(containers[i] ~= nil) then
            containers[i].touch = onTouch
            containers[i]:addEventListener('touch', containers[i])
        end
    end
    btn_restart_container:addEventListener('touch', onRestart)
    system.deactivate("multitouch");
end

-- eventos da cena
scene_main:addEventListener("create", create)
scene_main:addEventListener("show", show)
scene_main:addEventListener("hide", hide)
scene_main:addEventListener("destroy", destroy)

return scene_main