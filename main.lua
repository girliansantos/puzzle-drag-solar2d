-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local util = require("util")
local core = require("core")

-- sons do jogo
local slash = audio.loadSound("slash.mp3");
local finish = audio.loadSound("finish.mp3");

local positions_active = {}

local empty_pos = 16

local moves = 0

local velocity = 100

local start = true

local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY

-- cria o tabuleiro
local tabuleiro = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.6)
tabuleiro:setFillColor(0.8)
tabuleiro.stroke = {0.5882, 0.2941, 0}
tabuleiro.strokeWidth = 5

-- Timer para cronometrar o jogo
local timerCount = display.newText("00:00", display.contentCenterX- 0.38*tabuleiro.width, display.contentCenterY - 0.55 * tabuleiro.height , native.systemFont, 25)
timerCount:setFillColor(0)
local clockTimer

local movesLabel = display.newText("Moves: ", timerCount.x+ 0.57*tabuleiro.width, timerCount.y, native.systemFont, 25);
movesLabel:setFillColor(0)

-- view para mostrar quantidade de movimentos
local movesView = display.newText(moves, movesLabel.x+ 0.65*movesLabel.width, timerCount.y, native.systemFont, 25)
movesView:setFillColor(0)

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

-- cria e distribui as peças do jogo
local containers = util:getItems()

-- função para incrementar os movimentos e atualizar a tela
function movesPlus()
    moves = moves +1
    movesView.text = moves
end

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
        audio.play(finish);
        native.showAlert("YOU WON","GANHOU PESTE!!!");
        stopTimer()
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

function inicializa_positions()
    positions_active[empty_pos-1] = 1
    positions_active[empty_pos-4] = 1
end

-- inicia posições válidas para toque nos itens
for i=1, #containers+1 do
    positions_active[i] = 0
end
-- adiciona eventos aos itens
function add_events()
    for i=1, #containers do
        if(containers[i] ~= nil) then
            containers[i].touch = onTouch
            containers[i]:addEventListener('touch', containers[i])
        end
    end
    system.deactivate("multitouch");
end

add_events()

inicializa_positions()