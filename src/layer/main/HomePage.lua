--[[

    首页 
    
--]]

HomePage = class("HomePage", function() return BaseLayer.create() end)

function HomePage.create()
    local layer = HomePage.new()
    layer:initView()
    
    return layer   
end

function HomePage:ctor()
    self._type = "HomePage"
end

function HomePage:initView()
    local layerbg = cc.Sprite:create("myRes/bg_1.png")
    layerbg:setPosition(self:getContentSize().width/2, self:getContentSize().height/2)
    self:addChild(layerbg, 0) 
    
    
    local spine = sp.SkeletonAnimation:create("actor/alien.json","actor/alien.atlas",1)
    spine:setPosition(layerbg:getPosition())
    layerbg:addChild(spine)
    spine:setAnimation(0, "run", true)
    
end







