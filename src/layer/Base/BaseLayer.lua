--[[
    一个透明图层，并且屏蔽下层的消息，点击非图片区域会关闭此图层
--]]

BaseLayer = class("BaseLayer", function() return cc.Layer:create() end)

function BaseLayer.create()
    local layer = BaseLayer.new()
    
    return layer
end

function BaseLayer:ctor()
    self:setContentSize(cc.size(GAME_GLOBAL_SCREE_WIDTH, GAME_GLOBAL_SCREE_HEGHT))
    self:setAnchorPoint(cc.p(0, 0))
    self._shield = true --屏蔽下层消息
    self._mask = true --遮罩
    self._maskStr = "common/cm_opacity.png"
    GAME_GLOBAL_LAYERS[self] = true
end

function BaseLayer:addto(parent, zorder, tag)
    
    local zorder, tag = zorder or 0, tag or 0

    if not parent then
        parent = cc.Director:getInstance():getRunningScene()
    end
    self._parent = parent
    
    parent:addChild(self, zorder, tag)
    
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
    
end

function BaseLayer:setShield(isShield)
    self._shield = isShield
end

function BaseLayer:setMask(isMask)
    self._mask = isMask
end

--设置遮罩蒙版的图片
function BaseLayer:setMaskStr(path)
    self._maskStr = path
end

function BaseLayer:close()
    GAME_GLOBAL_LAYERS[self] = nil
    self:removeFromParent()
    self = nil
end