--	[ Services ]
local ServerStorage = game:GetService("ServerStorage")

--	[ Tables ]
local trees = {
	
	["Tree"] = {
		
		["minIterations"] = 2,
		["maxIterations"] = 4,
		
		["startIterationChance"] = 100,
		["iterationChanceDiminishTo"] = 50,
		
		["minAngleVariation"] = 20,
		["maxAngleVariation"] = 35,
		
		["minTrunkWidth"] = 1.4,
		["maxTrunkWidth"] = 2.0,
		
		["minTrunkHeight"] = 7,
		["maxTrunkHeight"] = 9,
		
		["branchWidthDiminishTo"] = 0.6,
		["branchHeightDiminishTo"] = 2,
		
		["minBranches"] = 2,
		["maxBranches"] = 3,
		
		["woodColor"] = Color3.fromRGB(218, 133, 65),
		["woodMaterial"] = Enum.Material.Wood,
		
		["leavesColor"] = Color3.fromRGB(75, 151, 75),
		["leavesMaterial"] = Enum.Material.Grass
		
	},
	
	["Oak Tree"] = {

		["minIterations"] = 2,
		["maxIterations"] = 4,

		["startIterationChance"] = 100,
		["iterationChanceDiminishTo"] = 60,

		["minAngleVariation"] = 25,
		["maxAngleVariation"] = 35,

		["minTrunkWidth"] = 1.6,
		["maxTrunkWidth"] = 2.4,

		["minTrunkHeight"] = 9,
		["maxTrunkHeight"] = 11,

		["branchWidthDiminishTo"] = 0.6,
		["branchHeightDiminishTo"] = 2,

		["minBranches"] = 2,
		["maxBranches"] = 4,

		["woodColor"] = Color3.fromRGB(226, 155, 64),
		["woodMaterial"] = Enum.Material.Wood,

		["leavesColor"] = Color3.fromRGB(40, 127, 71),
		["leavesMaterial"] = Enum.Material.Grass

	},
	
	["Willow Tree"] = {

		["minIterations"] = 2,
		["maxIterations"] = 4,

		["startIterationChance"] = 100,
		["iterationChanceDiminishTo"] = 80,

		["minAngleVariation"] = 25,
		["maxAngleVariation"] = 35,

		["minTrunkWidth"] = 2.0,
		["maxTrunkWidth"] = 2.8,

		["minTrunkHeight"] = 11,
		["maxTrunkHeight"] = 13,

		["branchWidthDiminishTo"] = 1.0,
		["branchHeightDiminishTo"] = 4,

		["minBranches"] = 3,
		["maxBranches"] = 4,

		["woodColor"] = Color3.fromRGB(86, 66, 54),
		["woodMaterial"] = Enum.Material.Wood,

		["leavesColor"] = Color3.fromRGB(127, 142, 100),
		["leavesMaterial"] = Enum.Material.Grass

	},
	
	["Maple Tree"] = {

		["minIterations"] = 3,
		["maxIterations"] = 4,

		["startIterationChance"] = 100,
		["iterationChanceDiminishTo"] = 80,

		["minAngleVariation"] = 20,
		["maxAngleVariation"] = 30,

		["minTrunkWidth"] = 1.8,
		["maxTrunkWidth"] = 2.8,

		["minTrunkHeight"] = 9,
		["maxTrunkHeight"] = 12,

		["branchWidthDiminishTo"] = 0.8,
		["branchHeightDiminishTo"] = 3,

		["minBranches"] = 2,
		["maxBranches"] = 4,

		["woodColor"] = Color3.fromRGB(170, 85, 0),
		["woodMaterial"] = Enum.Material.Wood,

		["leavesColor"] = Color3.fromRGB(218, 134, 122),
		["leavesMaterial"] = Enum.Material.Grass

	},
	
	["Magic Tree"] = {

		["minIterations"] = 4,
		["maxIterations"] = 5,

		["startIterationChance"] = 100,
		["iterationChanceDiminishTo"] = 80,

		["minAngleVariation"] = 15,
		["maxAngleVariation"] = 30,

		["minTrunkWidth"] = 1.2,
		["maxTrunkWidth"] = 1.8,

		["minTrunkHeight"] = 5,
		["maxTrunkHeight"] = 7,

		["branchWidthDiminishTo"] = 0.6,
		["branchHeightDiminishTo"] = 1,

		["minBranches"] = 3,
		["maxBranches"] = 5,

		["woodColor"] = Color3.fromRGB(98, 37, 209),
		["woodMaterial"] = Enum.Material.Pebble,

		["leavesColor"] = Color3.fromRGB(140, 91, 159),
		["leavesMaterial"] = Enum.Material.Grass

	},
	
	["lol"] = {

		["minIterations"] = 5,
		["maxIterations"] = 6,

		["startIterationChance"] = 100,
		["iterationChanceDiminishTo"] = 100,

		["minAngleVariation"] = 25,
		["maxAngleVariation"] = 50,

		["minTrunkWidth"] = 3.2,
		["maxTrunkWidth"] = 4.0,

		["minTrunkHeight"] = 10,
		["maxTrunkHeight"] = 12,

		["branchWidthDiminishTo"] = 0.6,
		["branchHeightDiminishTo"] = 4,

		["minBranches"] = 5,
		["maxBranches"] = 7,

		["woodColor"] = Color3.fromRGB(98, 37, 209),
		["woodMaterial"] = Enum.Material.Pebble,

		["leavesColor"] = Color3.fromRGB(140, 91, 159),
		["leavesMaterial"] = Enum.Material.Grass

	}
	
}

