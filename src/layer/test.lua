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
   local layer = self:VideoPlayerTest()
   self:addChild(layer)
   
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
end

function test:VideoPlayerTest()
    local layer = cc.Layer:create()

    cc.MenuItemFont:setFontSize(24)
    local posx = self:getContentSize().width
    local posy = self:getContentSize().height

    local videoStateLabel = cc.Label:createWithTTF("HIDLE",GAME_LABEL_FONT,24)
    videoStateLabel:setAnchorPoint(cc.p(1, 0.5))
    videoStateLabel:setPosition(posx-100,posy-50)
    layer:addChild(videoStateLabel)

    local function onVideoEventCallback(sener, eventType)
        if eventType == ccexp.VideoPlayerEvent.PLAYING then
            videoStateLabel:setString("PLAYING")
        elseif eventType == ccexp.VideoPlayerEvent.PAUSED then
            videoStateLabel:setString("PAUSED")
        elseif eventType == ccexp.VideoPlayerEvent.STOPPED then
            videoStateLabel:setString("STOPPED")
        elseif eventType == ccexp.VideoPlayerEvent.COMPLETED then
            videoStateLabel:setString("COMPLETED")
        end
    end
    local widgetSize = self:getContentSize()
    local videoPlayer = ccexp.VideoPlayer:create()
    videoPlayer:setPosition(posx/2,posy/2)
    videoPlayer:setAnchorPoint(cc.p(0.5, 0.5))
    videoPlayer:setContentSize(cc.size(widgetSize.width * 0.4,widgetSize.height * 0.4))
    videoPlayer:addEventListener(onVideoEventCallback)
    layer:addChild(videoPlayer)

    local screenSize = cc.Director:getInstance():getWinSize()
    local rootSize = self:getContentSize()

    local function menuFullScreenCallback(tag, sender)
        if nil  ~= videoPlayer then
            videoPlayer:setFullScreenEnabled(not videoPlayer:isFullScreenEnabled())
        end
    end
    local fullSwitch = cc.MenuItemFont:create("FullScreenSwitch")
    fullSwitch:setAnchorPoint(cc.p(0.0, 0.5))
    fullSwitch:setPosition(20,posy-50)
    fullSwitch:registerScriptTapHandler(menuFullScreenCallback)

    local function menuPauseCallback(tag, sender)
        if nil  ~= videoPlayer then
            videoPlayer:pause()
        end
    end
    local pauseItem = cc.MenuItemFont:create("Pause")
    pauseItem:setAnchorPoint(cc.p(0.0, 0.5))
    pauseItem:setPosition(20,posy-100)
    pauseItem:registerScriptTapHandler(menuPauseCallback)

    local function menuResumeCallback(tag, sender)
        if nil  ~= videoPlayer then
            videoPlayer:resume()
        end
    end
    local resumeItem = cc.MenuItemFont:create("Resume")
    resumeItem:setAnchorPoint(cc.p(0.0, 0.5))
    resumeItem:setPosition(20,posy-150)
    resumeItem:registerScriptTapHandler(menuResumeCallback)

    local function menuStopCallback(tag, sender)
        if nil  ~= videoPlayer then
            videoPlayer:stop()
        end
    end
    local stopItem = cc.MenuItemFont:create("Stop")
    stopItem:setAnchorPoint(cc.p(0.0, 0.5))
    stopItem:setPosition(20,posy-200)
    stopItem:registerScriptTapHandler(menuStopCallback)

    local function menuHintCallback(tag, sender)
        if nil  ~= videoPlayer then
            videoPlayer:setVisible(not videoPlayer:isVisible())
        end
    end
    local hintItem = cc.MenuItemFont:create("Hint")
    hintItem:setAnchorPoint(cc.p(0.0, 0.5))
    hintItem:setPosition(20,posy-250)
    hintItem:registerScriptTapHandler(menuHintCallback)

    local function menuResourceVideoCallback(tag, sender)
        if nil ~= videoPlayer then
            videoPlayer:setFileName("res/video/cocosvideo.mp4") --路径要绝对路径
            videoPlayer:play()
        end
    end

    local resourceVideo = cc.MenuItemFont:create("Play resource video")
    resourceVideo:setAnchorPoint(cc.p(1, 0.5))
    resourceVideo:setPosition(posx-50,posy-100)
    resourceVideo:registerScriptTapHandler(menuResourceVideoCallback)

    local function menuOnlineVideoCallback(tag, sender)
        if nil ~= videoPlayer then
            videoPlayer:setURL("http://v.cctv.com/flash/mp4video21/TMS/2012/05/27/0dbc1f61dc9740f0b4d3bd1d4b0728ff_h264818000nero_aac32-1.mp4")
            videoPlayer:play()
        end
    end
    local onlineVideo = cc.MenuItemFont:create("Play online video")
    onlineVideo:setAnchorPoint(cc.p(1, 0.5))
    onlineVideo:setPosition(posx-50,posy-150)
    onlineVideo:registerScriptTapHandler(menuOnlineVideoCallback)

    local function menuRatioCallback(tag, sender)
        if nil ~= videoPlayer then
            videoPlayer:setKeepAspectRatioEnabled(not videoPlayer:isKeepAspectRatioEnabled())
        end
    end
    local ratioSwitch = cc.MenuItemFont:create("KeepRatioSwitch")
    ratioSwitch:setAnchorPoint(cc.p(1, 0.5))
    ratioSwitch:setPosition(posx-50,posy-200)
    ratioSwitch:registerScriptTapHandler(menuRatioCallback)

    local menu = cc.Menu:create(fullSwitch, pauseItem, resumeItem, stopItem, hintItem, resourceVideo, onlineVideo, ratioSwitch)
    menu:setPosition(cc.p(0.0, 0.0))
    layer:addChild(menu)
    
    return layer
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

    