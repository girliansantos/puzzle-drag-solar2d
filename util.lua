
local numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
local tabuleiroWidth = display.contentWidth * 0.8
local tabuleiroHeight = display.contentHeight * 0.8
local pieceWidth = tabuleiroWidth/4
local pieceHeight = tabuleiroHeight/5
local firstContainerPosX = display.contentCenterX - 0.30 * display.contentWidth
local firstContainerPosY = display.contentCenterY - 0.32*display.contentHeight
local positionContinerX = firstContainerPosX
local positionContinerY = firstContainerPosY
local position = 1
local textos = {}
local rects = {}

local util = {numbers, pieceWidth, pieceHeight}

function util.shuffle()
    local array = numbers
    for i = #array, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
      end
    textos = array
end

function util.getRects()
    for i = 1, 19, 1 do
        rects[i] = display.newRect(0, 0, pieceWidth,pieceHeight);
        rects[i].stroke = {0.3, 0.2, 0.2}
        rects[i].strokeWidth = 3
    end
end

function util.getItems()
    util:shuffle()
    util:getRects()
    local containers = {}
    local text = ''
    for i = 1, #rects do
        local cont = display.newContainer(pieceWidth, pieceHeight)
        text = display.newText(textos[i], 0, 0, 0, 0)
        text:setFillColor(0,0,0)
        cont:insert(rects[i], true)
        cont:insert(text, true)
        cont.id = textos[i]
        containers[i] = cont
        --containers[i]:insert(rects[i], true)
        --containers[i]:insert(textos[i], true)
        containers[i]:translate(positionContinerX, positionContinerY)
        if position == 4 then
            position = 1
            positionContinerX = firstContainerPosX
            positionContinerY = positionContinerY + pieceHeight
        else
            position = position + 1
            positionContinerX = positionContinerX + pieceWidth
        end
    end
    return containers
end

return util