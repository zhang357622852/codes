--[[
    全局吐司 --位于场景的最高层
    缺点是：每次点击都执行removeFromParent
--]]

module("Toast2", package.seeall)

local toastNode = nil

function create(text)
    if toastNode then
        toastNode:removeFromParent()
        toastNode = nil
    end
    toastNode = cc.Node:create()
    toastNode:setPosition(GAME_GLOBAL_SCREE_WIDTH/2, GAME_GLOBAL_SCREE_HEGHT/2)
    cc.Director:getInstance():getRunningScene():addChild(toastNode, GAME_GLOBAL_TOAST_ZORDER)

    local label = cc.Label:createWithSystemFont(text, "Arial", 24) --text

    local bg = ccui.Scale9Sprite:create("common/cm_tips_bg.png") --bg
    bg:setContentSize(label:getContentSize().width+40, label:getContentSize().height/2+25)

    toastNode:setAnchorPoint(cc.p(0.5, 0.5))
    toastNode:setContentSize(bg:getContentSize())

    bg:setPosition(toastNode:getContentSize().width/2, toastNode:getContentSize().height/2)
    toastNode:addChild(bg, 1)

    label:setPosition(bg:getContentSize().width/2, bg:getContentSize().height/2)
    toastNode:addChild(label, 2)

    local function callback_fade()
        bg:runAction(cc.FadeOut:create(0.6))
        label:runAction(cc.FadeOut:create(0.6))
    end

    local arr = {}
    arr[#arr+1] = cc.DelayTime:create(1.3)
    arr[#arr+1] = cc.Spawn:create(cc.MoveBy:create(0.6, cc.p(0, GAME_GLOBAL_TOAST_MOVE_DIS)), cc.CallFunc:create(callback_fade))
    arr[#arr+1] = cc.CallFunc:create(function() toastNode:removeFromParent() toastNode=nil end)

    toastNode:runAction(cc.Sequence:create(arr))
end
