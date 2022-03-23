
local numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
local pieceWidth = display.contentWidth/4
local pieceHeight = display.contentHeight/6
local firstContainerPosX = display.contentCenterX - 0.29 * display.contentWidth
local firstContainerPosY = display.contentCenterY - 0.325*display.contentHeight

local util = {numbers, pieceWidth, pieceHeight}

function util.shuffle(array)
    for i = #array, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
      end
    return array
end

function util.getRects(array)
    local rects = {}
    for i, v in array do
        rects[i] = display.newRect(0, 0, pieceWidth,pieceHeight);
        rects[i].stroke = {0.3, 0.2, 0.2}
        rects[i].strokeWidth = 3
    end
    return rects
end

function util.getItems(pieces, texts)
    local containers = {}
    for i, v in pieces do
        containers[i] = display.newContainer(pieceWidth, pieceHeight);
        containers[i]:insert(v)
        containers[i]:insert(texts[i])
    end
    return containers
end

return util