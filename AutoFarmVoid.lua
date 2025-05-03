local player = game.Players.LocalPlayer
local char = player.Character
local hrp = char.HumanoidRootPart
local hum = char.Humanoid

local function createFrame(parent, bg3, trans, pos, size, name)
	local item = Instance.new("Frame", parent)
	item.AnchorPoint = Vector2.new(0.5,0.5)
	item.BackgroundColor3 = bg3
	item.Transparency = trans
	item.Position = pos
	item.Size = size
	item.Name = name
end

local function createButton(parent, bg3, trans, pos, size, name, text, txt3, tt)
	local item = Instance.new("TextButton", parent)
	item.AnchorPoint = Vector2.new(0.5,0.5)
	item.BackgroundTransparency = trans
	item.BackgroundColor3 = bg3
	item.TextTransparency = tt
	item.TextColor3 = txt3
	item.TextScaled = true
	item.Position = pos
	item.Text = text
	item.Size = size
	item.Name = name
end

local function createImage(text)

end

for _, item in player.PlayerGui:GetChildren() do
	if item.Name == "BGSI" then
		item:Destroy()	
	end
end

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "BGSI"
screenGui.ScreenInsets = Enum.ScreenInsets.None
screenGui.ResetOnSpawn = true

local BGSI = player.PlayerGui:FindFirstChild("BGSI")

createFrame(BGSI, Color3.fromRGB(30,50,30), 1, UDim2.new(0.5,0,0.5,0), UDim2.new(0,500,0,21), "Drag")
local drag = BGSI:FindFirstChild("Drag")
local dragUI = Instance.new("UIDragDetector", drag)

createFrame(drag, Color3.fromRGB(255,255,255), 0, UDim2.new(0.5,0,0,152.5), UDim2.new(0,500,0,305), "BG")
local bg = drag:FindFirstChild("BG")
local corner = Instance.new("UICorner", bg)
corner.CornerRadius = UDim.new(0,12)
local grad = Instance.new("UIGradient", bg)
grad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(59,13,91)),
	ColorSequenceKeypoint.new(0.5,Color3.fromRGB(78,81,255)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(68,15,91))})
task.spawn(function() while true do grad.Rotation += 0.6 task.wait() end end)

createFrame(bg, Color3.fromRGB(20,20,20), 0, UDim2.new(0.5,0,0,160), UDim2.new(0,490,0,280), "Inner")
local inner = bg:FindFirstChild("Inner")
local corner = Instance.new("UICorner", inner)
corner.CornerRadius = UDim.new(0,10)

createButton(inner, Color3.fromRGB(255,255,255), 1, UDim2.new(0.5,0,0,50), UDim2.new(0,180,0,35), "Button1", "Activate Void AFK", Color3.fromRGB(123, 107, 163), 0)
local button1 = inner:FindFirstChild("Button1")

local active = false

button1.MouseButton1Click:Connect(function()
	if active then
		active = false
	else
		active = true
		local pos = workspace.Rendered.Generic["The Void"].Display.Position
		workspace.Rendered.Generic["The Void"].Display.Position = hrp.Position
		task.wait()
		workspace.Rendered.Generic["The Void"].Display.Position = pos
	end
end)

task.spawn(function()
	
	local function moveTo(spot)
		if spot then
			repeat task.wait() hum:MoveTo(spot) until (hrp.Position-spot).Magnitude < 2.5
		end
	end
	local function positionCheck(position)
		local mainMin = Vector3.new(-50, 10130, 100)
		local leftMin = Vector3.new(-100, 10130, 0)
		local rightMin = Vector3.new(0, 10130, 0)

		local mainMax = Vector3.new(50, 10160, 200)
		local leftMax = Vector3.new(0, 10160, 120)
		local rightMax = Vector3.new(100, 10160, 120)

		if position.X > mainMin.X and position.X < mainMax.X and
			position.Y > mainMin.Y and position.Y < mainMax.Y and
			position.Z > mainMin.Z and position.Z < mainMax.Z then
			return "island1"

		elseif position.X > leftMin.X and position.X < leftMax.X and
			position.Y > leftMin.Y and position.Y < leftMax.Y and
			position.Z > leftMin.Z and position.Z < leftMax.Z then
			return "island2"

		elseif position.X > rightMin.X and position.X < rightMax.X and
			position.Y > rightMin.Y and position.Y < rightMax.Y and
			position.Z > rightMin.Z and position.Z < rightMax.Z then
			return "island3"
		end

		return nil
	end
	local function crossBridge(bridge, direction, goal)
		print("Bridge Found")
		if bridge == "1" then
			if direction == true then
				moveTo(Vector3.new(-26, 10145, 135))
				moveTo(Vector3.new(-53, 10145, 78))
				moveTo(goal)
			else
				moveTo(Vector3.new(-53, 10145, 78))
				moveTo(Vector3.new(-26, 10145, 135))
				moveTo(goal)
			end
		end

		if bridge == "2" then
			if direction == true then
				moveTo(Vector3.new(-25, 10145, 38))
				moveTo(Vector3.new(40, 10145, 43))
				moveTo(goal)
			else
				moveTo(Vector3.new(40, 10145, 43))
				moveTo(Vector3.new(-25, 10145, 38))
				moveTo(goal)
			end
		end

		if bridge == "3" then
			if direction == true then
				moveTo(Vector3.new(60, 10145, 88))
				moveTo(Vector3.new(22, 10145, 141))
				moveTo(goal)
			else
				moveTo(Vector3.new(22, 10145, 141))
				moveTo(Vector3.new(60, 10145, 88))
				moveTo(goal)
			end
		end
	end
	local function islandCheck(position, targetPosition)
		print("Islands Checked")
		local p1 = positionCheck(position)
		local p2 = positionCheck(targetPosition)

		print("Detecting Islands")

		if p1 == "island1" and p2 == "island2" then
			crossBridge("1", true, targetPosition)
		elseif p1 == "island2" and p2 == "island1" then
			crossBridge("1", false, targetPosition)
		elseif p1 == "island2" and p2 == "island3" then
			crossBridge("2", true, targetPosition)
		elseif p1 == "island3" and p2 == "island2" then
			crossBridge("2", false, targetPosition)
		elseif p1 == "island3" and p2 == "island1" then
			crossBridge("3", true, targetPosition)
		elseif p1 == "island1" and p2 == "island3" then
			crossBridge("3", false, targetPosition)
		elseif p1 == p2 then
			moveTo(targetPosition)
		end


	end

	repeat
		if not active then
			repeat task.wait(0.1) until active or hum.Health <= 0
		end
		
		local distance = 500
		local closestItem = nil

		for _, item in workspace.Rendered:GetDescendants() do
			if string.find(item:GetFullName(), "Chunker") then
				if not string.find(item.Name, "egg") then
					if string.find(item.Name, "Meshes") then
						if item.Transparency == 0 then
							if item.Position.Y > 10140 and item.Position.Y < 10150 then
								if hrp and hrp.Parent then
									if (hrp.Position - item.Position).Magnitude < distance then
										distance = (hrp.Position - item.Position).Magnitude
										closestItem = item
									end
								end
							end
						end
					end
				end
			end
		end

		print("Repeat")

		if closestItem and closestItem.Parent and hrp and hrp.Parent and hum and hum.Parent then
			islandCheck(hrp.Position, closestItem.Position)
		end

		task.wait(0.1)

	until hum.Health <= 0 
end)