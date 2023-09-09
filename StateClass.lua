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

--[[

 --// surface level test 

  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local Players = game:GetService("Players")
  
  local StateClass = require(ReplicatedStorage.StateClass)
  
  local statePerPlayer = {}
  
  Players.PlayerAdded:Connect(function(player)
  	statePerPlayer[player] = StateClass.new(player)
  	
  	local playerState = statePerPlayer[player]
  	
  	
  	local stateChanged, message = playerState:handleState()
  	if not stateChanged then
  		return print(message)
  	end
  	
  	print("state handled 1")
  	
  	task.delay(3, function()
  		playerState:setStateToNone()
  
  		print("Handled 3")
  	end)
  	
  	local stateChanged, message = playerState:handleState()
  	if not stateChanged then
  		return warn(message)
  	end
  	
  	print("handled state 2")
  end)

]]
