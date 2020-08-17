local Library = {toggled = false}
local TweenService = game:GetService("TweenService")
local ScreenGui = Instance.new("ScreenGui")
function Drag(GuiObject)
local Dragging=false
GuiObject.Active=true
GuiObject.Selectable=true
local RelitivePos=Vector2.new(0,0)
GuiObject.InputBegan:Connect(function(input)
local Mouse=game.Players.LocalPlayer:GetMouse()
if input.UserInputType==Enum.UserInputType.MouseButton1 then
RelitivePos=Vector2.new(Mouse.X,Mouse.Y)-GuiObject.AbsolutePosition
Dragging=true
end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input,gameProcessed)
if input.UserInputType==Enum.UserInputType.MouseMovement and Dragging then
local Mouse=game.Players.LocalPlayer:GetMouse()
GuiObject.Parent:TweenPosition(UDim2.new(0,Mouse.X-RelitivePos.X,0,Mouse.Y-RelitivePos.Y),"Out","Quad",0.2,true)
end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
Dragging=false
end
end)
end

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end
local Parent
if syn then
    syn.protect_gui(ScreenGui)
end
if get_hidden_gui then
	Parent = get_hidden_gui()
else
	Parent = game:GetService("CoreGui")
end
ScreenGui.Parent = game:GetService("RunService"):IsStudio() and game.Players.LocalPlayer:WaitForChild("PlayerGui") or Parent
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647

