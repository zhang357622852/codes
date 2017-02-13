--[[
    全局吐司 --位于场景的最高层  
    同一个toast不会重叠创建，不同的toast会重叠创建
    大多游戏都是这种方案
    ###推荐用这种方案###
--]]

module("Toast3", package.seeall)

local toast = {}

function create(text)
    if type(text)=="string" or type(text)=="number" then
        if not toast[text] then
            local toastNode = cc.Node:create()
            toastNode:setPosition(GAME_GLOBAL_SCREE_WIDTH/2, GAME_GLOBAL_SCREE_HEGHT/2-GAME_GLOBAL_TOAST_MOVE_DIS)
            cc.Director:getInstance():getRunningScene():addChild(toastNode, GAME_GLOBAL_TOAST_ZORDER)
            toast[text] = toastNode
    
            local label = cc.Label:createWithSystemFont(text, "Arial", 24) --text
            local bg = ccui.Scale9Sprite:create("common/cm_tips_bg.png") --bg
            bg:setContentSize(label:getContentSize().width+40, label:getContentSize().height/2+25)
    
            toastNode:setAnchorPoint(cc.p(0.5, 0.5))
            toastNode:setContentSize(bg:getContentSize())
    
            bg:setPosition(toastNode:getContentSize().width/2, toastNode:getContentSize().height/2)
            toastNode:addChild(bg, 1)
    
            label:setPosition(bg:getContentSize().width/2, bg:getContentSize().height/2)
            toastNode:addChild(label, 2)
    
            local function callback_fadeOut()
                bg:runAction(cc.FadeOut:create(0.5))
                label:runAction(cc.FadeOut:create(0.5))
            end
   
            local arr = {}
            arr[#arr+1] = cc.MoveBy:create(0.1, cc.p(0, GAME_GLOBAL_TOAST_MOVE_DIS))
            arr[#arr+1] = cc.DelayTime:create(1)
            arr[#arr+1] = cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(0, GAME_GLOBAL_TOAST_MOVE_DIS)), cc.CallFunc:create(callback_fadeOut))
            arr[#arr+1] = cc.CallFunc:create(function() toastNode:removeFromParent() toastNode=nil toast[text]=nil end)
    
            toastNode:runAction(cc.Sequence:create(arr))
        end
    else
        print("Toast'text not is string or number!!")
    end
end