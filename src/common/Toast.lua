--[[
    重叠吐司 --位于场景的最高层  
    缺点:出现重叠现象
--]]

Toast = class("Toast", function() return cc.Node:create() end)

------------------------------------
--@param: text-可以是string类型和number类型，其他暂不支持
function Toast.create(text)
    local node = Toast.new()
    node:initToast(text)
    
    return node
end

function Toast:ctor()
end

function Toast:initToast(text)   
    if type(text)=="string" or type(text)=="number" then
        self:setPosition(GAME_GLOBAL_SCREE_WIDTH/2, GAME_GLOBAL_SCREE_HEGHT/2-GAME_GLOBAL_TOAST_MOVE_DIS)
        cc.Director:getInstance():getRunningScene():addChild(self, GAME_GLOBAL_TOAST_ZORDER)
    
        local label = cc.Label:createWithSystemFont(text, "Arial", 24)
            
        local bg = ccui.Scale9Sprite:create("common/cm_tips_bg.png")
        bg:setContentSize(label:getContentSize().width+40, label:getContentSize().height/2+25)
        
        self:setAnchorPoint(cc.p(0.5, 0.5))
        self:setContentSize(bg:getContentSize())
        
        bg:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
        self:addChild(bg, 1)
        
        label:setPosition(bg:getContentSize().width/2, bg:getContentSize().height/2)
        self:addChild(label, 2)
        
        local function callback_fade()
            bg:runAction(cc.FadeOut:create(0.6))
            label:runAction(cc.FadeOut:create(0.6))
        end
        
        local arr = {}
        arr[#arr+1] = cc.DelayTime:create(1.3)
        arr[#arr+1] = cc.Spawn:create(cc.MoveBy:create(0.6, cc.p(0, GAME_GLOBAL_TOAST_MOVE_DIS)), cc.CallFunc:create(callback_fade))
        arr[#arr+1] = cc.CallFunc:create(function() self:removeFromParent() self=nil end)
        
        self:runAction(cc.Sequence:create(arr))
        
    else
        print("Toast'text not is string or number!!")
    end  
end