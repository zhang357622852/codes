--[[
    --按钮
    可添加精灵子节点，label,变灰
    
    --问题:
    目前的这种方式，只支持放一张normal的图片(只要点击放大的效果),如果想要selected和disabled的图片(目前没有这种接口?)
    self:getVirtualRenderer():getSprite() 得到的是normal下的Scale9Sprite
    
    --cocos2dx源码的实现:
    有三种状态下的Scale9Sprite,状态改变时,用的也是cc.ScaleTo的缩放方式变大缩小
--]]

UIButton = class("UIButton", function() return ccui.Button:create() end)

function UIButton.create(normal,selected,disabled)
    local obj = UIButton.new()
    obj:initBt(normal,selected,disabled)
    
    return obj
end

function UIButton:ctor()
    self._spChildren = {}
end

function UIButton:initBt(normal,selected,disabled)
    local selected = selected or ""
    local disabled = disabled or ""
    self:loadTextures(normal,selected,disabled)
    self._sp = self:getVirtualRenderer():getSprite()  
end

function UIButton:setLabelText(text, textSize)
    self:getTitleRenderer():setString(text)
    self:getTitleRenderer():setSystemFontSize(textSize or 24)
end

function UIButton:getButton()
    return self._sp
end

function UIButton:addSprite(path, posx, posy)
    local x, y = posx or self:getContentSize().width/2, posy or self:getContentSize().height/2
    
    local sp = cc.Sprite:create(path)
    sp:setPosition(x, y)
    self._sp:addChild(sp)
    self._spChildren[#self._spChildren+1] = sp
end

function UIButton:addLabel(text, posx, posy, fontsize)
    local x, y = posx or self:getContentSize().width/2, posy or self:getContentSize().height/2
    local fontsize = fontsize or 24
    
    local label = cc.Label:createWithTTF(text or "exp", GAME_LABEL_FONT, fontsize)
    label:setPosition(x, y)
    self._sp:addChild(label)
    
    return label
end

function UIButton:setIsEnabled(isEnabled)
    self:setEnabled(isEnabled)
    
    if not isEnabled then
        setSpriteGray(self._sp)
        for i,v in pairs(self._spChildren) do
            setSpriteGray(v)
        end
    else
        setSpriteNormal(self._sp)
        for i,v in pairs(self._spChildren) do
            setSpriteNormal(v)
        end
    end
end





