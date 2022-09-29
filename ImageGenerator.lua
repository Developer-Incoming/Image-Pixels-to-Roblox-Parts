--// GITHUB COMMENT: Run in Roblox Studio, and Save as Local Plugin when right clicking on it after pasting it in a Script.




--// Services
local ChangeHistoryService = game:GetService"ChangeHistoryService"
local RunService = game:GetService"RunService"
local Selection = game:GetService"Selection"


--// Constant Variables
-- Create a new toolbar section titled "Custom Script Tools"
local toolbar = plugin:CreateToolbar"Krazy"


--// Functions

local function createPixel(position, size, color, index)
	local parent
	if Selection:Get()[1]then
		parent = Selection:Get()[1]:FindFirstChild"Pixels Folder" or Selection:Get()[1]
	else
		parent = workspace:FindFirstChild"Pixels Folder" or workspace
	end
	
	local pixelsFolder = Instance.new("Folder", parent)
	pixelsFolder.Name = "Pixels Folder"

	local pixel = Instance.new("Part", pixelsFolder)
	pixel.Name = tostring(index)
	pixel.Anchored = true
	pixel.CanCollide = false
	pixel.Position = position
	pixel.Size = size
	pixel.Color = color
end

local function startGeneratingImage(imageData, imageOffsetPosition, pixelSize)
	for y, row in pairs(imageData)do
		for x, pixelColor in pairs(row)do
			createPixel(
				imageOffsetPosition - Vector3.new(x * pixelSize.X, y * pixelSize.Y, 0 * pixelSize.Z),
				pixelSize,
				Color3.fromRGB(pixelColor[1], pixelColor[2], pixelColor[3]),
				Vector2.new(x, y)
			)
		end

		RunService.Heartbeat:Wait()
	end
	
	ChangeHistoryService:SetWaypoint("Finished image generating")
end

local imageGeneratorWidget

