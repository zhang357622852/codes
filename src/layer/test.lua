--[[
	
--]]

test = class("test", function() return PopupLayer:create() end)

function test.create()
    local layer = test.new()
    layer:initView()

    return layer
end

function test:ctor()
    self._type = "test"
end

function test:initView()  
end


function test:closetest()
    self:close()
end





    --旋转选择角色
--    local layer = RotateView.create()
--    layer:setPosition(0, self:getContentSize().height/2-layer:getContentSize().height/2)
--    self:addChild(layer)
--    
--    for i=1, 6 do
--        local sp = cc.Sprite:create("myRes/taizi.png")
--        layer:pushBackCustomItem(sp)
--    end
 
    --鼠标悬停
--    local sp9 = ccui.Scale9Sprite:create("common/bar_back.png")
--    sp9:setPosition(self:getContentSize().width-sp9:getContentSize().width/2, self:getContentSize().height/2)
--    self:addChild(sp9)
--    
--    local function callback(tag)
--        Toast3.create(tag)
--    end
--    
--    local listbar = ListBar.create(cc.c3b(255,255,255), "common/bar_front.png")
--    --listbar:setDirection(2)
--    listbar:pushBackCustomItem("电影")
--    listbar:pushBackCustomItem("娱乐")
--    listbar:pushBackCustomItem("动漫")
--    listbar:pushBackCustomItem("时尚")
--    listbar:pushBackCustomItem("鬼畜")
--    listbar:pushBackCustomItem("科技")
--    listbar:pushBackCustomItem("直播")
--    listbar:registerScriptHandler(callback)
--    sp9:addChild(listbar)  
--    sp9:setContentSize(listbar:getContentSize())
    
    --截图
--    local layer = CapTure.create()
--    layer:addto(nil, 10)

-- textField
--local function callback(eventType)
--    print("```````````")
--    if eventType == ccui.TextFiledEventType.attach_with_ime then
--        print("````````````attach_with_ime`````````````````")
--    elseif eventType == ccui.TextFiledEventType.delete_backward then
--        print("```````````````delete_backward``````````````")
--    elseif eventType == ccui.TextFiledEventType.detach_with_ime then
--        print("`````````````detach_with_ime````````````````")
--    elseif eventType == ccui.TextFiledEventType.insert_text then
--        print("````````````insert_text`````````````````")
--    end
--end
--local field = ccui.TextField:create("name","Arial",30)
--field:setMaxLengthEnabled(true)
----field:setTouchAreaEnabled(true)
--field:setTouchEnabled(true)
--field:setMaxLength(6)
----    field:setDeleteBackward(true)
----    field:setAttachWithIME(true)
----    field:setDetachWithIME(true)
----    field:setInsertText(true)
--field:attachWithIME()
--field:addEventListener(callback)
--field:setPosition(layerbg:getContentSize().width/2, layerbg:getContentSize().height/2)
    --layerbg:addChild(field)

    