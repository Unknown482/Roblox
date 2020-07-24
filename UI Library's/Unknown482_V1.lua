local Library = {Count = 0}
local dragger = {}; do
function dragger.new(frame)
local k,event=pcall(function()
return frame.MouseEnter
end)
if k then
local v=game:GetService('UserInputService');
frame.Active = true;
local g=game:GetService("RunService").Heartbeat;
event:connect(function()
local j=game:GetService("Players").LocalPlayer:GetMouse();
local input=frame.InputBegan:connect(function(key)
if key.UserInputType==Enum.UserInputType.MouseButton1 then
local objectPosition=Vector2.new(j.X - frame.AbsolutePosition.X, j.Y - frame.AbsolutePosition.Y);
while g:wait()and v:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
pcall(function()
frame:TweenPosition(UDim2.new(0,j.X-objectPosition.X+(frame.Size.X.Offset*frame.AnchorPoint.X),0,j.Y-objectPosition.Y+(frame.Size.Y.Offset*frame.AnchorPoint.Y)),'Out','Linear',0.1,true);
end)
end
end
end)
local leave;
leave=frame.MouseLeave:connect(function()
input:disconnect();
leave:disconnect();
end)
end)
end
end
end
local valid_chars = {}

local function set_valid(x, y)
for i = string.byte(x), string.byte(y) do
table.insert(valid_chars, string.char(i))
end
end
local function random_string(length)
local s = {}
for i = 1, length do s[i] = valid_chars[math.random(1, #valid_chars)] end
return table.concat(s)
end
set_valid('a', 'z')
set_valid('A', 'Z')
set_valid('0', '9')
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = random_string(20)
function Library:Destroy()
	ScreenGui:Destroy()
end
function Library:CreateWindow(WindowName, Color)
	local EpicLibrary = {}
	local Color = Color or Color3.fromRGB(0, 170, 255)
	local WindowName = WindowName or "Window"
	local Top = Instance.new("ImageLabel")
	local Toggle = Instance.new("TextButton")
	local Title = Instance.new("TextLabel")
	local Main = Instance.new("ImageLabel")
	local UIGridLayout = Instance.new("UIGridLayout")
	local UIPadding = Instance.new("UIPadding")
	
	Top.Name = WindowName
	Top.Parent = ScreenGui
	Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Top.BackgroundTransparency = 1.000
	local screensize = game.Workspace.CurrentCamera.ViewportSize
	local pixelsize = Vector2.new(1/screensize.X,1/screensize.Y)
	Top.Position = UDim2.new((20 * pixelsize.X + (Library.Count * (200 * pixelsize.X))), 0, 20 * pixelsize.Y, 0)
	Top.Size = UDim2.new(0, 170, 0, 20)
	Top.ZIndex = 2
	Top.Image = "rbxassetid://3570695787"
	Top.ImageColor3 = Color
	Top.ScaleType = Enum.ScaleType.Slice
	Top.SliceCenter = Rect.new(100, 100, 100, 100)
	Top.SliceScale = 0.040
	Library.Count = Library.Count + 1;
	
	Toggle.Name = "Toggle"
	Toggle.Parent = Top
	Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.BackgroundTransparency = 1.000
	Toggle.BorderSizePixel = 0
	Toggle.LayoutOrder = 1
	Toggle.Position = UDim2.new(0.882352948, 0, 0, 0)
	Toggle.Rotation = 180.000
	Toggle.Size = UDim2.new(0, 20, 0, 20)
	Toggle.ZIndex = 3
	Toggle.Font = Enum.Font.SourceSans
	Toggle.LineHeight = 2.000
	Toggle.Text = "▲"
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.TextSize = 20.000
	Toggle.TextWrapped = true
	
	Title.Name = "Title"
	Title.Parent = Top
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.0294117648, 0, 0, 0)
	Title.Size = UDim2.new(0, 145, 0, 20)
	Title.ZIndex = 3
	Title.Font = Enum.Font.SourceSans
	Title.Text = WindowName
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 18.000
	Title.TextWrapped = true
	Title.TextXAlignment = Enum.TextXAlignment.Left
	
	Main.Name = "Main"
	Main.ClipsDescendants = true
	Main.Parent = Top
	Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main.BackgroundTransparency = 1.000
	Main.Position = UDim2.new(0, 0, 0.100000001, 0)
	Main.Size = UDim2.new(0, 170, 0, 400)
	Main.Image = "rbxassetid://3570695787"
	Main.ImageColor3 = Color3.fromRGB(70, 70, 70)
	Main.ScaleType = Enum.ScaleType.Slice
	Main.SliceCenter = Rect.new(100, 100, 100, 100)
	Main.SliceScale = 0.040
	
	UIGridLayout.Parent = Main
	UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
	UIGridLayout.CellSize = UDim2.new(0, 170, 0, 25)
	UIGridLayout.FillDirectionMaxCells = 1
	
	UIPadding.Parent = Main
	UIPadding.PaddingTop = UDim.new(0, 20)
	
	local Toggled = true;
	local TweenService = game:GetService"TweenService"
	local tween = TweenService:Create(
	    Toggle,
	    TweenInfo.new(0.2),
	    {
	        Rotation = 180
	    }
	)
	local tween2 = TweenService:Create(
	    Toggle,
	    TweenInfo.new(0.2),
	    {
	        Rotation = 270
	    }
	)
	dragger.new(Top)
	
	Toggle.MouseButton1Down:Connect(function()
		Toggled = not Toggled
		if not Toggled then
			Main.ClipsDescendants = true
			Main:TweenSize(UDim2.new(0, 170, 0, 0), nil, nil, 0.2)
			tween2:Play()
		else
			Main:TweenSize(UDim2.new(0, 170, 0, ((#Main:GetChildren() - 2) * 25) + 25), nil, nil, 0.2)
			tween:Play()
			wait(0.2)
			Main.ClipsDescendants = false
		end
	end)
	
	function EpicLibrary:Toggle(name, options, callback)
		local name = name or "Toggle"
		local default = options.default or false
		local callback = callback or function() end
		local Toggle = Instance.new("Frame")
		local ToggleButton = Instance.new("TextButton")
		local Image = Instance.new("ImageLabel")
		local TextLabel = Instance.new("TextLabel")
		
		Toggle.Name = "Toggle"
		Toggle.Parent = Main
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1.000
		Toggle.LayoutOrder = 1
		Toggle.Size = UDim2.new(0, 100, 0, 100)
		
		ToggleButton.Name = "ToggleButton"
		ToggleButton.Parent = Toggle
		ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
		ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleButton.BackgroundTransparency = 1.000
		ToggleButton.BorderSizePixel = 0
		ToggleButton.Position = UDim2.new(0.899999976, 0, 0.5, 0)
		ToggleButton.Selectable = false
		ToggleButton.Size = UDim2.new(0, 20, 0, 20)
		ToggleButton.ZIndex = 2
		ToggleButton.Font = Enum.Font.SourceSansBold
		ToggleButton.Text = ""
		ToggleButton.TextColor3 = Color3.fromRGB(70, 70, 70)
		ToggleButton.TextSize = 20.000
		ToggleButton.TextWrapped = true
		
		Image.Name = "Image"
		Image.Parent = ToggleButton
		Image.Active = true
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		Image.BackgroundTransparency = 1.000
		Image.BorderSizePixel = 0
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Selectable = true
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.Image = "rbxassetid://3570695787"
		Image.ImageColor3 = Color3.fromRGB(100, 100, 100)
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		
		TextLabel.Parent = Toggle
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0.052941177, 0, 0, 0)
		TextLabel.Size = UDim2.new(0, 129, 0, 25)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = name
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 16.000
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		local Toggle = default
		local function Fire()
			Toggle = not Toggle
			ToggleButton.Text = Toggle and utf8.char(10003) or ""
			Image.ImageColor3 = Toggle and Color or Color3.fromRGB(100, 100, 100)
			pcall(callback, Toggle)
		end
		ToggleButton.Text = Toggle and utf8.char(10003) or ""
		Image.ImageColor3 = Toggle and Color or Color3.fromRGB(100, 100, 100)
		ToggleButton.MouseButton1Down:Connect(Fire)
		
		Main.Size = UDim2.new(0, 170, 0, ((#Main:GetChildren() - 2) * 25) + 25)
	end
	
	function EpicLibrary:Box(name, options, callback)
		local name = name or "TextBox"
		local default = options.default or "";
		local placeholdertext = options.placeholdertext or ""
		local type = string.lower(options.type) or "string"
		local Min = options.min or 0
		local Max = options.max or math.huge
		local callback = callback or function() end
		
		if type == 'number' and not tonumber(default) then
			default = ""
		end
		
		local TextBox = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local TextBox_2 = Instance.new("TextBox")
		local Image = Instance.new("ImageLabel")

		TextBox.Name = "TextBox"
		TextBox.Parent = Main
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.LayoutOrder = 1
		TextBox.Size = UDim2.new(0, 100, 0, 100)
		
		TextLabel.Parent = TextBox
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0.052941177, 0, 0, 0)
		TextLabel.Size = UDim2.new(0, 88, 0, 25)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = name
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 16.000
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		TextBox_2.Parent = TextBox
		TextBox_2.AnchorPoint = Vector2.new(0.5, 0.5)
		TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox_2.BackgroundTransparency = 1.000
		TextBox_2.Position = UDim2.new(0.764705896, 0, 0.5, 0)
		TextBox_2.Size = UDim2.new(0, 66, 0, 22)
		TextBox_2.ZIndex = 2
		TextBox_2.Font = Enum.Font.SourceSans
		TextBox_2.PlaceholderText = placeholdertext
		TextBox_2.Text = default
		TextBox_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox_2.TextSize = 15.000
		
		Image.Name = "Image"
		Image.Parent = TextBox_2
		Image.Active = true
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		Image.BackgroundTransparency = 1.000
		Image.BorderSizePixel = 0
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Selectable = true
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.Image = "rbxassetid://3570695787"
		Image.ImageColor3 = Color3.fromRGB(100, 100, 100)
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		Main.Size = UDim2.new(0, 170, 0, ((#Main:GetChildren() - 2) * 25) + 25)
		local old = TextBox_2.Text
		function PositiveIntegerMask(text)
			return text:gsub("[^%-%d]", "")
		end
		TextBox_2:GetPropertyChangedSignal("Text"):Connect(function()
			if(type == "number") then
				TextBox_2.Text = PositiveIntegerMask(TextBox_2.Text)
			end
		end)
		TextBox_2.FocusLost:connect(function()
			if(type == "number") then
				if old == "" then old = tostring(0) end
				if TextBox_2.Text == "" then TextBox_2.Text = tostring(0) end
				if(tonumber(TextBox_2.Text) > Max) then TextBox_2.Text = tostring(Max) end
				if(tonumber(TextBox_2.Text) < Min) then TextBox_2.Text = tostring(Min) end
				pcall(callback, TextBox_2, tonumber(TextBox_2.Text), tonumber(old))
			end
			old = TextBox_2.Text
		end)
		return Toggle;
	end
	
	function EpicLibrary:Button(name, callback)
		local name = name or "Button"
		local callback = callback or function() end
		
		local Button = Instance.new("Frame")
		local MainButton = Instance.new("TextButton")
		local Image = Instance.new("ImageLabel")
		
		Button.Name = "Button"
		Button.Parent = Main
		Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundTransparency = 1.000
		Button.LayoutOrder = 1
		Button.Size = UDim2.new(0, 100, 0, 100)
		
		MainButton.Name = "Button"
		MainButton.Parent = Button
		MainButton.AnchorPoint = Vector2.new(0.5, 0.5)
		MainButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		MainButton.BackgroundTransparency = 1.000
		MainButton.BorderSizePixel = 0
		MainButton.Position = UDim2.new(0.5, 0, 0.5, 0)
		MainButton.Size = UDim2.new(0, 160, 0, 20)
		MainButton.ZIndex = 2
		MainButton.Font = Enum.Font.SourceSans
		MainButton.Text = name
		MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		MainButton.TextSize = 17.000
		MainButton.TextWrapped = true
		
		Image.Name = "Image"
		Image.Parent = MainButton
		Image.Active = true
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		Image.BackgroundTransparency = 1.000
		Image.BorderSizePixel = 0
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Selectable = true
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.Image = "rbxassetid://3570695787"
		Image.ImageColor3 = Color
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		
		MainButton.MouseButton1Down:Connect(function()
			pcall(callback)
		end)
		MainButton.MouseEnter:Connect(function()
			MainButton.BackgroundTransparency = 0.75  
		end)
		MainButton.MouseLeave:Connect(function()
			MainButton.BackgroundTransparency = 1
		end)
		Main.Size = UDim2.new(0, 170, 0, ((#Main:GetChildren() - 2) * 25) + 25)
		return Button;
	end
	
	function EpicLibrary:Dropdown(name, options, callback)
		local name = name or "Dropdown"
		local list = options.List or {}
		local callback = callback or function() end
		local Toggled = false
		local DropDown = Instance.new("Frame")
		local DropDownButton = Instance.new("TextButton")
		local Image = Instance.new("ImageLabel")
		local DropDownMenu = Instance.new("ImageLabel")
		local UIGridLayout = Instance.new("UIGridLayout")
		local UIPadding = Instance.new("UIPadding")
		local Button_2 = Instance.new("TextButton")
		local Dropdown = Instance.new("TextButton")

		DropDown.Name = "DropDown"
		DropDown.Parent = Main
		DropDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropDown.BackgroundTransparency = 1.000
		DropDown.LayoutOrder = 1
		DropDown.Size = UDim2.new(0, 100, 0, 100)
		
		DropDownButton.Name = "Button"
		DropDownButton.Parent = DropDown
		DropDownButton.AnchorPoint = Vector2.new(0.5, 0.5)
		DropDownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropDownButton.BackgroundTransparency = 1.000
		DropDownButton.BorderSizePixel = 0
		DropDownButton.Position = UDim2.new(0.5, 0, 0.5, 0)
		DropDownButton.Size = UDim2.new(0, 160, 0, 20)
		DropDownButton.ZIndex = 5
		DropDownButton.Font = Enum.Font.SourceSans
		DropDownButton.Text = name
		DropDownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		DropDownButton.TextSize = 17.000
		DropDownButton.TextWrapped = true
		
		Image.Name = "Image"
		Image.Parent = DropDownButton
		Image.Active = true
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		Image.BackgroundTransparency = 1.000
		Image.BorderSizePixel = 0
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Selectable = true
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.ZIndex = 4
		Image.Image = "rbxassetid://3570695787"
		Image.ImageColor3 = Color3.fromRGB(100, 100, 100)
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		
		DropDownMenu.Name = "Menu"
		DropDownMenu.Parent = DropDownButton
		DropDownMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropDownMenu.BackgroundTransparency = 1.000
		DropDownMenu.Size = UDim2.new(0, 160, 0, 20)
		DropDownMenu.Image = "rbxassetid://3570695787"
		DropDownMenu.ZIndex = 3
		DropDownMenu.ImageColor3 = Color3.fromRGB(50, 50, 50)
		DropDownMenu.ScaleType = Enum.ScaleType.Slice
		DropDownMenu.SliceCenter = Rect.new(100, 100, 100, 100)
		DropDownMenu.SliceScale = 0.040
		DropDownMenu.ClipsDescendants = true
		
		UIGridLayout.Parent = DropDownMenu
		UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
		UIGridLayout.CellSize = UDim2.new(0, 158, 0, 20)
		
		UIPadding.Parent = DropDownMenu
		UIPadding.PaddingTop = UDim.new(0, 20)
		
		Dropdown.Name = "Dropdown"
		Dropdown.Parent = DropDownButton
		Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Dropdown.BackgroundTransparency = 1.000
		Dropdown.BorderSizePixel = 0
		Dropdown.LayoutOrder = 1
		Dropdown.Position = UDim2.new(0.86985296, 0, 0, 0)
		Dropdown.Rotation = 270.000
		Dropdown.Size = UDim2.new(0, 20, 0, 20)
		Dropdown.ZIndex = 5
		Dropdown.Font = Enum.Font.SourceSans
		Dropdown.LineHeight = 2.000
		Dropdown.Text = "▲"
		Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
		Dropdown.TextSize = 20.000
		Dropdown.TextWrapped = true
		
		local TweenService = game:GetService"TweenService"
		local up = TweenService:Create(
		    Dropdown,
		    TweenInfo.new(0.2),
		    {
		        Rotation = 270
		    }
		)
		local down = TweenService:Create(
		    Dropdown,
		    TweenInfo.new(0.2),
		    {
		        Rotation = 180
		    }
		)
		
		function Toggle()
			Toggled = not Toggled
			if(Toggled) then
				down:Play()
				DropDownMenu:TweenSize(UDim2.new(0,160,0,((#DropDownMenu:GetChildren() - 2) * 21) + 20), nil, nil, 0.2)
			else
				up:Play()
				DropDownMenu:TweenSize(UDim2.new(0,160,0, 20), nil, nil, 0.2)
			end
		end
		
		for i,v in pairs(list) do
			local Button = Instance.new("TextButton")
			Button.Name = v
			Button.Parent = DropDownMenu
			Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(0, 200, 0, 50)
			Button.Visible = false
			Button.Text = v
			Button.ZIndex = 4
			Button.Font = Enum.Font.SourceSans
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.TextSize = 14.000
			Button.MouseButton1Down:Connect(function()
				DropDownButton.Text = v
				Toggle()
				pcall(callback, v)
			end)
		end
		Dropdown.MouseButton1Down:Connect(Toggle)
		DropDownButton.MouseButton1Down:Connect(Toggle)
		Main.Size = UDim2.new(0, 170, 0, ((#Main:GetChildren() - 2) * 25) + 25)
		return DropDown;
	end
	
	function EpicLibrary:Label(name)
		name = name or "Label"
		local Label = Instance.new("Frame")
		local Label_2 = Instance.new("TextLabel")
		Label.Name = "Label"
		Label.Parent = Main
		Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Label.BackgroundTransparency = 1.000
		Label.LayoutOrder = 1
		Label.Size = UDim2.new(0, 100, 0, 100)
		
		Label_2.Name = "Label"
		Label_2.Parent = Label
		Label_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Label_2.BackgroundTransparency = 1.000
		Label_2.Size = UDim2.new(0, 170, 0, 25)
		Label_2.Font = Enum.Font.SourceSans
		Label_2.Text = name
		Label_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Label_2.TextSize = 16.000
		Main.Size = UDim2.new(0, 170, 0, ((#Main:GetChildren() - 2) * 25) + 25)
		return Label;
	end
	
	function EpicLibrary:Section(name)
		name = name or "Section"
		local Section = Instance.new("Frame")
		local Section_2 = Instance.new("TextLabel")

		Section.Name = "Section"
		Section.Parent = Main
		Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Section.BackgroundTransparency = 1.000
		Section.LayoutOrder = 1
		Section.Size = UDim2.new(0, 100, 0, 100)
		
		Section_2.Name = "Section"
		Section_2.Parent = Section
		Section_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Section_2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		Section_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Section_2.BorderSizePixel = 0
		Section_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Section_2.Size = UDim2.new(0, 170, 0, 23)
		Section_2.Font = Enum.Font.SourceSans
		Section_2.Text = name
		Section_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Section_2.TextSize = 16.000
		Main.Size = UDim2.new(0, 170, 0, ((#Main:GetChildren() - 2) * 25) + 25)
		return Section;
	end
	
	function EpicLibrary:Slider(name, options, callback)
        local min = options.min or 0
        local max = options.max or 1
		local step = options.step or 1
		
		local Slider = Instance.new("Frame")
		local SliderBack = Instance.new("ImageLabel")
		local SliderFill = Instance.new("ImageLabel")
		local Handle = Instance.new("TextButton")
		local Label = Instance.new("TextLabel")
		local Amount = Instance.new("TextLabel")
		local UIS = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
		
		Slider.Name = "Slider"
		Slider.Parent = Main
		Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Slider.BackgroundTransparency = 1.000
		Slider.LayoutOrder = 1
		Slider.Size = UDim2.new(0, 100, 0, 100)
		
		SliderBack.Name = "SliderBack"
		SliderBack.Parent = Slider
		SliderBack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderBack.BackgroundTransparency = 1.000
		SliderBack.Position = UDim2.new(0.0411764756, 0, 0.639999986, 0)
		SliderBack.Size = UDim2.new(0, 155, 0, 5)
		SliderBack.Image = "rbxassetid://3570695787"
		SliderBack.ImageColor3 = Color3.fromRGB(100, 100, 100)
		SliderBack.ScaleType = Enum.ScaleType.Slice
		SliderBack.SliceCenter = Rect.new(100, 100, 100, 100)
		SliderBack.SliceScale = 0.040
		
		SliderFill.Name = "SliderFill"
		SliderFill.Parent = Slider
		SliderFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderFill.BackgroundTransparency = 1.000
		SliderFill.Position = UDim2.new(0.0411764719, 0, 0.639999986, 0)
		SliderFill.Size = UDim2.new(0, 80, 0, 5)
		SliderFill.Image = "rbxassetid://3570695787"
		SliderFill.ImageColor3 = Color3.fromRGB(0, 170, 255)
		SliderFill.ScaleType = Enum.ScaleType.Slice
		SliderFill.SliceCenter = Rect.new(100, 100, 100, 100)
		SliderFill.SliceScale = 0.040
		
		Handle.Name = "Handle"
		Handle.Parent = SliderFill
		Handle.AnchorPoint = Vector2.new(0.5, 0.5)
		Handle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Handle.BackgroundTransparency = 1
		Handle.BorderSizePixel = 0
		Handle.Position = UDim2.new(1, 0, 0.5, 0)
		Handle.Size = UDim2.new(0, 15, 0, 20)
		Handle.AutoButtonColor = false
		Handle.Font = Enum.Font.SourceSans
		Handle.Text = ""
		Handle.TextColor3 = Color3.fromRGB(0, 0, 0)
		Handle.TextSize = 14.000
		
		Label.Name = "Label"
		Label.Parent = Slider
		Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Label.BackgroundTransparency = 1.000
		Label.Position = UDim2.new(0.052941177, 0, 0, 0)
		Label.Size = UDim2.new(0, 88, 0, 16)
		Label.Font = Enum.Font.SourceSans
		Label.Text = name
		Label.TextColor3 = Color3.fromRGB(255, 255, 255)
		Label.TextSize = 15.000
		Label.TextXAlignment = Enum.TextXAlignment.Left
		
		Amount.Name = "Amount"
		Amount.Parent = Slider
		Amount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Amount.BackgroundTransparency = 1.000
		Amount.Position = UDim2.new(0.570588231, 0, 0, 0)
		Amount.Size = UDim2.new(0, 65, 0, 16)
		Amount.Font = Enum.Font.SourceSans
		Amount.Text = min
		Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
		Amount.TextSize = 15.000
		Amount.TextXAlignment = Enum.TextXAlignment.Right
		local held = false
		local function snap(number, factor)
			if factor == 0 then return number else
				return math.floor(number/factor+0.5)*factor
			end
		end
		
		UIS.InputEnded:connect(function(input, processed)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				held = false
			end
		end)
			
		Handle.MouseButton1Down:connect(function()
			held = true
		end)
			
		RunService.RenderStepped:connect(function(delta)
			if held then
				local Mpos = UIS:GetMouseLocation()
				local RelitivePos = Mpos - SliderBack.AbsolutePosition
				SliderFill.Size = UDim2.new(0, snap(math.clamp(RelitivePos.X, 0, SliderBack.AbsoluteSize.X),(step / (max - min))* SliderBack.AbsoluteSize.X), 0, 5)
				local Precentage = SliderFill.AbsoluteSize.X / SliderBack.AbsoluteSize.X
				if step%1 > 0 then Amount.Text = math.ceil(((Precentage * (max - min)) + min) * 10) / 10 else
				Amount.Text = math.ceil((Precentage * (max - min)) + min) end
			end
		end)
		
		Amount:GetPropertyChangedSignal("Text"):Connect(function()
			pcall(callback, tonumber(Amount.Text))
		end)
		
		Main.Size = UDim2.new(0, 170, 0, ((#Main:GetChildren() - 2) * 25) + 25)
		return Slider;
	end
	function EpicLibrary:Destroy()
		Top:Destroy()
	end
	return EpicLibrary;
end
return Library;
