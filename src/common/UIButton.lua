--[[
    --按钮
    可添加精灵子节点，label,变灰
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

function UIButton:addLabel(text, posx, posy)
    local x, y = posx or self:getContentSize().width/2, posy or self:getContentSize().height/2
    
    local label = cc.Label:createWithSystemFont(text, "Arial", 24)
    label:setPosition(x, y)
    self._sp:addChild(label)
    self._spChildren[#self._spChildren+1] = label
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





