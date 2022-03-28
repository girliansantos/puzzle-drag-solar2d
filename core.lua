-- módulo a exportar
local core = {}
-- posições ativas para movimentar peças no jogo
local piecesPositionActive = {}
-- itens do jogo, todos os containers
local items = {}
-- inicializa as variáveis locais
function core.initialize(i)
    core.items = i
end

-- callback function para o toque
function core.onTouch( event )
    if event.phase == "began" then
        print('EVENTO FUNFANDO DE BOUAS')
    elseif event.phase == "ended" then
        print('JÁ ERAS, TUDO CERTO')
    end
end

-- adiciona eventos de toque para todas as peças
function core.addEvents(c)
    print(c)
    for i=1, #c do
        c[i]:addEventListener("touch", onTouch)
    end
end

return core