--[[
    血条棒-带有颜色数字动画
--]]

BloodBar = class("BloodBar", function() return cc.Node:create() end)

-----------------------------
--@param:  foreground-前景图片路径名  background-背景图片路径名  totalBlood-总的血量
function BloodBar.create(foreground, background, totalBlood)
    local blood = BloodBar.new(totalBlood)
    blood:initBloodBar(foreground, background)
        
    return blood
end

function BloodBar:ctor(totalBlood)
    self._totalBlood = totalBlood
    self._curBlood = totalBlood
    self._attackType = 1
    self._blood = nil
end

function BloodBar:initBloodBar(foreground, background)
	
    local bg = cc.Sprite:create(background)
    bg:setPosition(bg:getContentSize().width/2, bg:getContentSize().height/2)
    self:addChild(bg)
    
    local blood = cc.ProgressTimer:create(cc.Sprite:create(foreground))
    blood:setMidpoint(cc.p(0, 0.5))
    blood:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    blood:setPercentage(100)
    blood:setBarChangeRate(cc.p(1, 0))
    blood:setPosition(bg:getContentSize().width/2, bg:getContentSize().height/2)
    bg:addChild(blood)
    self._blood = blood
    
    self:setContentSize(bg:getContentSize())
    self:setAnchorPoint(cc.p(0.5, 0.5))
    
end

--------------------
--param: changeBlood-改变的血量  isAdd-是加血还是减血  attackType-承受的攻击类型
function BloodBar:refreshBlood(changeBlood, isAdd, attackType)
  
    local curBlood = self._curBlood
    local totalBlood = self._totalBlood
    local blood = self._blood
    self._attackType = attackType
  
    if isAdd then --加血
        curBlood = curBlood + changeBlood
    else
        curBlood = curBlood - changeBlood
    end

    if curBlood <= 0 then --死亡
        curBlood = 0
    elseif curBlood >= totalBlood then
        curBlood = totalBlood
    end
    
    self._curBlood = curBlood
    local percentage = math.floor(curBlood/totalBlood*100)
    
    local function callback_createToast()
        self:createBloodToast(changeBlood, isAdd, attackType)    
    end
    local seq = cc.Sequence:create(cc.ProgressFromTo:create(0.2, math.floor(blood:getPercentage()), percentage), 
    cc.CallFunc:create(callback_createToast))
    blood:runAction(seq)
    
end

--attackType: 1-加血-绿色 2-普通攻击-西红柿色  3-暴击-红色  4-会心一击-紫色 
function BloodBar:createBloodToast(changeBlood, isAdd, attackType)
	
	local font = 
	{
	        [1] = {0,255,0, GameString.STR_BLOOD_ADD}, 
            [2] = {255,99,71, GameString.STR_BLOOD_PU}, 
	        [3] = {255,0,0, GameString.STR_BLOOD_BAO}, 
            [4] = {255,0,255, GameString.STR_BLOOD_HUI}, 
	}
	
	local addstr = nil
	if isAdd then
	   addstr = " +"
	else
	   addstr = " -"
	end
	
    local label = nil  
    for i=1, #font do
        if i == attackType then
            label = cc.Label:createWithSystemFont(font[i][4]..addstr..changeBlood, "Arial", 26)
            label:setColor(cc.c3b(font[i][1], font[i][2], font[i][3]))
            break
        end
    end
    
    label:setPosition(self:getPositionX(), self:getPositionY()+self:getContentSize().height*1.5)
    self:getParent():addChild(label)
    
    local spa = cc.Spawn:create(cc.FadeOut:create(0.7), cc.MoveBy:create(0.7, cc.p(0, GAME_GLOBAL_BLOOD_MOVE_DIS)))
    local seq = cc.Sequence:create(spa, cc.CallFunc:create(function() label:removeFromParent() end))
    
    label:runAction(seq)
	
end



