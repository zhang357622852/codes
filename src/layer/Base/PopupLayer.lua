--[[
             弹窗效果，进入放大，退出缩小
--]]

PopupLayer = class("PopupLayer", function() return BaseLayer.create() end)

function PopupLayer.create()
    local layer = PopupLayer.new()

    return layer
end

function PopupLayer:ctor()
    self:setAnchorPoint(cc.p(0.5, 0.5))
end

function PopupLayer:addto(parent, zorder, tag)
    local zorder, tag = zorder or 0, tag or 0

    if not parent then
        parent = cc.Director:getInstance():getRunningScene()
    end
    
    self:setScale(0.1)
    parent:addChild(self, zorder, tag)
    self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2,1.1),cc.ScaleTo:create(0.1,1)))

    if self._shield then--屏蔽下层消息
        local node = cc.Node:create()
        node:setContentSize(GAME_GLOBAL_SCREE_WIDTH, GAME_GLOBAL_SCREE_HEGHT)
        node:setAnchorPoint(cc.p(0, 0))

        local menuItem = cc.MenuItemSprite:create(node, node, node)

        local menu = cc.Menu:create(menuItem)
        menu:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
        menu:setContentSize(GAME_GLOBAL_SCREE_WIDTH, GAME_GLOBAL_SCREE_HEGHT)
        self:addChild(menu, -10000)

        if self._mask then --蒙版
            local scale9 = ccui.Scale9Sprite:create(self._maskStr)
            scale9:setContentSize(GAME_GLOBAL_SCREE_WIDTH, GAME_GLOBAL_SCREE_HEGHT)
            scale9:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
            node:addChild(scale9)
        end
    end

    --printLog(string.format("--------------create %s'layer--------------",self._type))
    if self._keyboard_back then
        GAME_GLOBAL_BACK_LAYERS[#GAME_GLOBAL_BACK_LAYERS+1] = self
    end

end


function PopupLayer:close()
    if self._close then
        return nil
    end
    
    self._close = true
    
    GAME_GLOBAL_LAYERS[self] = nil
    for i,v in ipairs(GAME_GLOBAL_BACK_LAYERS) do
        if self == v then    
            table.remove(GAME_GLOBAL_BACK_LAYERS,i)
            break
        end
    end
    
    local function callback_exit()
        self:removeFromParent()
        self = nil
    end
    self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1,1.1),cc.ScaleTo:create(0.2,0.1),cc.CallFunc:create(callback_exit)))
end