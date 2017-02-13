--[[
	滑动列表 --鼠标悬停效果
	锚点:(0, 0)
    默认是垂直，如果要水平，要在添加item前，设置方向-setDirection
    
    目前存在的一个大问题就是，图层无法屏蔽掉鼠标监听事件 --或者只能手动listener:setEnabled(false)
--]]

ListBar = class("ListBar", function() return cc.Layer:create() end)

local dir = 
        {
            vertical = 1, --下自上排序
            horizontal = 2 --左自右排序
        }

-- selFontColor:选中时字体颜色cc.c3b(0,0,0)  selPic:选中显示的底图
function ListBar.create(selFontColor, selPic)
	local obj = ListBar.new(selFontColor, selPic)
	
	return obj
end

function ListBar:ctor(selFontColor, selPic)
    --self:setAnchorPoint(cc.p(0.5, 0))
    self._fontColor = selFontColor
    self._selPic = selPic
    self._dir = dir.vertical
    self._lastIndex = 0
    self._labels = {}
    self._sps = {}
end

function ListBar:pushBackCustomItem(text, textSize, textColor)
    if not self._listener then
        self:registerMouseEvent()
    end
    
    local sp = cc.Sprite:create(self._selPic)
    self._sps[#self._sps+1] = sp
    if self._dir == dir.vertical then
        self:setContentSize(sp:getContentSize().width, sp:getContentSize().height*#self._sps)
        sp:setPosition(self:getContentSize().width/2, sp:getContentSize().height/2*(#self._sps*2-1))
    else
        self:setContentSize(sp:getContentSize().width*#self._sps, sp:getContentSize().height)
        sp:setPosition(sp:getContentSize().width/2*(#self._sps*2-1), self:getContentSize().height/2)
    end
    self:addChild(sp, 1)
    sp:setVisible(false)
    
    local label = cc.Label:createWithSystemFont(text, "Arial", textSize or 24)
    label:setTextColor(cc.c3b(0, 0, 0))--暂定黑色
    label:setPosition(sp:getPosition())
    self:addChild(label, 2)
    self._labels[#self._labels+1] = label
end

--1:vertical  2:horizontal
function ListBar:setDirection(dirIndex)
    if dirIndex == dir.vertical then
        self._dir = dir.vertical
    else
        --self:setAnchorPoint(cc.p(0, 0.5)) --继承Layer,忽略锚点(无论如何设置都是(0,0))
        self._dir = dir.horizontal
    end   
end

--如果在此界面有图层的话，只能用这种方法先关闭鼠标监听事件,等回到此图层时再开启
function ListBar:setEnabled(isEnabled)
    self._listener:setEnabled(isEnabled)
end

--callback:  function callback(tag) end   tag:表示点击第几个item
function ListBar:registerScriptHandler(callback)
    self._callback = callback
end

function ListBar:registerMouseEvent()
    local function onMouseUp(event)
        if self._callback then
            if self._lastIndex ~= 0 then
                self._callback(self._lastIndex)
            end
        end
    end
   
    local function onMouseMove(event)
        local x = event:getCursorX()
        local y = event:getCursorY()   
        local pos = self:convertToNodeSpace(cc.p(x, y))--这里跟self的锚点无关，都是从self左下角为原点
        
        local num = 0
        for i,v in pairs(self._sps) do
            if cc.rectContainsPoint(v:getBoundingBox(), pos) then
                v:setVisible(true)
                self._labels[i]:setTextColor(self._fontColor)
                
                if self._lastIndex~=0 then                
                    if  self._lastIndex~=i then
                        self._sps[self._lastIndex]:setVisible(false)
                        self._labels[self._lastIndex]:setTextColor(cc.c3b(0, 0, 0))
                        cc.SimpleAudioEngine:getInstance():playEffect("audio/click_1.wav")
                    end
                else
                    cc.SimpleAudioEngine:getInstance():playEffect("audio/click_1.wav")
                end             
                self._lastIndex = i         
                break
            else
                v:setVisible(false)
                self._labels[i]:setTextColor(cc.c3b(0, 0, 0))
            end
            num = num + 1
        end
        if num == #self._sps then--鼠标不在ListBar范围内
            self._lastIndex = 0
        end
    end

    
    local listener = cc.EventListenerMouse:create()
    listener:registerScriptHandler(onMouseUp, cc.Handler.EVENT_MOUSE_UP)
    listener:registerScriptHandler(onMouseMove, cc.Handler.EVENT_MOUSE_MOVE)
    self._listener = listener
    
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
end