function Library:CreateWindow(...)
	local Window = {toggled = true, flags = {}, parent = nil}
	local Args = {...}
	local Name = Args[1] or "Window"
	local Main = Instance.new("ImageLabel")
	local UIListLayout = Instance.new("UIListLayout")
	local Top = Instance.new("ImageLabel")
	local Title = Instance.new("TextLabel")
	local Toggle = Instance.new("TextButton")
	local Image = Instance.new("ImageLabel")
	Main.Parent = ScreenGui
	Main.Active = true
	Main.BackgroundTransparency = 1
	Main.Position = UDim2.new(0, 20, 0, 20)
	Main.Selectable = true
	Main.Size = UDim2.new(0, 200, 0, 224)
	Main.Image = "rbxassetid://3570695787"
	Main.ImageColor3 = Color3.fromRGB(30, 30, 30)
	Main.ScaleType = Enum.ScaleType.Slice
	Main.SliceCenter = Rect.new(100, 100, 100, 100)
	Main.SliceScale = 0.040
	Window.parent = Main

	UIListLayout.Parent = Main
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Main.Size = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X, UIListLayout.AbsoluteContentSize.Y + 3)
	end)
	
	Drag(Top)
	Top.Parent = Main
	Top.BackgroundTransparency = 1
	Top.Position = UDim2.new(0, 20, 0, 20)
	Top.Size = UDim2.new(1, 0, 0, 35)
	Top.Image = "rbxassetid://3570695787"
	Top.ImageColor3 = Color3.fromRGB(20, 20, 20)
	Top.ScaleType = Enum.ScaleType.Slice
	Top.SliceCenter = Rect.new(100, 100, 100, 100)
	Top.SliceScale = 0.040
	
	Title.Parent = Top
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, 0, 1, 0)
	Title.Font = Enum.Font.Gotham
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 18
	Title.Text = Name
	Title.TextWrapped = true
	
	Toggle.Parent = Top
	Toggle.AnchorPoint = Vector2.new(1, 0.5)
	Toggle.BackgroundTransparency = 1
	Toggle.Position = UDim2.new(1, -5, 0.5, 0)
	Toggle.Size = UDim2.new(0, 25, 0, 25)
	Toggle.Font = Enum.Font.SourceSans
	Toggle.Text = ""
	Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
	
	Image.Parent = Toggle
	Image.AnchorPoint = Vector2.new(0.5, 0.5)
	Image.BackgroundTransparency = 1
	Image.Position = UDim2.new(0.5, 0, 0.5, 0)
	Image.Rotation = 90
	Image.Size = UDim2.new(0.4, 0, 0.4, 0)
	Image.Image = "rbxassetid://4918373417"
	Image.ImageColor3 = Color3.fromRGB(80, 80, 80)
	
	local down = TweenService:Create( Image, TweenInfo.new(0.2),{ Rotation = 90 })
	local up = TweenService:Create( Image, TweenInfo.new(0.2),{ Rotation = 180 })
	
	Toggle.MouseButton1Click:Connect(function()
		Window.toggled = not Window.toggled
		Main.ClipsDescendants = true
		Main:TweenSize((Window.toggled and UDim2.new(0,Main.Size.X.Offset,0, UIListLayout.AbsoluteContentSize.Y) or UDim2.new(0,Main.Size.X.Offset,0, 35)), nil, nil, 0.2, true)
		if Window.toggled then
			down:Play()
		else
			up:Play()
		end
	end)
	
	function Window:Button(...)
		local Args = {...}
		local ButtonSelf = {}
		local Name = Args[1] or "Button"
		local Callback = Args[2] or function() end
		local Button = Instance.new("Frame")
		local TextButton = Instance.new("TextButton")
		local Image = Instance.new("ImageLabel")

		Button.Parent = self.parent
		Button.BackgroundTransparency = 1
		Button.Size = UDim2.new(1, 0, 0, 30)
		
		TextButton.Parent = Button
		TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
		TextButton.BackgroundTransparency = 1
		TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextButton.Size = UDim2.new(1, -10, 0, 25)
		TextButton.Text = Name
		TextButton.ZIndex = 2
		TextButton.Font = Enum.Font.Gotham
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 16
		
		Image.Parent = TextButton
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundTransparency = 1
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.Image = "rbxassetid://3570695787"
		Image.ImageColor3 = Color3.fromRGB(45, 45, 45)
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		
		function ButtonSelf:Fire()
			local Success, Err = pcall(Callback)
			if not Success then
				error(Err)
			end
		end
		
		local Normal = TweenService:Create(Image, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(45,45,45)})
		local Hovering = TweenService:Create(Image, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(38,38,38)})
		local Pressed = TweenService:Create(Image, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(255,75,75)})
		
		TextButton.MouseButton1Click:Connect(function()
			local Success, Err = pcall(Callback)
			if not Success then
				error(Err)
			end
		end)
		
		TextButton.MouseButton1Down:Connect(function()
			Pressed:Play()
		end)
		
		TextButton.MouseButton1Up:Connect(function()
			Hovering:Play()
		end)
		
		TextButton.MouseEnter:Connect(function()
			Hovering:Play()
		end)
		TextButton.MouseLeave:Connect(function()
			Normal:Play()
		end)
		return ButtonSelf
	end
	
	function Window:Box(...)
		Args = {...}
		local SelfBox = {}
		local Name = Args[1] or "TextBox"
		local Options = Args[2] or {}
		local Type = Options.type or "string"
		Type = string.lower(Type)
		local Min = Options.min or 0
		local Max = Options.max or 9e9
		local flag = Options.flag or ""
		local Location = Options.location or Window.flags
		local Callback = Args[3] or function() end
		local Placeholder = Options.placeholder or ""
		local Default = Options.default or (Type == "number" and 0 or "")
		if flag ~= "" then
			Location[flag] = Default
		end
		
		local Name = Args[1] or "Box"
		local Box = Instance.new("Frame")
		local Outline = Instance.new("ImageLabel")
		local Center = Instance.new("ImageLabel")
		local Title = Instance.new("TextLabel")
		local TextBox = Instance.new("TextBox")

		Box.Parent = self.parent
		Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Box.BackgroundTransparency = 1
		Box.ClipsDescendants = true
		Box.Size = UDim2.new(1, 0, 0, 40)
		
		Outline.Parent = Box
		Outline.AnchorPoint = Vector2.new(0.5, 0.5)
		Outline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Outline.BackgroundTransparency = 1
		Outline.Position = UDim2.new(0.5, 0, 0.5, 0)
		Outline.Size = UDim2.new(1, -8, 1, -8)
		Outline.Image = "rbxassetid://3570695787"
		Outline.ImageColor3 = Color3.fromRGB(60, 60, 60)
		Outline.ScaleType = Enum.ScaleType.Slice
		Outline.SliceCenter = Rect.new(100, 100, 100, 100)
		Outline.SliceScale = 0.040
		
		Center.Parent = Box
		Center.AnchorPoint = Vector2.new(0.5, 0.5)
		Center.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Center.BackgroundTransparency = 1
		Center.Position = UDim2.new(0.5, 0, 0.5, 0)
		Center.Size = UDim2.new(1, -12, 1, -12)
		Center.Image = "rbxassetid://3570695787"
		Center.ImageColor3 = Color3.fromRGB(30, 30, 30)
		Center.ScaleType = Enum.ScaleType.Slice
		Center.SliceCenter = Rect.new(100, 100, 100, 100)
		Center.SliceScale = 0.040
		
		Title.Parent = Box
		Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0, 10, 0, 0)
		Title.Font = Enum.Font.GothamBold
		Title.Text = Name
		Title.TextColor3 = Color3.fromRGB(100, 100, 100)
		Title.TextSize = 14
		Title.Size = UDim2.new(0, Title.TextBounds.X + 7, 0, 15)
		
		TextBox.Parent = Box
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1
		TextBox.Position = UDim2.new(0, 12, 0, 13)
		TextBox.Size = UDim2.new(0, 182, 0, 18)
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.Gotham
		TextBox.Text = (string.lower(Type) == "number" and (tonumber(Default) and tostring(Default) or tostring(Min)) or Default)
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 16
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		
		local Normal = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(60,60,60)})
		local Hovering = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(100,100,100)})
		local Selected = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(255,75,75)})
		local MouseOver = false
		local old = Default
		
		function SelfBox:Set(val)
			old = TextBox.Text
			if Type == "number" then
				TextBox.Text = math.clamp(tonumber(val), Min, Max)
				if flag ~= "" then
					Location[flag] = tonumber(TextBox.Text)
				end
			else
				if flag ~= "" then
					Location[flag] = TextBox.Text
				end
			end
		end;
		function SelfBox:ChangeCallback(self, val)
			Callback = val
		end
		
        function PositiveIntegerMask(text)
            return text:gsub("[^%-%d]", "")
        end
        TextBox:GetPropertyChangedSignal("Text"):Connect(function()
            if Type == "number" then
                TextBox.Text = PositiveIntegerMask(TextBox.Text)
            end
		end)
		
		TextBox.Focused:Connect(function()
			Selected:Play()
		end)
		
		TextBox.FocusLost:Connect(function(EnterPressed)
			if MouseOver then
				Hovering:Play()
			else
				Normal:Play()
			end
			if Type == "number" then
				TextBox.Text = math.clamp(tonumber(TextBox.Text), Min, Max)
				if flag ~= "" then
					Location[flag] = tonumber(TextBox.Text)
				end
				local Success, Err = pcall(Callback, tonumber(TextBox.Text), tonumber(old), EnterPressed, TextBox, SelfBox)
			else
				if flag ~= "" then
					Location[flag] = TextBox.Text
				end
				local Success, Err = pcall(Callback, TextBox.Text, old, EnterPressed, TextBox, SelfBox)
			end
			old = TextBox.Text
		end)
		
		Box.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				TextBox:CaptureFocus()
			end
		end)
		
		Box.MouseEnter:Connect(function()
			MouseOver = true
			if not TextBox:IsFocused() then
				Hovering:Play()
			end
		end)
		Box.MouseLeave:Connect(function()
			MouseOver = false
			if not TextBox:IsFocused() then
				Normal:Play()
			end
		end)
		
		return Box
	end
	
	function Window:Dropdown(...)
		local Args = {...}
		local selfDropdown = {}
		local Name = Args[1] or "DropDown"
		local callback = Args[3] or function()end
        local List = Args[2] and Args[2].list or {}
        local old = ""
		local Toggled = false
		local Location = (Args[2] and Args[2].location) and Args[2].location or Window.flags
		local flag = Args[2] and Args[2].flag or ""
        if flag ~= "" then
            Location[flag] = tostring(List[1])
		end
		
		local Dropdown = Instance.new("Frame")
		local Button = Instance.new("TextButton")
		local Image = Instance.new("ImageLabel")
		local Toggle = Instance.new("TextLabel")
		local Image_2 = Instance.new("ImageLabel")

		Dropdown.Parent = self.parent
		Dropdown.BackgroundTransparency = 1
		Dropdown.Size = UDim2.new(1, 0, 0, 30)
		
		Button.Parent = Dropdown
		Button.AnchorPoint = Vector2.new(0.5, 0.5)
		Button.BackgroundTransparency = 1
		Button.Position = UDim2.new(0.5, 0, 0.5, 0)
		Button.Size = UDim2.new(1, -10, 0, 25)
		Button.ZIndex = 3
		Button.Font = Enum.Font.Gotham
		Button.Text = tostring(List[1])
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button.TextSize = 16

		Image.Parent = Button
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundTransparency = 1
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.ZIndex = 2
		Image.Image = "rbxassetid://3570695787"
		Image.ImageColor3 = Color3.fromRGB(45, 45, 45)
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		
		Toggle.Parent = Button
		Toggle.Active = true
		Toggle.AnchorPoint = Vector2.new(1, 0.5)
		Toggle.BackgroundTransparency = 1
		Toggle.Position = UDim2.new(1, 0, 0.5, 0)
		Toggle.Selectable = true
		Toggle.Size = UDim2.new(0, 25, 0, 25)
		Toggle.ZIndex = -1
		Toggle.Font = Enum.Font.SourceSans
		Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
		
		Image_2.Parent = Toggle
		Image_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Image_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Image_2.BackgroundTransparency = 1
		Image_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image_2.Rotation = 180
		Image_2.Size = UDim2.new(0.400000006, 0, 0.400000006, 0)
		Image_2.ZIndex = 2
		Image_2.Image = "rbxassetid://4918373417"
		Image_2.ImageColor3 = Color3.fromRGB(156, 156, 156)
		
        old = Button.Text

        local down = TweenService:Create(Image_2,TweenInfo.new(0.2),{Rotation = 90})
        local up = TweenService:Create(Image_2,TweenInfo.new(0.2),{Rotation = 180})
		local function CreateDropDown(Array)
			self.parent.ClipsDescendants = false
			Main.ClipsDescendants = false
			local Dropdown1 = Instance.new("ImageLabel")
			
			Dropdown1.Name = "Dropdown"
 			Dropdown1.Parent = Button
			Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
			Dropdown1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown1.BackgroundTransparency = 1
			Dropdown1.Position = UDim2.new(0.5, 0, 0, 0)
			Dropdown1.Size = UDim2.new(1, 0, 0, 0)
			Dropdown1.Image = "rbxassetid://3570695787"
			Dropdown1.ImageColor3 = Color3.fromRGB(42, 42, 42)
			Dropdown1.ScaleType = Enum.ScaleType.Slice
			Dropdown1.SliceCenter = Rect.new(100, 100, 100, 100)
			Dropdown1.SliceScale = 0.040
			Dropdown1.ClipsDescendants = true
			Dropdown1.ZIndex = 5	
			if #Array <= 5 then
				local UIGridLayout = Instance.new("UIGridLayout")
				local UIPadding = Instance.new("UIPadding")
				UIGridLayout.Parent = Dropdown1
				UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
				UIGridLayout.CellSize = UDim2.new(1, 0, 0, 24)
				
				UIPadding.Parent = Dropdown1
				UIPadding.PaddingTop = UDim.new(0, 25)
				
				Button.Text = Name
				Button.TextColor3 = Color3.fromRGB(120,120,120)
				
				for	i,v in pairs(Array) do
					local TextButton = Instance.new("TextButton")
					local Image_3 = Instance.new("ImageLabel")
					
					TextButton.Parent = Dropdown1
					TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
					TextButton.BackgroundTransparency = 1
					TextButton.BorderSizePixel = 0
					TextButton.Size = UDim2.new(0, 200, 0, 50)
					TextButton.ZIndex = 2
					TextButton.Text = tostring(v)
					TextButton.Font = Enum.Font.SourceSans
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.TextSize = 18
					TextButton.ZIndex = 7
					
					Image_3.Name = "Image"
					Image_3.Parent = TextButton
					Image_3.Active = true
					Image_3.AnchorPoint = Vector2.new(0.5, 0.5)
					Image_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Image_3.BackgroundTransparency = 1
					Image_3.Position = UDim2.new(0.5, 0, 0.5, 0)
					Image_3.Selectable = true
					Image_3.Size = UDim2.new(1, 0, 1, 0)
					Image_3.Image = "rbxassetid://3570695787"
					Image_3.ImageColor3 = Color3.fromRGB(50, 50, 50)
					Image_3.ScaleType = Enum.ScaleType.Slice
					Image_3.SliceCenter = Rect.new(100, 100, 100, 100)
					Image_3.SliceScale = i == #Array and 0.040 or 0.01
					Image_3.ZIndex = 6
					
					local Normal = TweenService:Create(Image_3, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(50,50,50)})
					local Hovering = TweenService:Create(Image_3, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(40,40,40)})
					local Pressed = TweenService:Create(Image_3, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(30,30,30)})
					
					TextButton.MouseButton1Click:Connect(function()
						Button.Text = TextButton.Text
						old = TextButton.Text
						Toggled = false
						up:Play()
						Image.SliceCenter = Rect.new(100, 100, 100, 100)
				        if flag ~= "" then
				            Location[flag] = TextButton.Text
						end
						Button.TextColor3 = Color3.fromRGB(255,255,255)
						Dropdown1:TweenSize(UDim2.new(1,0,0,0),nil,nil,0.2,true,function()
							Image.ZIndex = 2
							Image_2.ZIndex = 3
							Button.ZIndex = 3
							Dropdown1:Destroy()
						end)
						local Success, Err = pcall(callback, TextButton.Text)
						if not Success then
							error(Err)
						end
					end)
					TextButton.MouseButton1Down:Connect(function()
						Pressed:Play()
					end)
					TextButton.MouseEnter:Connect(function()
						Hovering:Play()
					end)
					TextButton.MouseLeave:Connect(function()
						Normal:Play()
					end)
				end
				Dropdown1:TweenSize(UDim2.new(1,0,0,UIGridLayout.AbsoluteContentSize.Y + 25),nil,nil,0.2,true)
			else
				local UIGridLayout = Instance.new("UIGridLayout")
				local UIPadding = Instance.new("UIPadding")
				local ScrollingFrame = Instance.new("ScrollingFrame")

				ScrollingFrame.Parent = Dropdown1
				ScrollingFrame.Active = true
				ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame.BackgroundTransparency = 1
				ScrollingFrame.BorderSizePixel = 0
				ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)
				ScrollingFrame.Position = UDim2.new(0, 0, 0, 25)
				ScrollingFrame.Size = UDim2.new(1, 0, 1, -25)
				ScrollingFrame.ZIndex = 5
				ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
				ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
				ScrollingFrame.ScrollBarThickness = 5
				
				UIGridLayout.Parent = ScrollingFrame
				UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
				UIGridLayout.CellSize = UDim2.new(1, 0, 0, 24)
				
				Button.Text = Name
				Button.TextColor3 = Color3.fromRGB(120,120,120)
				
				for	i,v in pairs(Array) do
					local TextButton = Instance.new("TextButton")
					local Image_3 = Instance.new("ImageLabel")
					
					TextButton.Parent = ScrollingFrame
					TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
					TextButton.BackgroundTransparency = 1
					TextButton.BorderSizePixel = 0
					TextButton.Size = UDim2.new(0, 200, 0, 50)
					TextButton.ZIndex = 2
					TextButton.Text = tostring(v)
					TextButton.Font = Enum.Font.SourceSans
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.TextSize = 18
					TextButton.ZIndex = 7
					
					Image_3.Name = "Image"
					Image_3.Parent = TextButton
					Image_3.Active = true
					Image_3.AnchorPoint = Vector2.new(0.5, 0.5)
					Image_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Image_3.BackgroundTransparency = 1
					Image_3.Position = UDim2.new(0.5, 0, 0.5, 0)
					Image_3.Selectable = true
					Image_3.Size = UDim2.new(1, 0, 1, 0)
					Image_3.Image = "rbxassetid://3570695787"
					Image_3.ImageColor3 = Color3.fromRGB(50, 50, 50)
					Image_3.ScaleType = Enum.ScaleType.Slice
					Image_3.SliceCenter = Rect.new(100, 100, 100, 100)
					Image_3.SliceScale = i == #Array and 0.040 or 0.01
					Image_3.ZIndex = 6
					
					local Normal = TweenService:Create(Image_3, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(50,50,50)})
					local Hovering = TweenService:Create(Image_3, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(40,40,40)})
					local Pressed = TweenService:Create(Image_3, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(30,30,30)})
					
					TextButton.MouseButton1Click:Connect(function()
						Button.Text = TextButton.Text
						old = TextButton.Text
						Toggled = false
						up:Play()
						Image.SliceCenter = Rect.new(100, 100, 100, 100)
				        if flag ~= "" then
				            Location[flag] = TextButton.Text
						end
						Button.TextColor3 = Color3.fromRGB(255,255,255)
						Dropdown1:TweenSize(UDim2.new(1,0,0,0),nil,nil,0.2,true,function()
							Image.ZIndex = 2
							Image_2.ZIndex = 3
							Button.ZIndex = 3
							Dropdown1:Destroy()
						end)
						local Success, Err = pcall(callback, TextButton.Text)
						if not Success then
							error(Err)
						end
					end)
					TextButton.MouseButton1Down:Connect(function()
						Pressed:Play()
					end)
					TextButton.MouseEnter:Connect(function()
						Hovering:Play()
					end)
					TextButton.MouseLeave:Connect(function()
						Normal:Play()
					end)
				end
				Dropdown1:TweenSize(UDim2.new(1,0,0,149),nil,nil,0.2,true)
				ScrollingFrame.CanvasSize = UDim2.new(1,0,0,UIGridLayout.AbsoluteContentSize.Y)
			end
		end
		
		local Normal = TweenService:Create(Image, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(45,45,45)})
		local Hovering = TweenService:Create(Image, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(38,38,38)})
		
		local function CloseDropdown()
            if Button:FindFirstChild("Dropdown") then
				up:Play()
				Image.SliceCenter = Rect.new(100, 100, 100, 100)
                Toggled = false
				Button.Text = old
				Button.TextColor3 = Color3.fromRGB(255,255,255)
				Button:FindFirstChild("Dropdown"):TweenSize( UDim2.new(0, 173, 0, 0), "Out", "Quad", 0.2, true, function()
					Image.ZIndex = 2
					Image_2.ZIndex = 3
					Button.ZIndex = 3
                    Button:FindFirstChild("Dropdown"):Destroy()
   	        	end)
        	end
        end
		
		function selfDropdown:Refresh(val)
			CloseDropdown()
			Button.Text = val[1]
			old = val[1]
			List = val
		end
		
		function selfDropdown:ChangeCallback(val)
			callback = val
		end
		
		game:GetService("UserInputService").WindowFocusReleased:Connect(CloseDropdown)
		
		Button.MouseButton1Click:Connect(function()
			Toggled = not Toggled
			if Toggled then 
				Image.ZIndex = 8
				Image_2.ZIndex = 9
				Button.ZIndex = 9
				Image.SliceCenter = Rect.new(100, 100, 100, 200)
				down:Play()
				CreateDropDown(List)
			else
				up:Play()
				Button.Text = old
				Image.SliceCenter = Rect.new(100, 100, 100, 100)
				for i,v in pairs(Button:GetChildren()) do
					if v.Name == "Dropdown" then
						Button.Text = old
						Button.TextColor3 = Color3.fromRGB(255,255,255)
						v:TweenSize(UDim2.new(1,0,0,0),nil,nil,0.2,true,function()
							Image.ZIndex = 2
							Image_2.ZIndex = 3
							Button.ZIndex = 3
							v:Destroy()
						end)
					end
				end
			end
		end)
		Button.MouseEnter:Connect(function()
			Hovering:Play()
		end)
		Button.MouseLeave:Connect(function()
			Normal:Play()
		end)
	end
	
	function Window:Toggle(...)
		local Args = {...}
		local Name = Args[1] or "Toggle"
		local Options = Args[2] or {}
		local Location = Options.location and Options.location or Window.flags
		local Toggled = Options.Default and true or false
		local Callback = Args[3] or function() end
		
		local Toggle = Instance.new("Frame")
		local Title = Instance.new("TextLabel")
		local Outline = Instance.new("ImageLabel")
		local Center = Instance.new("ImageLabel")
		local Checkmark = Instance.new("ImageLabel")

		Toggle.Parent = self.parent
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1
		Toggle.Size = UDim2.new(1, 0, 0, 30)
		
		Title.Parent = Toggle
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, 7, 0, 0)
		Title.Size = UDim2.new(1, -7, 1, 0)
		Title.Font = Enum.Font.Gotham
		Title.Text = Name
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 14
		Title.TextWrapped = true
		Title.TextXAlignment = Enum.TextXAlignment.Left

		Outline.Parent = Toggle
		Outline.AnchorPoint = Vector2.new(1, 0.5)
		Outline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Outline.BackgroundTransparency = 1
		Outline.Position = UDim2.new(1, -5, 0.5, 0)
		Outline.Size = UDim2.new(0, 26, 0, 26)
		Outline.Image = "rbxassetid://3570695787"
		Outline.ImageColor3 = Color3.fromRGB(60, 60, 60)
		Outline.ScaleType = Enum.ScaleType.Slice
		Outline.SliceCenter = Rect.new(100, 100, 100, 100)
		Outline.SliceScale = 0.040
		
		Center.Parent = Toggle
		Center.AnchorPoint = Vector2.new(1, 0.5)
		Center.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Center.BackgroundTransparency = 1
		Center.Position = UDim2.new(1, -7, 0.5, 0)
		Center.ZIndex = 2
		Center.Size = UDim2.new(0, 22, 0, 22)
		Center.Image = "rbxassetid://3570695787"
		Center.ImageColor3 = Color3.fromRGB(30, 30, 30)
		Center.ScaleType = Enum.ScaleType.Slice
		Center.SliceCenter = Rect.new(100, 100, 100, 100)
		Center.SliceScale = 0.040
				
		Checkmark.Name = "Checkmark"
		Checkmark.Parent = Toggle
		Checkmark.AnchorPoint = Vector2.new(1, 0.5)
		Checkmark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Checkmark.BackgroundTransparency = 1
		Checkmark.Position = UDim2.new(1, -10, 0.5, 0)
		Checkmark.Size = UDim2.new(0, 16, 0, 16)
		Checkmark.ImageColor3 = Color3.fromRGB(30,30,30)
		Checkmark.Image = "rbxassetid://4919148038"
		
		local Normal = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(60,60,60)})
		local Hovering = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(100,100,100)})
		local ToggledOn1 = TweenService:Create(Outline, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255,75,75)})
		local ToggledOn2 = TweenService:Create(Center, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255,75,75)})
		local ToggledOff1 = TweenService:Create(Outline, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(60,60,60)})
		local ToggledOff2 = TweenService:Create(Center, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(30,30,30)})
		
		Toggle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				Toggled = not Toggled
				if Toggled then
					ToggledOn1:Play()
					ToggledOn2:Play()
					wait(0.15)
					Center:TweenSize(UDim2.new(0,0,0,Center.Size.Y.Offset), nil, nil, 0.1, true)
				else
					Center:TweenSize(UDim2.new(0,Center.Size.Y.Offset,0,Center.Size.Y.Offset), nil, nil, 0.1, true)
					wait(0.15)
					ToggledOff1:Play()
					ToggledOff2:Play()
				end
			end
		end)
		
		Toggle.MouseEnter:Connect(function()
			MouseOver = true
			if not Toggled then
				Hovering:Play()
				Center.Size = UDim2.new(0,Center.Size.Y.Offset,0,Center.Size.Y.Offset)
			end
		end)
		Toggle.MouseLeave:Connect(function()
			MouseOver = false
			if not Toggled then
				Normal:Play()
				Center.Size = UDim2.new(0,Center.Size.Y.Offset,0,Center.Size.Y.Offset)
			end
		end)
	end
	
	function Window:Folder(...)
		local Args = {...}
		local Name = Args[1] or "Folder"
		local Folder = deepcopy(Window)
		Folder.toggled = false
		
		local Title = Instance.new("ImageLabel")
		local Title_2 = Instance.new("TextLabel")
		local Toggle = Instance.new("TextButton")
		local Image = Instance.new("ImageLabel")

		Title.Name = "Title"
		Title.Parent = self.parent
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, 20, 0, 20)
		Title.Size = UDim2.new(1, 0, 0, 30)
		Title.Image = "rbxassetid://3570695787"
		Title.ImageColor3 = Color3.fromRGB(20, 20, 20)
		Title.ScaleType = Enum.ScaleType.Slice
		Title.SliceCenter = Rect.new(100, 100, 100, 100)
		Title.SliceScale = 0.040
		
		Title_2.Name = "Title"
		Title_2.Parent = Title
		Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title_2.BackgroundTransparency = 1
		Title_2.Size = UDim2.new(1, 0, 1, 0)
		Title_2.Font = Enum.Font.Gotham
		Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title_2.TextSize = 18
		Title_2.TextWrapped = true
		
		Toggle.Name = "Toggle"
		Toggle.Parent = Title
		Toggle.AnchorPoint = Vector2.new(1, 0.5)
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1
		Toggle.Position = UDim2.new(1, -5, 0.5, 0)
		Toggle.Size = UDim2.new(0, 25, 0, 25)
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = ""
		Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.TextSize = 14
		
		Image.Name = "Image"
		Image.Parent = Toggle
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Image.BackgroundTransparency = 1
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Rotation = 180
		Image.Size = UDim2.new(0.400000006, 0, 0.400000006, 0)
		Image.Image = "rbxassetid://4918373417"
		Image.ImageColor3 = Color3.fromRGB(80, 80, 80)
		
		local FolderContainer = Instance.new("ImageLabel")
		local UIListLayout = Instance.new("UIListLayout")
		Folder.parent = FolderContainer

		FolderContainer.Name = "FolderContainer"
		FolderContainer.Parent = self.parent
		FolderContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		FolderContainer.BackgroundTransparency = 1
		FolderContainer.Size = UDim2.new(1, 0, 0, 0)
		FolderContainer.Image = "rbxassetid://3570695787"
		FolderContainer.ImageColor3 = Color3.fromRGB(30, 30, 30)
		FolderContainer.ScaleType = Enum.ScaleType.Slice
		FolderContainer.SliceCenter = Rect.new(100, 100, 100, 100)
		FolderContainer.SliceScale = 0.040
		FolderContainer.ClipsDescendants = true
		
		UIListLayout.Parent = FolderContainer
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			if Folder.toggled then
				FolderContainer.Size = UDim2.new(1,0,0, UIListLayout.AbsoluteContentSize.Y)
			end
		end)
		
		local down = TweenService:Create( Image, TweenInfo.new(0.2),{ Rotation = 90 })
		local up = TweenService:Create( Image, TweenInfo.new(0.2),{ Rotation = 180 })
		local colordown = TweenService:Create( Title, TweenInfo.new(0.2),{ ImageColor3 = Color3.fromRGB(25,25,25) })
		local colorup = TweenService:Create( Title, TweenInfo.new(0.2),{ ImageColor3 = Color3.fromRGB(20,20,20) })
		Toggle.MouseButton1Click:Connect(function()
			Folder.toggled = not Folder.toggled
			FolderContainer.ClipsDescendants = true
			FolderContainer:TweenSize((Folder.toggled and UDim2.new(1,0,0, UIListLayout.AbsoluteContentSize.Y) or UDim2.new(1,0,0, 0)), nil, nil, 0.2, true)
			if Folder.toggled then
				colordown:Play()
				down:Play()
			else
				colorup:Play()
				up:Play()
			end
		end)
		
		return Folder
	end
	
	return Window
end
return Library
