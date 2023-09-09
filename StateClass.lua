--[[

  -- name:  StateClass
  -- description:  handle states for player (use for things like ui functionality so no bugs if lag)

]]

local NONE = "NONE"
local BUSY = "BUSY"
local SUCCESS = true
local FAILED = false

local state = {}
local statePrototype = {}
local statePrivate = {}

function state.new(player)
	local self = {}
	local private = {}
	
	private.player = player
	private.state = NONE
	
	statePrivate[self] = private
	
	return setmetatable(self, statePrototype)
end

function statePrototype:handleState()
	local private = statePrivate[self]
	
	if private.state ~= NONE then
		
		return FAILED, "StateClass:  State is current busy and cannot be set."
	end
	
	private.state = BUSY
	
	return SUCCESS
end

function statePrototype:setStateToNone()
	local private = statePrivate[self]
	
	private.state = NONE
end

function statePrototype:setStateToBusy()
	local private = statePrivate[self]
	
	private.state = BUSY
end

function statePrototype:getState()
	local private = statePrivate[self]
	
	return private.state
end

function statePrototype:destroy()
	self = nil
end

statePrototype.__index = statePrototype

return state
