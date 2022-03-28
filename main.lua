-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local util = require("util")
local core = require("core")

local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY

-- cria o tabuleiro
local tabuleiro = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.8)
tabuleiro:setFillColor(0.8)
tabuleiro.stroke = {0.5882, 0.2941, 0}
tabuleiro.strokeWidth = 5

-- cria e distribui as peças do jogo
local containers = util:getItems()

-- toda lógica do jogo
function onTouch(event)
    if(event.phase == "began") then
        print('COMEÇOU')
    elseif(event.phase == "ended") then
        print('ACABOU')
    end
end

-- adiciona eventos aos itens
for i=1, #containers do
    containers[i]:addEventListener('touch', onTouch)
end