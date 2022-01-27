local ServerStorage = game:GetService("ServerStorage")
local wedge = ServerStorage:WaitForChild("Wedge")

local terrainSize = 100
local unitSize = 24
local width = math.sqrt(unitSize^2 - (unitSize/2)^2)
local Vamplification = 100
local Hamplification = 15
local Damplification = 15

local randX = math.random(1, 1000)
local randZ = math.random(1, 1000)

local water = workspace.Water
water.Position = Vector3.new(0, -Vamplification/5, 0)

local function heron(a, b, c) -- Takes 3 sides of a triangle and returns the triangles altitude
	local s = (a + b + c)/2
	local A = math.sqrt(s * (s - a) * (s - b) * (s - c))
	return (2 * A)/c 
end

local function setProperties(parts, cut, trianglePos)
	if cut then
		parts[1].Material = Enum.Material.Grass
		parts[1].Color = Color3.fromRGB(3, 135, 69)
		parts[2].Material = Enum.Material.Sand
		parts[2].Color = Color3.fromRGB(222, 214, 97)
	else
		local material
		local color
		if trianglePos.Y < 0 then
			material = Enum.Material.Sand
			color = Color3.fromRGB(222, 214, 97)
		elseif trianglePos.Y > 0 then
			material = Enum.Material.Grass
			color = Color3.fromRGB(3, 135, 69)
		end
		for i, part in pairs(parts) do
			part.Material = material
			part.Color = color
		end
	end
end

local function cut(parts)
	local orientationPart = Instance.new("Part")
	orientationPart.Position = Vector3.new(0, -1000, 0)
	local part = parts[1]
	table.remove(parts, 1)
	local union = part:UnionAsync(parts)
	part:Destroy()
	for i, v in pairs(parts) do
		v:Destroy()
	end
	union.Parent = workspace
	local negateBottom = Instance.new("Part")
	negateBottom.Size = Vector3.new(unitSize*2, Vamplification/5, unitSize*2)
	negateBottom.Position = Vector3.new(union.Position.X, -Vamplification/10, union.Position.Z)
	negateBottom.Anchored = true
	negateBottom.Parent = workspace
	local negateTop = Instance.new("Part")
	negateTop.Size = Vector3.new(unitSize*2, Vamplification/5, unitSize*2)
	negateTop.Position = Vector3.new(union.Position.X, Vamplification/10, union.Position.Z)
	negateTop.Anchored = true
	negateTop.Parent = workspace
	local unionTop = union:SubtractAsync({negateBottom})
	local unionBottom = union:SubtractAsync({negateTop})
	negateTop:Destroy()
	negateBottom:Destroy()
	union:Destroy()
	unionTop.UsePartColor = true
	unionTop.Parent = workspace.Wedges
	unionBottom.UsePartColor = true
	unionBottom.Parent = workspace.Wedges
	setProperties({unionTop, unionBottom}, true)
end

local function drawTriangle(a, b, c) -- Takes 3 vector positions and draws a triangle between them
	local A = b - c
	local B = a - c
	local C = a - b

	local right = A:Cross(B)
	local up = C:Cross(right)
	local back = right:Cross(up)

	local height = heron(A.Magnitude, B.Magnitude, C.Magnitude)
	
	local w1 = wedge:Clone()
	w1.CFrame = CFrame.fromMatrix((b + c)/2, -right, -up, back)
	w1.Size = Vector3.new(0, height, math.sqrt(A.Magnitude^2 - height^2))
	w1.Parent = workspace.Wedges

	local w2 = wedge:Clone()
	w2.CFrame = CFrame.fromMatrix((a + c)/2, right, -up, -back)
	w2.Size = Vector3.new(0, height, math.sqrt(B.Magnitude^2 - height^2))
	w2.Parent = workspace.Wedges
	
	local aY = a.Y
	local bY = b.Y
	local cY = c.Y
	local max = math.max(aY, bY, cY)
	local min = math.min(aY, bY, cY)
	
	if max > 0 and min < 0 then
		cut({w1, w2})
	else
		setProperties({w1, w2}, false, (a + b + c)/3)
	end
end

local grid = {}

for x = 0, terrainSize do
	grid[x] = {}
	for z = 0, terrainSize - x do
		local X = (x * unitSize) - ((terrainSize - z)/2 * unitSize)
		local Z = (z * width) - (terrainSize/2 * width)
		grid[x][z] = Vector3.new(X, math.noise(x/Hamplification + randX, z/Damplification + randZ) * Vamplification, Z)
	end
end

for x = 0, terrainSize - 1 do
	for z = 0, (terrainSize - 1) - x do
		if z < (terrainSize - 1) - x then
			local a = grid[x][z]
			local b = grid[x][z + 1]
			local c = grid[x + 1][z]
			local d = grid[x + 1][z + 1]
			drawTriangle(a, b, c)
			drawTriangle(b, c, d)
		elseif z == (terrainSize - 1) - x then
			local a = grid[x][z]
			local b = grid[x][z + 1]
			local c = grid[x + 1][z]
			drawTriangle(a, b, c)
		end
	end
end