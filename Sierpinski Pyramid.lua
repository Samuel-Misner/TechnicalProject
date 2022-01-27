math.randomseed(tick())

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local startEvent = RemoteEvents.Start
local clearEvent = RemoteEvents.Clear

local points = workspace.Points:GetChildren()
local markers = workspace.Markers

local progMult = 8
local run = false

local function clear()
	run = false
	local marks = markers:GetChildren()
	for i = 1, #marks do
		local part = marks[i]
		part:Destroy()
	end
end

local function start()
	wait(5)
	run = true
	for i = 1, progMult do
		local pos = points[1].Position
		local function runf()
			while run do
				local point = points[math.random(1, #points)].Position
				pos = (pos + point)/2
				local clone = ServerStorage.Marker:Clone()
				clone.Position = pos
				clone.Parent = markers
				wait()
			end
		end
		spawn(runf)
	end
end

startEvent.OnServerEvent:Connect(start)
clearEvent.OnServerEvent:Connect(clear)