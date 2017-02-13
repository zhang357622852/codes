--[[
	
--]]

CapTure = class("CapTure", function() return BaseLayer.create() end)

function CapTure.create()
	local obj = CapTure.new()
	obj:initView()
	
	return obj
end

function CapTure:ctor()
	self._type = "CapTure"
	--self:setMask(false)
end

function CapTure:initView()
    
end