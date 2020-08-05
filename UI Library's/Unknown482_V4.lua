local TweenService = game:GetService("TweenService")
local library = {count = 0; toggled = true;}
local ToggleImage = "rbxassetid://538059577"
local Rounded = "rbxassetid://3570695787"

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
GuiObject:TweenPosition(UDim2.new(0,Mouse.X-RelitivePos.X,0,Mouse.Y-RelitivePos.Y),"Out","Quad",0.2,true)
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

local ScreenGui = Instance.new("ScreenGui")
if syn then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Parent = game:GetService("CoreGui") and game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.RightControl then
        library.toggled = not library.toggled
        for i, v in ipairs(ScreenGui:GetChildren()) do
			v:TweenPosition(library.toggled and UDim2.new(0, 20 + ((i - 1) * 190), 0, 20) 
				or UDim2.new(-0.5, 0, -0.5, 0),"InOut","Quad",0.2,true)
        end
    end
end)
function library:CreateWindow(...)
	local Args = {...}
	local Name = Args[1] or "Window"
	local window = {toggled = true; parent = nil; flags = {}; ToggleEvent = {};}
	local Main = Instance.new("ImageLabel")
	local Container = Instance.new("ImageLabel")
	local UIPadding = Instance.new("UIPadding")
	local UIListLayout = Instance.new("UIListLayout")
	local Text = Instance.new("TextLabel")
	local Toggle = Instance.new("TextButton")
	local ImageLabel = Instance.new("ImageLabel")
	
	window.parent = Container
	
	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main.BackgroundTransparency = 1.000
	Main.Size = UDim2.new(0, 180, 0, 28)
	Main.Position = UDim2.new(0, 20 + (library.count * 190), 0, 20)
	Main.ZIndex = 2
	Main.Image = Rounded
	Main.ImageColor3 = Color3.fromRGB(50, 50, 50)
	Main.ScaleType = Enum.ScaleType.Slice
	Main.SliceCenter = Rect.new(100, 100, 100, 200)
	Main.SliceScale = 0.040
	Main.Selectable = true
	
	Container.Name = "Container"
	Container.Parent = Main
	Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Container.BackgroundTransparency = 1.000
	Container.Size = UDim2.new(1, 0, 0, 28)
	Container.Image = Rounded
	Container.ImageColor3 = Color3.fromRGB(65, 65, 65)
	Container.ScaleType = Enum.ScaleType.Slice
	Container.SliceCenter = Rect.new(100, 100, 100, 100)
	Container.SliceScale = 0.040
	
	UIPadding.Parent = Container
	UIPadding.PaddingTop = UDim.new(0, 28)
	
	UIListLayout.Parent = Container
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	Text.Name = "Text"
	Text.Parent = Main
	Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text.BackgroundTransparency = 1.000
	Text.Size = UDim2.new(1, 0, 1, 0)
	Text.ZIndex = 3
	Text.Text = Name
	Text.Font = Enum.Font.SourceSans
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextSize = 18.000
	
	Toggle.Name = "Toggle"
	Toggle.Parent = Main
	Toggle.AnchorPoint = Vector2.new(1, 1)
	Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.BackgroundTransparency = 1.000
	Toggle.BorderColor3 = Color3.fromRGB(27, 42, 53)
	Toggle.Position = UDim2.new(1, 0, 1, 0)
	Toggle.Rotation = 180.000
	Toggle.Selectable = false
	Toggle.Size = UDim2.new(0, 30, 1, 0)
	Toggle.ZIndex = 4
	Toggle.Font = Enum.Font.SourceSans
	Toggle.Text = ""
	Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.TextScaled = true
	Toggle.TextSize = 14.000
	Toggle.TextWrapped = true
	
	ImageLabel.Parent = Toggle
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.ZIndex = 3
	ImageLabel.Image = ToggleImage
	
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function(val)
		Container.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 30)
	end)
	
	local down =
 	    TweenService:Create(
	    Toggle,
	    TweenInfo.new(0.2),
	    {
	    	Rotation = 180
	    }
	)
	local up =
 	    TweenService:Create(
	    Toggle,
	    TweenInfo.new(0.2),
	    {
	    	Rotation = 270
	    }
	)
	Toggle.MouseButton1Click:Connect(function()
		Container.ClipsDescendants = true
		window.toggled = not window.toggled
		for i,v in pairs(window.ToggleEvent) do
			spawn(v, window.toggled)	
		end
		if window.toggled then
			down:Play()
			Container:TweenSize(UDim2.new(1,0,0,UIListLayout.AbsoluteContentSize.Y + 30), "Out", "Quad", 0.2, true)
			Main.SliceCenter = Rect.new(100, 100, 100, 200)
		else
			up:Play()
			Container:TweenSize(UDim2.new(1,0,0,28), "Out", "Quad", 0.2, true, function()
				Main.SliceCenter = Rect.new(100, 100, 100, 100)
			end)
		end
	end)

	Toggle.MouseButton1Click:Connect(function()
		
	end)
	
	function window:Button(...)
		local Args = {...}
		local Name = Args[1] or "Button"
		local Callback = Args[2] or function() end
		local Time = 0.3
		local Button = Instance.new("Frame")
		local Button_2 = Instance.new("TextButton")
		local Background = Instance.new("ImageLabel")

		Button.Name = "Button"
		Button.Parent = self.parent
		Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundTransparency = 1.000
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(1, 0, 0, 30)
		
		Button_2.Name = "Button"
		Button_2.Parent = Button
		Button_2.AnchorPoint = Vector2.new(1, 0.5)
		Button_2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Button_2.BackgroundTransparency = 1.000
		Button_2.BorderSizePixel = 0
		Button_2.Position = UDim2.new(1, -5, 0.5, 0)
		Button_2.Size = UDim2.new(0, 170, 0, 24)
		Button_2.ZIndex = 2
		Button_2.AutoButtonColor = false
		Button_2.Font = Enum.Font.SourceSans
		Button_2.Text = Name
		Button_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button_2.TextSize = 18.000
		Button_2.TextWrapped = true
		
		Background.Name = "Background"
		Background.Parent = Button_2
		Background.Active = true
		Background.AnchorPoint = Vector2.new(0.5, 0.5)
		Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background.BackgroundTransparency = 1.000
		Background.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background.Selectable = true
		Background.Size = UDim2.new(1, 0, 1, 0)
		Background.Image = Rounded
		Background.ImageColor3 = Color3.fromRGB(57, 57, 57)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		Button_2.MouseButton1Click:Connect(function()
			spawn(function()
            	local Circle = Instance.new("ImageLabel")
                Circle.Name = "Circle"
                Circle.Parent = Button_2
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.BackgroundTransparency = 1.000
                Circle.ZIndex = 100
                Circle.Image = "rbxassetid://266543268"
                Circle.ImageTransparency = 0.900
                local Mouse = game.Players.LocalPlayer:GetMouse()
                Button_2.ClipsDescendants = true
                local NewX = Mouse.X - Circle.AbsolutePosition.X
                local NewY = Mouse.Y - Circle.AbsolutePosition.Y
                Circle.Position = UDim2.new(0, NewX, 0, NewY)
                local Size = 0
                if Button_2.AbsoluteSize.X > Button_2.AbsoluteSize.Y then
                    Size = Button_2.AbsoluteSize.X * 1.5
                elseif Button_2.AbsoluteSize.X < Button_2.AbsoluteSize.Y then
                    Size = Button_2.AbsoluteSize.Y * 1.5
                elseif Button_2.AbsoluteSize.X == Button_2.AbsoluteSize.Y then
	            	Size = Button_2.AbsoluteSize.X * 1.5
                    end
                Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size / 2, 0.5, -Size / 2), "Out", "Quad", Time, false, nil)
                for i = 1, 10 do
                    Circle.ImageTransparency = Circle.ImageTransparency + 0.01
                    wait(Time / 10)
                end
                Circle:Destroy()			
			end)
			local Success, Err = pcall(Callback)
			if not Success and error then
				error(Err)
			end
		end)
		
		return {
			Fire = function(self)
				local Success, Err = pcall(Callback)
				if not Success and error then
					error(Err)
				end
			end
		}
	end
	
	function window:Bind(...)
		local Args = {...}
		local Name = Args[1] or "Keybind"
		local Options = Args[2] or {}
		local Default = Options.default or Enum.KeyCode.P
		local AllowMouse = Options.mouse or true
		local Callback = Args[3] or function() end
		local flag = Options.flag or ""
		local Location = Options.location or window.flags
		local Key = Default
		
		if flag ~= "" then
			Location[flag] = Default
		end
		
        local BannedKeys = {
        	Return = true;
            Space = true;
            Tab = true;
            Unknown = true;
        }
		
		local ShortNames = {
            RightControl = 'RCtrl';
            LeftControl = 'LCtrl';
            LeftShift = 'LShift';
            RightShift = 'RShift';
            MouseButton1 = "Mouse1";
			MouseButton2 = "Mouse2";
			Backquote = "`";
			LeftBracket = "[";
			RightBracket = "]";
			BackSlash = "\\";
			Slash = "/";
			Period = ".";
			Semicolon = ";";
			Quote = "\""
		}
		
        local allowed = {
        	MouseButton1 = true;
            MouseButton2 = true;
        }     
		
		local Keybind = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local Button = Instance.new("TextButton")
		local Background = Instance.new("ImageLabel")

		Keybind.Name = "Keybind"
		Keybind.Parent = self.parent
		Keybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Keybind.BackgroundTransparency = 1.000
		Keybind.BorderSizePixel = 0
		Keybind.Size = UDim2.new(1, 0, 0, 30)
		
		TextLabel.Parent = Keybind
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0, 5, 0, 0)
		TextLabel.Size = UDim2.new(1, -35, 1, 0)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = Name
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 18.000
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		Button.Name = "Button"
		Button.Parent = Keybind
		Button.AnchorPoint = Vector2.new(1, 0.5)
		Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		Button.BackgroundTransparency = 1.000
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(1, -5, 0.5, 0)
		Button.Size = UDim2.new(0, 50, 0, 24)
		Button.AutoButtonColor = false
		Button.TextColor3 = Color3.new(255,255,255)
		Button.Font = Enum.Font.SourceSans
		Button.Text = Key.Name 
		Button.TextSize = 16.000
		Button.ZIndex = 2
		
		Background.Name = "Background"
		Background.Parent = Button
		Background.Active = true
		Background.AnchorPoint = Vector2.new(0.5, 0.5)
		Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background.BackgroundTransparency = 1.000
		Background.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background.Selectable = true
		Background.Size = UDim2.new(1, 0, 1, 0)
		Background.Image = "rbxassetid://3570695787"
		Background.ImageColor3 = Color3.fromRGB(80, 80, 80)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		game:GetService('UserInputService').InputBegan:Connect(function(input, stuff)
			if Key == input.UserInputType or Key == input.KeyCode and not stuff then
				local Success, Err = pcall(Callback, Key)
			end
		end)		
		
		Button.MouseButton1Click:Connect(function()
			Button.Text = "..."
			local input, othershit = game:GetService('UserInputService').InputBegan:wait();
            if input.UserInputType ~= Enum.UserInputType.Keyboard and (allowed[input.UserInputType.Name] and AllowMouse) or (input.KeyCode and (not BannedKeys[input.KeyCode.Name])) then
                local name = (input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType.Name or input.KeyCode.Name)
				Button.Text = ShortNames[name] or name
				wait(0.1)
				Key = input.UserInputType ~= Enum.UserInputType.Keyboard and input.UserInputType or input.KeyCode
				if flag ~= "" then
					Location[flag] = Key
				end
			end
		end)
		
		return {
			Set = function(self, val)
				Button.Text = ShortNames[val.Name] or val.Name
				Key = val
				if flag ~= "" then
					Location[flag] = Key
				end
			end;
			ChangeCallback = function(self, val)
				Callback = val
			end
		}
	end
	
	function window:Box(...)
		Args = {...}
		local Name = Args[1] or "TextBox"
		local Options = Args[2] or {}
		local Type = Options.type or "string"
		Type = string.lower(Type)
		local Min = Options.min or 0
		local Max = Options.max or 9e9
		local flag = Options.flag or ""
		local Location = Options.location or window.flags
		local Callback = Args[3] or function() end
		local Placeholder = Options.placeholder or ""
		local Default = Options.default or (Type == "number" and 0 or "")
		if flag ~= "" then
			Location[flag] = Default
		end
		
		local Box = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local TextBox = Instance.new("TextBox")
		local Background = Instance.new("ImageLabel")

		Box.Name = "Box"
		Box.Parent = self.parent
		Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Box.BackgroundTransparency = 1.000
		Box.BorderSizePixel = 0
		Box.Size = UDim2.new(1, 0, 0, 30)
		
		TextLabel.Parent = Box
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0, 5, 0, 0)
		TextLabel.Size = UDim2.new(1, -65, 1, 0)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = Name
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 18.000
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		TextBox.Parent = Box
		TextBox.AnchorPoint = Vector2.new(1, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.Position = UDim2.new(1, -5, 0.5, 0)
		TextBox.Size = UDim2.new(0, 65, 0, 24)
		TextBox.Font = Enum.Font.SourceSans
		TextBox.Text = (string.lower(Type) == "number" and (tonumber(Default) and tostring(Default) or tostring(Min)) or Default)
		TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.TextSize = 14.000
		TextBox.ZIndex = 2
		TextBox.TextColor3 = Color3.fromRGB(255,255,255)
		TextBox.TextSize = 16
		TextBox.ClipsDescendants = false
		TextBox.PlaceholderText = Placeholder
		
		Background.Name = "Background"
		Background.Parent = TextBox
		Background.Active = true
		Background.AnchorPoint = Vector2.new(0.5, 0.5)
		Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background.BackgroundTransparency = 1.000
		Background.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background.Selectable = true
		Background.Size = UDim2.new(1, 0, 1, 0)
		Background.Image = "rbxassetid://3570695787"
		Background.ImageColor3 = Color3.fromRGB(80, 80, 80)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		local old = Default
		
        function PositiveIntegerMask(text)
            return text:gsub("[^%-%d]", "")
        end
        TextBox:GetPropertyChangedSignal("Text"):Connect(function()
            if Type == "number" then
                TextBox.Text = PositiveIntegerMask(TextBox.Text)
            end
		end)
		
		TextBox.FocusLost:Connect(function(EnterPressed)
			if Type == "number" then
				TextBox.Text = math.clamp(tonumber(TextBox.Text), Min, Max)
				if flag ~= "" then
					Location[flag] = tonumber(TextBox.Text)
				end
				local Success, Err = pcall(Callback, tonumber(TextBox.Text), tonumber(old), EnterPressed, TextBox)
			else
				if flag ~= "" then
					Location[flag] = TextBox.Text
				end
				local Success, Err = pcall(Callback, TextBox.Text, old, EnterPressed, TextBox)
			end
			old = TextBox.Text
		end)
		
		return {
			Set = function(self, val)
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
			ChangeCallback = function(self, val)
				Callback = val
			end
		}
	end
	
	function window:Slider(...)
		local Args = {...}
		local Name = Args[1] or "Slider"
		local Callback = Args[3] or function()end
		local flag = Args[2].flag or ""
		local Min = Args[2].min or 0
		local Max = Args[2].max or 100
		local Default = Args[2].default or 50
		local step = Args[2].step or 1
		local Location = Args[2].location and Args[2].location or window.flags
		
        if flag ~= "" then
            Location[flag] = Default
		end
		local Slider = Instance.new("Frame")
		local Background = Instance.new("ImageLabel")
		local Fill = Instance.new("ImageLabel")
		local Handle = Instance.new("ImageButton")
		local Title = Instance.new("TextLabel")
		local Amount = Instance.new("TextBox")
		local Image = Instance.new("ImageLabel")

		Slider.Name = "Slider"
		Slider.Parent = self.parent
		Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Slider.BackgroundTransparency = 1.000
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new(1, 0, 0, 30)
		
		Background.Name = "Background"
		Background.Parent = Slider
		Background.AnchorPoint = Vector2.new(0.5, 0.5)
		Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background.BackgroundTransparency = 1.000
		Background.Position = UDim2.new(0.5, 0, 1, -6)
		Background.Size = UDim2.new(1, -23, 0, 5)
		Background.Image = Rounded
		Background.ImageColor3 = Color3.fromRGB(57, 57, 57)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		Fill.Name = "Fill"
		Fill.Parent = Background
		Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Fill.BackgroundTransparency = 1.000
		Fill.Size = UDim2.new((1 - ((Max - Default) / (Max - Min))), 0, 1, 0)
		Fill.Image = Rounded
		Fill.ImageColor3 = Color3.fromRGB(120, 120, 120)
		Fill.ScaleType = Enum.ScaleType.Slice
		Fill.SliceCenter = Rect.new(100, 100, 100, 100)
		Fill.SliceScale = 0.040
		
		Handle.Name = "Handle"
		Handle.Parent = Fill
		Handle.Active = false
		Handle.AnchorPoint = Vector2.new(0.5, 0.5)
		Handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Handle.BackgroundTransparency = 1.000
		Handle.Position = UDim2.new(1, 0, 0.5, 0)
		Handle.Selectable = false
		Handle.Size = UDim2.new(0, 10, 0, 10)
		Handle.Image = Rounded
		Handle.SliceCenter = Rect.new(100, 100, 100, 100)
		Handle.SliceScale = 0.000
		
		Title.Name = "Title"
		Title.Parent = Slider
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Title.Position = UDim2.new(0, 7, 0, 3)
		Title.Size = UDim2.new(0, 112, 0, 17)
		Title.Font = Enum.Font.SourceSans
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 16.000
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.Text = Name
		
		Amount.Name = "Amount"
		Amount.Parent = Slider
		Amount.AnchorPoint = Vector2.new(1,0)
		Amount.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		Amount.BackgroundTransparency = 1.000
		Amount.BorderSizePixel = 0
		Amount.Position = UDim2.new(1, -5, 0, 2)
		Amount.Size = UDim2.new(0, 38, 0, 15)
		Amount.ZIndex = 2
		Amount.Font = Enum.Font.SourceSans
		Amount.Text = tostring(Default)
		Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
		Amount.TextSize = 14.000
		Amount.TextScaled = true
		
		Image.Name = "Image"
		Image.Parent = Amount
		Image.Active = true
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Image.BackgroundTransparency = 1.000
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Selectable = true
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.Image = Rounded
		Image.ImageColor3 = Color3.fromRGB(80, 80, 80)
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		local Dragging = false
		local old = tonumber(Amount.Text)
        local function Snap(num, snap)
            if snap == 0 then
                return num
            else
                return math.floor(num / snap + 0.5) * snap
            end
        end
        local function GetDecimalPlacesCount(num)
            num = tostring(num)
            if string.match(num, ".") then
                local dec = string.split(num, ".")
                return #tostring(tonumber(dec[2]))
            else
                return 0
            end
        end
        Handle.MouseButton1Down:Connect(
            function()
                Dragging = true
            end
        )
        Background.InputBegan:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    coroutine.resume(
                        coroutine.create(
                            function()
                                Dragging = true
                                local Mouse = game.Players.LocalPlayer:GetMouse()
                                local Relpos = Vector2.new(Mouse.x, Mouse.y) - Fill.AbsolutePosition
                                local precentage = Relpos.x / Background.AbsoluteSize.x
 
                                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (Max - Min)), 0, 1, 0)
                                if step >= 1 then
                                    Amount.Text =
                                        string.format(
                                        "%.0f",
                                        math.floor((Fill.AbsoluteSize.x / Background.AbsoluteSize.x) * (Max - Min) + Min)
                                    )
                                else
                                    local deccount = GetDecimalPlacesCount(step)
                                    local decsize = (step >= 1 and 10 or 100)
                                    Amount.Text =
                                        string.format(
                                        "%." .. (decsize == 10 and "1" or "2") .. "f",
                                        math.floor(
                                            ((Fill.AbsoluteSize.x / Background.AbsoluteSize.x) * (Max - Min) + Min) *
                                                (decsize / (step * decsize))
                                        ) /
                                            (decsize / (step * decsize))
                                    )
								 end
						         if flag ~= "" then
					                 Location[flag] = tonumber(Amount.Text)
					             end
								local Success, Err = pcall(Callback, tonumber(Amount.Text))
								if not Success and error then
									error(Err)
								end
								old = tonumber(Amount.Text)
                            end
                        )
                    )
                end
            end
        )
        game:GetService("UserInputService").InputEnded:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                end
            end
        )
        game:GetService("UserInputService").InputChanged:Connect(
            function(input, gameProcessed)
                if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
                    spawn(function()
                                local Mouse = game.Players.LocalPlayer:GetMouse()
                                local Relpos = Vector2.new(Mouse.x, Mouse.y) - Fill.AbsolutePosition
                                local precentage = Relpos.x / Background.AbsoluteSize.x
                                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (Max - Min)), 0, 1, 0)
                                if step >= 1 then
                                    Amount.Text =
                                        string.format(
                                        "%.0f",
                                        math.floor((Fill.AbsoluteSize.x / Background.AbsoluteSize.x) * (Max - Min) + Min)
						                                    )
						            if flag ~= "" then
					                    Location[flag] = tonumber(Amount.Text)
					                end
						            local Success, Err = pcall(Callback, tonumber(Amount.Text))
									if not Success and error then
										error(Err)
									end
                                else
                                    local deccount = GetDecimalPlacesCount(step)
                                    local decsize = (step >= 1 and 10 or 100)
                                    Amount.Text =
                                        string.format(
                                        "%." .. (decsize == 10 and "1" or "2") .. "f",
                                        math.floor(
                                            ((Fill.AbsoluteSize.x / Background.AbsoluteSize.x) * (Max - Min) + Min) *
                                                (decsize / (step * decsize))
                                        ) /
                                            (decsize / (step * decsize))
						                                    )
					             end
						         if flag ~= "" then
					                 Location[flag] = tonumber(Amount.Text)
					             end
						        local Success, Err = pcall(Callback, tonumber(Amount.Text))
								if not Success and error then
									error(Err)
								end
								old = tonumber(Amount.Text)
                            end
                        )
                end
            end
        )
        game:GetService("UserInputService").WindowFocusReleased:Connect(function()
            Dragging = false
        end)
		
        function PositiveIntegerMask(text)
            return text:gsub("[^%-%d]", "")
        end
        Amount:GetPropertyChangedSignal("Text"):Connect(function()
            if (type == "number") then
                Amount.Text = PositiveIntegerMask(Amount.Text)
            end
        end)
		
		Amount.FocusLost:Connect(function()
			if tonumber(Amount.Text) then
				Amount.Text = math.clamp(tonumber(Amount.Text), Min, Max)
			else
				Amount.Text = tostring(old)
			end
			Fill.Size = UDim2.new((1 - ((Max - tonumber(Amount.Text)) / (Max - Min))), 0, 1, 0)
	        if flag ~= "" then
	            Location[flag] = tonumber(Amount.Text)
	        end
			local Success, Err = pcall(Callback, tonumber(Amount.Text))
			if not Success and error then
				error(Err)
			end
			old = tonumber(Amount.Text)
        end)
        return {
            Set = function(self, value)
                if step >= 1 then
                    value = math.floor(value)
                else
                    value = math.floor(value * 100) / 100
                end
                if step >= 1 then
                    Amount.Text = string.format("%.0f", value)
                else
                    local deccount = GetDecimalPlacesCount(step)
                    local decsize = (step >= 1 and 10 or 100)
                    Amount.Text = string.format("%." .. (decsize == 10 and "1" or "2") .. "f", value)
                end
                value = math.clamp(value, Min, Max)
                local precentage = value < Min and 0 or value > Max and 1 or (1 - ((Max - value) / (Max - Min)))
                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (Max - Min)), 0, 1, 0)
                if flag ~= "" then
                    Location[flag] = tonumber(value)
                end
			end;
			ChangeCallback = function(self, val)
				Callback = val
			end
        }
	end
	
	function window:Dropdown(...)
		local args = {...}
		local Name = args[1] or "DropDown"
		local Callback = args[3] or function()end
        local List = args[2].list or {}
        local old = ""
		local Toggled = false
		local Location = args[2].location and args[2].location or window.flags
		local flag = args[2].flag or ""
        if flag ~= "" then
            Location[flag] = tostring(List[1])
		end
		
		local Dropdown = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local Background = Instance.new("ImageLabel")
		local Toggle = Instance.new("TextButton")
		local ImageLabel = Instance.new("ImageLabel")
		
		Dropdown.Name = "Dropdown"
		Dropdown.Parent = self.parent
		Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Dropdown.BackgroundTransparency = 1.000
		Dropdown.BorderSizePixel = 0
		Dropdown.Size = UDim2.new(1, 0, 0, 30)
		
		TextLabel.Parent = Dropdown
		TextLabel.Active = true
		TextLabel.AnchorPoint = Vector2.new(1, 0.5)
		TextLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(1, -5, 0.5, 0)
		TextLabel.Selectable = true
		TextLabel.Size = UDim2.new(0, 170, 0, 24)
		TextLabel.ZIndex = 4
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = tostring(List[1])
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 18.000
		TextLabel.TextWrapped = true
		
		Background.Name = "Background"
		Background.Parent = TextLabel
		Background.Active = true
		Background.AnchorPoint = Vector2.new(0.5, 0.5)
		Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background.BackgroundTransparency = 1.000
		Background.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background.Selectable = true
		Background.Size = UDim2.new(1, 0, 1, 0)
		Background.ZIndex = 3
		Background.Image = Rounded
		Background.ImageColor3 = Color3.fromRGB(57, 57, 57)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		Toggle.Name = "Toggle"
		Toggle.Parent = TextLabel
		Toggle.AnchorPoint = Vector2.new(1, 1)
		Toggle.BackgroundTransparency = 1.000
		Toggle.Position = UDim2.new(1, 0, 1, 0)
		Toggle.Rotation = 270
		Toggle.Selectable = false
		Toggle.Size = UDim2.new(0, 24, 1, 0)
		Toggle.ZIndex = 4
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = ""
		Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.TextScaled = true
		Toggle.TextSize = 14.000
		Toggle.TextWrapped = true
		
		ImageLabel.Parent = Toggle
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel.ZIndex = 3
		ImageLabel.Image = ToggleImage
		
        old = TextLabel.Text

        local down = TweenService:Create(Toggle,TweenInfo.new(0.2),{Rotation = 180})
        local up = TweenService:Create(Toggle,TweenInfo.new(0.2),{Rotation = 270})
		
		local function CreateDropDown(Array)
			self.parent.ClipsDescendants = false
			Container.ClipsDescendants = false
			local Dropdown1 = Instance.new("ImageLabel")
			
			Dropdown1.Name = "Dropdown"
 			Dropdown1.Parent = TextLabel
			Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
			Dropdown1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown1.BackgroundTransparency = 1.000
			Dropdown1.Position = UDim2.new(0.5, 0, 0, 0)
			Dropdown1.Size = UDim2.new(1, 0, 0, 0)
			Dropdown1.Image = Rounded
			Dropdown1.ImageColor3 = Color3.fromRGB(70, 70, 70)
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
				UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
				UIGridLayout.CellSize = UDim2.new(1, 0, 0, 24)
				
				UIPadding.Parent = Dropdown1
				UIPadding.PaddingTop = UDim.new(0, 25)
				
				TextLabel.Text = Name
				TextLabel.TextColor3 = Color3.fromRGB(120,120,120)
				
				for	i,v in pairs(Array) do
					local TextButton = Instance.new("TextButton")
					local Image = Instance.new("ImageLabel")
					
					TextButton.Parent = Dropdown1
					TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
					TextButton.BackgroundTransparency = 1.000
					TextButton.BorderSizePixel = 0
					TextButton.Size = UDim2.new(0, 200, 0, 50)
					TextButton.ZIndex = 2
					TextButton.Text = tostring(v)
					TextButton.Font = Enum.Font.SourceSans
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.TextSize = 18.000
					TextButton.ZIndex = 7
					
					Image.Name = "Image"
					Image.Parent = TextButton
					Image.Active = true
					Image.AnchorPoint = Vector2.new(0.5, 0.5)
					Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Image.BackgroundTransparency = 1.000
					Image.Position = UDim2.new(0.5, 0, 0.5, 0)
					Image.Selectable = true
					Image.Size = UDim2.new(1, 0, 1, 0)
					Image.Image = Rounded
					Image.ImageColor3 = Color3.fromRGB(60, 60, 60)
					Image.ScaleType = Enum.ScaleType.Slice
					Image.SliceCenter = Rect.new(100, 100, 100, 100)
					Image.SliceScale = i == #Array and 0.040 or 0.01
					Image.ZIndex = 6
					
					TextButton.MouseButton1Click:Connect(function()
						TextLabel.Text = TextButton.Text
						old = TextButton.Text
						Toggled = false
						up:Play()
						Background.SliceCenter = Rect.new(100, 100, 100, 100)
				        if flag ~= "" then
				            Location[flag] = TextButton.Text
						end
						TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
						Dropdown1:TweenSize(UDim2.new(1,0,0,0),nil,nil,0.2,true,function()
							Background.ZIndex = 3
							Toggle.ZIndex = 4
							ImageLabel.ZIndex = 4
							TextLabel.ZIndex = 4
							Dropdown1:Destroy()
						end)
						local Success, Err = pcall(Callback, TextButton.Text)
						if not Success and error then
							error(Err)
						end
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
				ScrollingFrame.BackgroundTransparency = 1.000
				ScrollingFrame.BorderSizePixel = 0
				ScrollingFrame.Position = UDim2.new(0, 0, 0, 25)
				ScrollingFrame.Size = UDim2.new(1, 0, 1, -25)
				ScrollingFrame.ZIndex = 5
				ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
				ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
				ScrollingFrame.ScrollBarThickness = 5
				
				UIGridLayout.Parent = ScrollingFrame
				UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
				UIGridLayout.CellSize = UDim2.new(1, 0, 0, 24)
				
				TextLabel.Text = Name
				TextLabel.TextColor3 = Color3.fromRGB(120,120,120)
				
				for	i,v in pairs(Array) do
					local TextButton = Instance.new("TextButton")
					local Image = Instance.new("ImageLabel")
					
					TextButton.Parent = ScrollingFrame
					TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
					TextButton.BackgroundTransparency = 1.000
					TextButton.BorderSizePixel = 0
					TextButton.Size = UDim2.new(0, 200, 0, 50)
					TextButton.ZIndex = 2
					TextButton.Text = tostring(v)
					TextButton.Font = Enum.Font.SourceSans
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.TextSize = 18.000
					TextButton.ZIndex = 7
					
					Image.Name = "Image"
					Image.Parent = TextButton
					Image.Active = true
					Image.AnchorPoint = Vector2.new(0.5, 0.5)
					Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Image.BackgroundTransparency = 1.000
					Image.Position = UDim2.new(0.5, 0, 0.5, 0)
					Image.Selectable = true
					Image.Size = UDim2.new(1, 0, 1, 0)
					Image.Image = Rounded
					Image.ImageColor3 = Color3.fromRGB(60, 60, 60)
					Image.ScaleType = Enum.ScaleType.Slice
					Image.SliceCenter = Rect.new(100, 100, 100, 100)
					Image.SliceScale = i == #Array and 0.040 or 0.01
					Image.ZIndex = 6
					
					TextButton.MouseButton1Click:Connect(function()
						TextLabel.Text = TextButton.Text
						old = TextButton.Text
						Toggled = false
						up:Play()
						Background.SliceCenter = Rect.new(100, 100, 100, 100)
				        if flag ~= "" then
				            Location[flag] = TextButton.Text
						end
						TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
						Dropdown1:TweenSize(UDim2.new(1,0,0,0),nil,nil,0.2,true,function()
							Background.ZIndex = 3
							Toggle.ZIndex = 4
							ImageLabel.ZIndex = 4
							TextLabel.ZIndex = 4
							Dropdown1:Destroy()
						end)
						local Success, Err = pcall(Callback, TextButton.Text)
						if not Success and error then
							error(Err)
						end
					end)
				end
				Dropdown1:TweenSize(UDim2.new(1,0,0,149),nil,nil,0.2,true)
				ScrollingFrame.CanvasSize = UDim2.new(1,0,0,UIGridLayout.AbsoluteContentSize.Y)
			end
		end
		
		local function CloseDropdown()
            if TextLabel:FindFirstChild("Dropdown") then
				up:Play()
				Background.SliceCenter = Rect.new(100, 100, 100, 100)
                Toggled = false
				TextLabel.Text = old
				TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
				TextLabel:FindFirstChild("Dropdown"):TweenSize( UDim2.new(0, 173, 0, 0), "Out", "Quad", 0.2, true, function()
					Background.ZIndex = 3
					Toggle.ZIndex = 4
					ImageLabel.ZIndex = 4
					TextLabel.ZIndex = 4
                    TextLabel:FindFirstChild("Dropdown"):Destroy()
   	        	end)
        	end
        end
		
		game:GetService("UserInputService").WindowFocusReleased:Connect(CloseDropdown)
		
		Toggle.MouseButton1Click:Connect(function()
			Toggled = not Toggled
			if Toggled then 
				Background.ZIndex = 8
				Toggle.ZIndex = 9
				ImageLabel.ZIndex = 9
				TextLabel.ZIndex = 9
				Background.SliceCenter = Rect.new(100, 100, 100, 200)
				down:Play()
				CreateDropDown(List)
			else
				up:Play()
				TextLabel.Text = old
				Background.SliceCenter = Rect.new(100, 100, 100, 100)
				for i,v in pairs(TextLabel:GetChildren()) do
					if v.Name == "Dropdown" then
						TextLabel.Text = old
						TextLabel.TextColor3 = Color3.fromRGB(255,255,255)
						v:TweenSize(UDim2.new(1,0,0,0),nil,nil,0.2,true,function()
							Background.ZIndex = 3
							Toggle.ZIndex = 4
							ImageLabel.ZIndex = 4
							TextLabel.ZIndex = 4
							v:Destroy()
						end)
					end
				end
			end
		end)
		
		return {
			Refresh = function(self, val)
				CloseDropdown()
				TextLabel.Text = val[1]
				old = val[1]
				List = val
			end;
			ChangeCallback = function(self, val)
				Callback = val
			end
		}
    end
	
	function window:Colorpicker(...)
		local Args = {...}
		local Name = Args[1] or "ColorPicker"
		local Options = Args[2] or {}
		local Default = Options.default or Color3.fromHSV(0,1,1)
		local Callback = Args[3] or function() end
		local Toggled = false
		local HueDragging, SaterationDragging, BrightnessDragging = false, false, false
		local Color = Default
		local Location = Args[2].location and Args[2].location or window.flags
		local flag = Args[2].flag or ""
        if flag ~= "" then
            Location[flag] = Color
		end
		
		local H, S, V = Color3.toHSV(Color)
		local ColorPicker = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local Button = Instance.new("TextButton")
		local ColorBackground = Instance.new("ImageLabel")
		local Toggle = Instance.new("ImageLabel")

		ColorPicker.Name = "ColorPicker"
		ColorPicker.Parent = self.parent
		ColorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ColorPicker.BackgroundTransparency = 1.000
		ColorPicker.BorderSizePixel = 0
		ColorPicker.Position = UDim2.new(0, 0, 0.618618608, 0)
		ColorPicker.Selectable = true
		ColorPicker.Size = UDim2.new(1, 0, 0, 30)
		
		TextLabel.Parent = ColorPicker
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0, 5, 0, 0)
		TextLabel.Size = UDim2.new(1, -35, 0, 30)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = "Color Picker"
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 18.000
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		Button.Name = "Button"
		Button.Parent = ColorPicker
		Button.AnchorPoint = Vector2.new(1, 0)
		Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		Button.BackgroundTransparency = 1.000
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(1, -5, 0, 3)
		Button.Size = UDim2.new(0, 24, 0, 24)
		Button.AutoButtonColor = false
		Button.Font = Enum.Font.SourceSans
		Button.Text = ""
		Button.TextColor3 = Color3.fromRGB(0, 0, 0)
		Button.TextSize = 14.000
		
		ColorBackground.Name = "Background"
		ColorBackground.Parent = Button
		ColorBackground.Active = true
		ColorBackground.AnchorPoint = Vector2.new(0.5, 0.5)
		ColorBackground.BackgroundTransparency = 1.000
		ColorBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
		ColorBackground.Selectable = true
		ColorBackground.Size = UDim2.new(1, 0, 1, 0)
		ColorBackground.Image = Rounded
		ColorBackground.ImageColor3 = Color
		ColorBackground.ScaleType = Enum.ScaleType.Slice
		ColorBackground.SliceCenter = Rect.new(100, 100, 100, 100)
		ColorBackground.SliceScale = 0.040
		
		Toggle.Name = "Toggle"
		Toggle.Parent = Button
		Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1.000
		Toggle.Position = UDim2.new(0.5, 0, 0.5, 0)
		Toggle.Size = UDim2.new(0.800000012, 0, 0.800000012, 0)
		Toggle.Visible = false
		Toggle.Image = "rbxassetid://5424726217"

		local ColorDropDown = Instance.new("Frame")
		local Background = Instance.new("ImageLabel")
		local Sateration = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")
		local SaterationDragger = Instance.new("TextButton")
		local ImageLabel = Instance.new("ImageLabel")
		local Hue = Instance.new("Frame")
		local HueDragger = Instance.new("TextButton")
		local ImageLabel_2 = Instance.new("ImageLabel")
		local Brightness = Instance.new("Frame")
		local UIGradient_2 = Instance.new("UIGradient")
		local UIGradient_3 = Instance.new("UIGradient")
		local BrightnessDragger = Instance.new("TextButton")
		local ImageLabel_3 = Instance.new("ImageLabel")
		local UICornerHue = Instance.new("UICorner")
		local UICornerBrightness = Instance.new("UICorner")
		local UICornerSateration = Instance.new("UICorner")

		ColorDropDown.Name = "ColorDropDown"
		ColorDropDown.Parent = self.parent
		ColorDropDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ColorDropDown.BackgroundTransparency = 1.000
		ColorDropDown.BorderSizePixel = 0
		ColorDropDown.ClipsDescendants = true
		ColorDropDown.Position = UDim2.new(0, 0, 0.618618608, 0)
		ColorDropDown.Selectable = true
		ColorDropDown.Size = UDim2.new(1, 0, 0, 0)
		
		Background.Name = "Background"
		Background.Parent = ColorDropDown
		Background.AnchorPoint = Vector2.new(0.5, 0)
		Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background.BackgroundTransparency = 1.000
		Background.Position = UDim2.new(0.5, 0, 0, 0)
		Background.Selectable = true
		Background.Size = UDim2.new(1, -10, 0, 70)
		Background.Image = Rounded
		Background.ImageColor3 = Color3.fromRGB(57, 57, 57)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		Sateration.Name = "Sateration"
		Sateration.Parent = Background
		Sateration.Active = true
		Sateration.AnchorPoint = Vector2.new(0.5, 0)
		Sateration.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Sateration.BorderSizePixel = 0
		Sateration.Position = UDim2.new(0.5, 0, 0, 30)
		Sateration.Size = UDim2.new(1, -16, 0, 10)
		
		UIGradient.Color = ColorSequence.new(Color, Color3.fromRGB(255, 255, 255))
		UIGradient.Parent = Sateration
		
		SaterationDragger.Name = "Dragger"
		SaterationDragger.Parent = Sateration
		SaterationDragger.AnchorPoint = Vector2.new(0.5, 0.5)
		SaterationDragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SaterationDragger.BackgroundTransparency = 1.000
		SaterationDragger.Position = UDim2.new((S -1) * -1, 0, 0.275000006, 0)
		SaterationDragger.Size = UDim2.new(0, 14, 0, 14)
		SaterationDragger.Font = Enum.Font.SourceSans
		SaterationDragger.Text = ""
		SaterationDragger.TextColor3 = Color3.fromRGB(0, 0, 0)
		SaterationDragger.TextSize = 14.000
		
		ImageLabel.Parent = SaterationDragger
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.Rotation = 180.000
		ImageLabel.Size = UDim2.new(1, 0, 1, -4)
		ImageLabel.Image = "rbxassetid://4292970642"
		
		Hue.Name = "Hue"
		Hue.Parent = Background
		Hue.Active = true
		Hue.AnchorPoint = Vector2.new(0.5, 0)
		Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Hue.BorderSizePixel = 0
		Hue.Position = UDim2.new(0.5, 0, 0, 10)
		Hue.Size = UDim2.new(1, -16, 0, 10)
		
		UIGradient_3.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), 
			ColorSequenceKeypoint.new(0.15, Color3.fromRGB(255, 255, 0)), 
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), 
			ColorSequenceKeypoint.new(0.49, Color3.fromRGB(0, 255, 255)), 
			ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)), 
			ColorSequenceKeypoint.new(0.84, Color3.fromRGB(255, 0, 255)), 
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
		}
		UIGradient_3.Parent = Hue
		
		HueDragger.Name = "Dragger"
		HueDragger.Parent = Hue
		HueDragger.AnchorPoint = Vector2.new(0.5, 0.5)
		HueDragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		HueDragger.BackgroundTransparency = 1.000
		HueDragger.Position = UDim2.new(H, 0, 0.275000006, 0)
		HueDragger.Size = UDim2.new(0, 14, 0, 14)
		HueDragger.Font = Enum.Font.SourceSans
		HueDragger.Text = ""
		HueDragger.TextColor3 = Color3.fromRGB(0, 0, 0)
		HueDragger.TextSize = 14.000
		
		ImageLabel_2.Parent = HueDragger
		ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel_2.BackgroundTransparency = 1.000
		ImageLabel_2.Rotation = 180.000
		ImageLabel_2.Size = UDim2.new(1, 0, 1, -4)
		ImageLabel_2.Image = "rbxassetid://4292970642"
		
		Brightness.Name = "Brightness"
		Brightness.Parent = Background
		Brightness.Active = true
		Brightness.AnchorPoint = Vector2.new(0.5, 0)
		Brightness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Brightness.BorderSizePixel = 0
		Brightness.Position = UDim2.new(0.5, 0, 0, 50)
		Brightness.Size = UDim2.new(1, -16, 0, 10)
		
		UIGradient_2.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0))
		UIGradient_2.Parent = Brightness
		
		BrightnessDragger.Name = "Dragger"
		BrightnessDragger.Parent = Brightness
		BrightnessDragger.AnchorPoint = Vector2.new(0.5, 0.5)
		BrightnessDragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BrightnessDragger.BackgroundTransparency = 1.000
		BrightnessDragger.Position = UDim2.new((V - 1) * -1, 0, 0.27, 0)
		BrightnessDragger.Size = UDim2.new(0, 14, 0, 14)
		BrightnessDragger.Font = Enum.Font.SourceSans
		BrightnessDragger.Text = ""
		BrightnessDragger.TextColor3 = Color3.fromRGB(0, 0, 0)
		BrightnessDragger.TextSize = 14.000
		
		ImageLabel_3.Parent = BrightnessDragger
		ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel_3.BackgroundTransparency = 1.000
		ImageLabel_3.Rotation = 180.000
		ImageLabel_3.Size = UDim2.new(1, 0, 1, -4)
		ImageLabel_3.Image = "rbxassetid://4292970642"
		
		UICornerHue.CornerRadius = UDim.new(0,4)
		UICornerHue.Parent = Hue
		
		UICornerBrightness.CornerRadius = UDim.new(0,4)
		UICornerBrightness.Parent = Brightness
		
		UICornerSateration.CornerRadius = UDim.new(0,4)
		UICornerSateration.Parent = Sateration
		
		Button.MouseButton1Click:Connect(function()
			Toggled = not Toggled
			ColorDropDown:TweenSize(UDim2.new(1,0,0,(Toggled and 75 or 0)),nil,nil,0.2,true)
		end)
		
		SaterationDragger.MouseButton1Down:Connect(function()
			SaterationDragging = true
		end)
		
		BrightnessDragger.MouseButton1Down:Connect(function()
			BrightnessDragging = true
		end)
		
		HueDragger.MouseButton1Down:Connect(function()
			HueDragging = true
		end)
		
		Hue.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
				HueDragging = true
				local Mouse = game.Players.LocalPlayer:GetMouse()
                local Relpos = Vector2.new(Mouse.x, Mouse.y) - Hue.AbsolutePosition
				local H = Relpos.x / Hue.AbsoluteSize.x
				local S = (SaterationDragger.Position.X.Scale - 1) * -1
				local V = (BrightnessDragger.Position.X.Scale - 1) * -1
				HueDragger.Position = UDim2.new(math.clamp(H, 0, 1), 0, 0.27, 0)
				Color = Color3.fromHSV(math.clamp(H, 0, 1), math.clamp(S, 0, 1), math.clamp(V, 0, 1))
				ColorBackground.ImageColor3 = Color
				UIGradient.Color = ColorSequence.new(Color3.fromHSV(math.clamp(H, 0, 1),1,1), Color3.fromRGB(255, 255, 255))
				if flag ~= "" then
			    	Location[flag] = Color
				end
				local Success, Err = pcall(Callback, Color)
				if not Success and error then
					error(Err)
				end
			end
		end)
		
		Sateration.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
				SaterationDragging = true
				local Mouse = game.Players.LocalPlayer:GetMouse()
				local Relpos = Vector2.new(Mouse.x, Mouse.y) - Sateration.AbsolutePosition
				local Precentage = Relpos.x / Sateration.AbsoluteSize.x
				local H = HueDragger.Position.X.Scale
				local S = (Precentage - 1) * -1
				local V = (BrightnessDragger.Position.X.Scale - 1) * -1
				SaterationDragger.Position = UDim2.new(math.clamp(Precentage, 0, 1), 0, 0.27, 0)
				Color = Color3.fromHSV(math.clamp(H, 0, 1), math.clamp(S, 0, 1), math.clamp(V, 0, 1))
				ColorBackground.ImageColor3 = Color
			    if flag ~= "" then
			        Location[flag] = Color
				end
				local Success, Err = pcall(Callback, Color)
				if not Success and error then
					error(Err)
				end
			end
		end)
		
		Brightness.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
				BrightnessDragging = true
				local Mouse = game.Players.LocalPlayer:GetMouse()
				local Relpos = Vector2.new(Mouse.x, Mouse.y) - Sateration.AbsolutePosition
				local Precentage = Relpos.x / Sateration.AbsoluteSize.x
				local H = HueDragger.Position.X.Scale
				local S = (SaterationDragger.Position.X.Scale - 1) * -1
				local V = (Precentage - 1) * -1
				BrightnessDragger.Position = UDim2.new(math.clamp(Precentage, 0, 1), 0, 0.27, 0)
				Color = Color3.fromHSV(math.clamp(H, 0, 1), math.clamp(S, 0, 1), math.clamp(V, 0, 1))
				ColorBackground.ImageColor3 = Color
			    if flag ~= "" then
			        Location[flag] = Color
				end
				local Success, Err = pcall(Callback, Color)
				if not Success and error then
					error(Err)
				end
			end
		end)
		
        game:GetService("UserInputService").InputChanged:Connect(function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
				if HueDragging then
					local Mouse = game.Players.LocalPlayer:GetMouse()
                	local Relpos = Vector2.new(Mouse.x, Mouse.y) - Hue.AbsolutePosition
					local H = Relpos.x / Hue.AbsoluteSize.x
					local S = (SaterationDragger.Position.X.Scale - 1) * -1
					local V = (BrightnessDragger.Position.X.Scale - 1) * -1
					HueDragger.Position = UDim2.new(math.clamp(H, 0, 1), 0, 0.27, 0)
					Color = Color3.fromHSV(math.clamp(H, 0, 1), math.clamp(S, 0, 1), math.clamp(V, 0, 1))
					ColorBackground.ImageColor3 = Color
					UIGradient.Color = ColorSequence.new(Color3.fromHSV(math.clamp(H, 0, 1),1,1), Color3.fromRGB(255, 255, 255))
					if flag ~= "" then
			            Location[flag] = Color
					end
					local Success, Err = pcall(Callback, Color)
					if not Success and error then
						error(Err)
					end
				end
				if SaterationDragging then
					local Mouse = game.Players.LocalPlayer:GetMouse()
					local Relpos = Vector2.new(Mouse.x, Mouse.y) - Sateration.AbsolutePosition
					local Precentage = Relpos.x / Sateration.AbsoluteSize.x
					local H = HueDragger.Position.X.Scale
					local S = (Precentage - 1) * -1
					local V = (BrightnessDragger.Position.X.Scale - 1) * -1
					SaterationDragger.Position = UDim2.new(math.clamp(Precentage, 0, 1), 0, 0.27, 0)
					Color = Color3.fromHSV(math.clamp(H, 0, 1), math.clamp(S, 0, 1), math.clamp(V, 0, 1))
					ColorBackground.ImageColor3 = Color
			        if flag ~= "" then
			            Location[flag] = Color
					end
					local Success, Err = pcall(Callback, Color)
					if not Success and error then
						error(Err)
					end
				end
				if BrightnessDragging then
					local Mouse = game.Players.LocalPlayer:GetMouse()
					local Relpos = Vector2.new(Mouse.x, Mouse.y) - Sateration.AbsolutePosition
					local Precentage = Relpos.x / Sateration.AbsoluteSize.x
					local H = HueDragger.Position.X.Scale
					local S = (SaterationDragger.Position.X.Scale - 1) * -1
					local V = (Precentage - 1) * -1
					BrightnessDragger.Position = UDim2.new(math.clamp(Precentage, 0, 1), 0, 0.27, 0)
					Color = Color3.fromHSV(math.clamp(H, 0, 1), math.clamp(S, 0, 1), math.clamp(V, 0, 1))
					ColorBackground.ImageColor3 = Color
			        if flag ~= "" then
			            Location[flag] = Color
					end
					local Success, Err = pcall(Callback, Color)
					if not Success and error then
						error(Err)
					end
				end
			end
		end)
		
		game:GetService("UserInputService").InputEnded:Connect(function(input)
			if input.UserInputType==Enum.UserInputType.MouseButton1 then
				HueDragging, SaterationDragging, BrightnessDragging = false, false, false
			end
		end)
		
		return {
			Set = function(self, value)
				Color = value
				local H, S, V = Color3.toHSV(Color)
				SaterationDragger.Position = UDim2.new(math.clamp((S -1) * -1, 0, 1), 0, 0.275000006, 0)
				BrightnessDragger.Position = UDim2.new(math.clamp((V -1) * -1, 0, 1), 0, 0.27, 0)
				HueDragger.Position = UDim2.new(math.clamp(H, 0, 1), 0, 0.275000006, 0)
				UIGradient.Color = ColorSequence.new(Color3.fromHSV(math.clamp(H, 0, 1),1,1), Color3.fromRGB(255, 255, 255))
				ColorBackground.ImageColor3 = Color
				if flag ~= "" then
			    	Location[flag] = Color
				end
			end;
			ChangeCallback = function(self, val)
				Callback = val
			end
		}
	end
	
	function window:Toggle(...)
		local Args = {...}
		local Name = Args[1] or "Toggle"
		local Options = Args[2] or {}
		local Location = Options.location and Options.location or window.flags
		local Toggled = Options.Default and true or false
		local Callback = Args[3] or function() end
		local Time = 0.3
		local Toggle = Instance.new("Frame")
		local Button = Instance.new("TextButton")
		local Background = Instance.new("ImageLabel")
		local TextLabel = Instance.new("TextLabel")
		local ToggleImage = Instance.new("ImageLabel")

		Toggle.Name = "Toggle"
		Toggle.Parent = self.parent
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1.000
		Toggle.BorderSizePixel = 0
		Toggle.Size = UDim2.new(1, 0, 0, 30)
		
		Button.Name = "Button"
		Button.Parent = Toggle
		Button.AnchorPoint = Vector2.new(1, 0.5)
		Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
		Button.BackgroundTransparency = 1.000
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(1, -5, 0.5, 0)
		Button.Size = UDim2.new(0, 24, 0, 24)
		Button.Font = Enum.Font.SourceSans
		Button.Text = ""
		Button.TextColor3 = Color3.fromRGB(0, 0, 0)
		Button.TextSize = 14.000
		
		Background.Name = "Background"
		Background.Parent = Button
		Background.Active = true
		Background.AnchorPoint = Vector2.new(0.5, 0.5)
		Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Background.BackgroundTransparency = 1.000
		Background.Position = UDim2.new(0.5, 0, 0.5, 0)
		Background.Selectable = true
		Background.Size = UDim2.new(1, 0, 1, 0)
		Background.Image = Rounded
		Background.ImageColor3 = Color3.fromRGB(80, 80, 80)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		TextLabel.Parent = Toggle
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0, 5, 0, 0)
		TextLabel.Size = UDim2.new(1, -35, 1, 0)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = Name
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 18.000
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		ToggleImage.Name = "Toggle"
		ToggleImage.Parent = Button
		ToggleImage.AnchorPoint = Vector2.new(0.5, 0.5)
		ToggleImage.BackgroundTransparency = 1.000
		ToggleImage.Position = UDim2.new(0.5, 0, 0.5, 0)
		ToggleImage.Size = UDim2.new(0.75, 0, 0.75, 0)
		ToggleImage.Image = Rounded
		ToggleImage.ImageColor3 = Toggled and Color3.fromRGB(120, 120, 120) or Background.ImageColor3
		ToggleImage.ScaleType = Enum.ScaleType.Slice
		ToggleImage.SliceCenter = Rect.new(100, 100, 100, 100)
		ToggleImage.SliceScale = 0.040
	
		Button.MouseButton1Click:Connect(function()
			spawn(function()
            	local Circle = Instance.new("ImageLabel")
                Circle.Name = "Circle"
                Circle.Parent = Button
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.BackgroundTransparency = 1.000
                Circle.ZIndex = 100
                Circle.Image = "rbxassetid://266543268"
                Circle.ImageTransparency = 0.900
                local Mouse = game.Players.LocalPlayer:GetMouse()
                Button.ClipsDescendants = true
                local NewX = Mouse.X - Circle.AbsolutePosition.X
                local NewY = Mouse.Y - Circle.AbsolutePosition.Y
                Circle.Position = UDim2.new(0, NewX, 0, NewY)
                local Size = 0
                if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
                    Size = Button.AbsoluteSize.X * 1.5
                elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
                    Size = Button.AbsoluteSize.Y * 1.5
                elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then
	            	Size = Button.AbsoluteSize.X * 1.5
                    end
                Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size / 2, 0.5, -Size / 2), "Out", "Quad", Time, false, nil)
                for i = 1, 10 do
                    Circle.ImageTransparency = Circle.ImageTransparency + 0.01
                    wait(Time / 10)
                end
                Circle:Destroy()			
			end)
			Toggled = not Toggled
			if Options.flag and Options.flag ~= "" then
				Location[Options.flag] = Toggled
			end
			ToggleImage.ImageColor3 = Toggled and Color3.fromRGB(140, 140, 140) or Background.ImageColor3
			local Success, Err = pcall(Callback, Toggled)
			if not Success and error then
				error(Err)
			end
		end)
		
		return {
			Set = function(self, val)
				Toggled = val
				if Options.flag and Options.flag ~= "" then
					Location[Options.flag] = Toggled
				end
				ToggleImage.ImageColor3 = Toggled and Color3.fromRGB(140, 140, 140) or Background.ImageColor3
			end;
			ChangeCallback = function(self, val)
				Callback = val
			end
		}
	end
	
	function window:Folder(...)
		local Args = {...}
		local Name = Args[1] or "Folder"
		local Folder = deepcopy(window)
		Folder.toggled = false
		local Title = Instance.new("ImageLabel")
		local Text = Instance.new("TextLabel")
		local Toggle = Instance.new("TextButton")
		local ImageLabel = Instance.new("ImageLabel")

		Title.Name = "Title"
		Title.Parent = self.parent
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.Position = UDim2.new(0, 0, 0.287581712, 0)
		Title.Size = UDim2.new(1.00000012, 0, 0, 28)
		Title.ZIndex = 2
		Title.Image = Rounded
		Title.ImageColor3 = Color3.fromRGB(57, 57, 57)
		Title.ScaleType = Enum.ScaleType.Slice
		Title.SliceCenter = Rect.new(100, 100, 100, 100)
		Title.SliceScale = 0.040
		
		Text.Name = "Text"
		Text.Parent = Title
		Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Text.BackgroundTransparency = 1.000
		Text.Size = UDim2.new(1, 0, 1, 0)
		Text.ZIndex = 3
		Text.Font = Enum.Font.SourceSans
		Text.Text = Name
		Text.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text.TextSize = 18.000
		
		Toggle.Name = "Toggle"
		Toggle.Parent = Title
		Toggle.AnchorPoint = Vector2.new(1, 1)
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1.000
		Toggle.BorderColor3 = Color3.fromRGB(27, 42, 53)
		Toggle.Position = UDim2.new(1, 0, 1, 0)
		Toggle.Rotation = 270.000
		Toggle.Selectable = false
		Toggle.Size = UDim2.new(0, 30, 1, 0)
		Toggle.ZIndex = 4
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = ""
		Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.TextScaled = true
		Toggle.TextSize = 14.000
		Toggle.TextWrapped = true
		
		ImageLabel.Parent = Toggle
		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel.ZIndex = 3
		ImageLabel.Image = ToggleImage
		
		local FolderContainer = Instance.new("ImageLabel")
		local UIListLayout = Instance.new("UIListLayout")
		Folder.parent = FolderContainer

		FolderContainer.Name = "FolderContainer"
		FolderContainer.Parent = self.parent
		FolderContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		FolderContainer.BackgroundTransparency = 1.000
		FolderContainer.Position = UDim2.new(0, 0, 0.994350255, 0)
		FolderContainer.Size = UDim2.new(1, 0, 0, 0)
		FolderContainer.Image = Rounded
		FolderContainer.ImageColor3 = Color3.fromRGB(65, 65, 65)
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
		
		local down =
	 	    TweenService:Create(
		    Toggle,
		    TweenInfo.new(0.2),
		    {
		    	Rotation = 180
		    }
		)
		local up =
	 	    TweenService:Create(
		    Toggle,
		    TweenInfo.new(0.2),
		    {
		    	Rotation = 270
		    }
		)
		
		Toggle.MouseButton1Click:Connect(function()
			FolderContainer.ClipsDescendants = true
			Folder.toggled = not Folder.toggled
			for i,v in pairs(Folder.ToggleEvent) do
				spawn(v, Folder.toggled)
			end
			if Folder.toggled then
				down:Play()
				FolderContainer:TweenSize(UDim2.new(1,0,0, UIListLayout.AbsoluteContentSize.Y), "Out", "Quad", 0.2, true)
			else
				up:Play()
				FolderContainer:TweenSize(UDim2.new(1,0,0,0), "Out", "Quad", 0.2, true)
			end
		end)
		
		return Folder
	end
	
	library.count = library.count + 1
	Drag(Main)
	return window
end

return library