--	[ Variables ]
local treeStorage = workspace.TreeStorage

--	[ Functions ]
local function weld(p0, p1)
	local weld = Instance.new("Weld")
	weld.C0 = p0.CFrame:Inverse()
	weld.C1 = p1.CFrame:Inverse()
	weld.Part0 = p0
	weld.Part1 = p1
	weld.Parent = p0
end
local function generateTrunk(position, tree)
	local trunk = ServerStorage.TreeParts.Part:Clone()
	local width = math.random(trees[tree]["minTrunkWidth"] * 5, trees[tree]["maxTrunkWidth"] * 5) / 5
	local height = math.random(trees[tree]["minTrunkHeight"] * 5, trees[tree]["maxTrunkHeight"] * 5) / 5
	trunk.Size = Vector3.new(width, height, width)
	trunk.Position = position
	trunk.CFrame = trunk.CFrame * CFrame.Angles(0, math.rad(math.random(-180, 180)), 0) * CFrame.new(0, trunk.Size.Y/2, 0)
	trunk.Color = trees[tree]["woodColor"]
	trunk.Material = trees[tree]["woodMaterial"]
	trunk.Anchored = true
	trunk.Parent = treeStorage
	return trunk
end

local function generateBranch(origin, age, tree, startAngle, branches, b)
	local branch = ServerStorage.TreeParts.Part:Clone()
	local minWidth = (origin.Size.X * 5) - math.floor(((origin.Size.X - trees[tree]["branchWidthDiminishTo"]) * 5) / ((trees[tree]["maxIterations"] - age) + 1))
	local maxWidth = (origin.Size.X * 5) - math.floor(((origin.Size.X - trees[tree]["branchWidthDiminishTo"]) * 5) / ((trees[tree]["maxIterations"] - age) + 2))
	local width = math.random(minWidth, maxWidth) / 5
	local minHeight = (origin.Size.Y * 5) - math.floor(((origin.Size.Y - trees[tree]["branchHeightDiminishTo"]) * 5) / ((trees[tree]["maxIterations"] - age) + 1))
	local maxHeight = (origin.Size.Y * 5) - math.floor(((origin.Size.Y - trees[tree]["branchHeightDiminishTo"]) * 5) / ((trees[tree]["maxIterations"] - age) + 2))
	local height = math.random(minHeight, maxHeight) / 5
	local angle = startAngle + (b * (360 / branches)) + math.random(-360 / (branches * 10), 360 / (branches * 10))
	branch.Size = Vector3.new(width, height, width)
	branch.Position = origin.Position
	branch.CFrame = origin.CFrame * CFrame.new(0, origin.Size.Y / 2, 0) * CFrame.Angles(0, math.rad(angle), 0) * CFrame.Angles(math.rad(math.random(trees[tree]["minAngleVariation"], trees[tree]["maxAngleVariation"])), 0, 0) * CFrame.new(0, branch.Size.Y/2, 0)
	branch.Color = trees[tree]["woodColor"]
	branch.Material = trees[tree]["woodMaterial"]
	weld(branch, origin)
	branch.Parent = origin
	return branch
end

local function generateLeaves(origin, tree)
	local leaves = ServerStorage.TreeParts.Part:Clone()
	local size = origin.Size.X * 10
	leaves.CanCollide = false
	leaves.Size = Vector3.new(size, size/4, size)
	leaves.Position = origin.Position
	leaves.CFrame = origin.CFrame * CFrame.new(0, origin.Size.Y / 2, 0)
	leaves.Color = trees[tree]["leavesColor"]
	leaves.Material = trees[tree]["leavesMaterial"]
	weld(leaves, origin)
	leaves.Parent = origin
end

local function generateTree(position, tree)
	local trunk = generateTrunk(position, tree)
	local branchTable = {trunk}
	local iteration = 1
	local run = true
	while run do
		local tempTable = {}
		for i = 1, #branchTable do
			local branch = branchTable[i]
			local pass = true
			if iteration > trees[tree]["minIterations"] then
				local n = math.random(1, 100)
				local check = trees[tree]["startIterationChance"] - (((trees[tree]["startIterationChance"] - trees[tree]["iterationChanceDiminishTo"]) / (trees[tree]["maxIterations"] - trees[tree]["minIterations"])) * (iteration - trees[tree]["minIterations"]))
				if n > check then
					pass = false
				end
			end
			if iteration >= trees[tree]["maxIterations"] then
				pass = false
			end
			if pass then
				local minBranches = trees[tree]["minBranches"] - (iteration - 1)
				local maxBranches = trees[tree]["maxBranches"] - (iteration - 1)
				if minBranches <= 0 then
					minBranches = 1
					if maxBranches <= 0 then
						maxBranches = 1
					end
				end
				local nBranches = math.random(minBranches, maxBranches)
				local startAngle = math.random(-180, 180)
				for b = 1, nBranches do
					local newBranch = generateBranch(branch, iteration, tree, startAngle, nBranches, b)
					table.insert(tempTable, newBranch)
				end
			else
				generateLeaves(branch, tree)
			end
		end
		table.clear(branchTable)
		branchTable = tempTable
		if #branchTable == 0 then
			run = false
		end
		iteration = iteration + 1
	end
end

for i = 1, 10 do
	generateTree(Vector3.new(math.random(-100, 100), 0, math.random(-100, 100)), "Magic Tree")
end