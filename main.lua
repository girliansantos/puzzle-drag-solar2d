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

local tabuleiro = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.8)
tabuleiro:setFillColor(0.8)
tabuleiro.stroke = {0.5882, 0.2941, 0}
tabuleiro.strokeWidth = 5

local containers = util:getItems()
-- pegar as variáveis do util e preencher com os conteiners o label.