local function setupUI()
	imageGeneratorWidget = plugin:CreateDockWidgetPluginGui(
		"3Image Generator",
		DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, true, 300, 225)
	)
	
	imageGeneratorWidget.Title = "Image Generator"

	local generateImageButton = Instance.new("TextButton", imageGeneratorWidget)
	local uiCorner = Instance.new("UICorner", generateImageButton)
	local imageDataTextBox = Instance.new("TextBox", imageGeneratorWidget)
	local uiCorner_2 = Instance.new("UICorner", imageDataTextBox)
	local textLabel = Instance.new("TextLabel", imageGeneratorWidget)
	local uiCorner_3 = Instance.new("UICorner", imageGeneratorWidget)
	
	local textBoxX = Instance.new("TextBox", imageGeneratorWidget)
	local uiCorner_4 = Instance.new("UICorner", textBoxX)
	local textBoxZ = Instance.new("TextBox", imageGeneratorWidget)
	local uiCorner_5 = Instance.new("UICorner", textBoxZ)
	local textBoxY = Instance.new("TextBox", imageGeneratorWidget)
	local uiCorner_6 = Instance.new("UICorner", textBoxY)
	local textLabel2 = Instance.new("TextLabel", imageGeneratorWidget)

	uiCorner_3.CornerRadius = UDim.new(0.05, 0)

	generateImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	generateImageButton.BackgroundTransparency = 0.9
	generateImageButton.Position = UDim2.new(0.175, 0, 0.75, 0)
	generateImageButton.Size = UDim2.new(0.65, 0, 0.15, 0)
	generateImageButton.Font = Enum.Font.SourceSans
	generateImageButton.Text = "Generate Image"
	generateImageButton.TextColor3 = Color3.fromRGB(235, 235, 235)
	generateImageButton.TextScaled = true
	generateImageButton.TextSize = 14
	generateImageButton.TextStrokeTransparency = 0.9
	generateImageButton.TextWrapped = true

	uiCorner.CornerRadius = UDim.new(0.15, 0)

	imageDataTextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	imageDataTextBox.BackgroundTransparency = 0.9
	imageDataTextBox.Position = UDim2.new(0.275, 0, 0.125, 0)
	imageDataTextBox.Size = UDim2.new(0.70, 0, 0.15, 0)
	imageDataTextBox.Font = Enum.Font.SourceSans
	imageDataTextBox.PlaceholderText = "Paste image's data here. Don't fill if you want to use global ImageData var"
	imageDataTextBox.Text = ""
	imageDataTextBox.TextColor3 = Color3.fromRGB(235, 235, 235)
	imageDataTextBox.TextSize = 14
	imageDataTextBox.TextWrapped = true

	uiCorner_2.CornerRadius = UDim.new(0.15, 0)

	textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.BackgroundTransparency = 1
	textLabel.Position = UDim2.new(0, 0, 0.125, 0)
	textLabel.Size = UDim2.new(0.275, 0, 0.125, 0)
	textLabel.Font = Enum.Font.SourceSans
	textLabel.Text = "Image's Data:"
	textLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
	textLabel.TextScaled = true
	textLabel.TextSize = 14
	textLabel.TextStrokeTransparency = 0.9
	textLabel.TextWrapped = true
	

	textBoxZ.Name = "textBoxZ"
	textBoxZ.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textBoxZ.BackgroundTransparency = 0.9
	textBoxZ.Position = UDim2.new(0.774999976, 0, 0.325, 0)
	textBoxZ.Size = UDim2.new(0.2, 0, 0.15, 0)
	textBoxZ.Font = Enum.Font.SourceSans
	textBoxZ.PlaceholderColor3 = Color3.fromRGB(30, 57, 178)
	textBoxZ.PlaceholderText = "Z"
	textBoxZ.Text = ""
	textBoxZ.TextColor3 = Color3.fromRGB(30, 57, 178)
	textBoxZ.TextScaled = true
	textBoxZ.TextSize = 14
	textBoxZ.TextStrokeTransparency = 0.95
	textBoxZ.TextWrapped = true

	uiCorner_6.CornerRadius = UDim.new(0.15, 0)

	textBoxY.Name = "textBoxY"
	textBoxY.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textBoxY.BackgroundTransparency = 0.9
	textBoxY.Position = UDim2.new(0.525, 0, 0.325, 0)
	textBoxY.Size = UDim2.new(0.2, 0, 0.15, 0)
	textBoxY.Font = Enum.Font.SourceSans
	textBoxY.PlaceholderColor3 = Color3.fromRGB(74, 178, 58)
	textBoxY.PlaceholderText = "Y"
	textBoxY.Text = ""
	textBoxY.TextColor3 = Color3.fromRGB(74, 178, 58)
	textBoxY.TextScaled = true
	textBoxY.TextSize = 14
	textBoxY.TextStrokeTransparency = 0.95
	textBoxY.TextWrapped = true

	uiCorner_5.CornerRadius = UDim.new(0.15, 0)

	textBoxX.Name = "textBoxX"
	textBoxX.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textBoxX.BackgroundTransparency = 0.9
	textBoxX.Position = UDim2.new(0.275, 0, 0.325, 0)
	textBoxX.Size = UDim2.new(0.2, 0, 0.15, 0)
	textBoxX.Font = Enum.Font.SourceSans
	textBoxX.PlaceholderColor3 = Color3.fromRGB(178, 57, 73)
	textBoxX.PlaceholderText = "X"
	textBoxX.Text = ""
	textBoxX.TextColor3 = Color3.fromRGB(178, 57, 73)
	textBoxX.TextScaled = true
	textBoxX.TextSize = 14
	textBoxX.TextStrokeTransparency = 0.95
	textBoxX.TextWrapped = true

	uiCorner_4.CornerRadius = UDim.new(0.15, 0)

	textLabel2.Name = "textLabel2"
	textLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel2.BackgroundTransparency = 1
	textLabel2.Position = UDim2.new(0, 0, 0.325, 0)
	textLabel2.Size = UDim2.new(0.275, 0, 0.125, 0)
	textLabel2.Font = Enum.Font.SourceSans
	textLabel2.Text = "Pixel Size in Studs"
	textLabel2.TextColor3 = Color3.fromRGB(235, 235, 235)
	textLabel2.TextScaled = true
	textLabel2.TextSize = 14
	textLabel2.TextStrokeTransparency = 0.9
	textLabel2.TextWrapped = true
	
	generateImageButton.MouseButton1Click:Connect(function()
		if not tonumber(textBoxX.Text)or not tonumber(textBoxY.Text)or not tonumber(textBoxZ.Text)then
			error("Please check your inputs")
		elseif imageDataTextBox.Text == ""then
			print(_G.ImageData)
			startGeneratingImage(
				_G.ImageData,
				Vector3.new(
					math.round(workspace.Camera.CFrame.Position.X),
					math.round(workspace.Camera.CFrame.Position.Y),
					math.round(workspace.Camera.CFrame.Position.Z)
				) + workspace.Camera.CFrame.LookVector * 10,
				Vector3.new(tonumber(textBoxX.Text), tonumber(textBoxY.Text), tonumber(textBoxZ.Text))
			)
		else
			startGeneratingImage(
				loadstring(("return {%s}"):format(imageDataTextBox.Text))(),
				Vector3.new(
					math.round(workspace.Camera.CFrame.Position.X),
					math.round(workspace.Camera.CFrame.Position.Y),
					math.round(workspace.Camera.CFrame.Position.Z)
				) + workspace.Camera.CFrame.LookVector * 10,
				Vector3.new(tonumber(textBoxX.Text), tonumber(textBoxY.Text), tonumber(textBoxZ.Text))
			)
		end
	end)
end

local function toggleUI()
	imageGeneratorWidget.Enabled = not imageGeneratorWidget.Enabled
end

--// Variables

local generateImageButton = toolbar:CreateButton("Image Generator", "Start generating images\n266512529746952192", "http://www.roblox.com/asset/?id=11105050487")
generateImageButton.ClickableWhenViewportHidden = true


--// Functionality
setupUI()

generateImageButton.Click:Connect(function()
	toggleUI()
	--print(generateImageButton)
end)
