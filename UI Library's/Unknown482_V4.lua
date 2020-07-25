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
			coroutine.resume(coroutine.create(function() 
				pcall(v, window.toggled)	
			end))
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
		Background.Image = "rbxassetid://3570695787"
		Background.ImageColor3 = Color3.fromRGB(53, 53, 53)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		Button_2.MouseButton1Click:Connect(function()
			coroutine.resume(coroutine.create(function()
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
			end))
			pcall(Callback)
		end)
		
		return {
			Fire = function(self)
				pcall(Callback)
			end
		}
	end
	
	function window:Slider(...)
		local Args = {...}
		local Name = Args[1] or "Slider"
		local callback = Args[3] or function()end
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
		Background.Image = "rbxassetid://3570695787"
		Background.ImageColor3 = Color3.fromRGB(57, 57, 57)
		Background.ScaleType = Enum.ScaleType.Slice
		Background.SliceCenter = Rect.new(100, 100, 100, 100)
		Background.SliceScale = 0.040
		
		Fill.Name = "Fill"
		Fill.Parent = Background
		Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Fill.BackgroundTransparency = 1.000
		Fill.Size = UDim2.new((1 - ((Max - Default) / (Max - Min))), 0, 1, 0)
		Fill.Image = "rbxassetid://3570695787"
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
		Handle.Image = "rbxassetid://3570695787"
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
		Title.TextSize = 14.000
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
		
		Image.Name = "Image"
		Image.Parent = Amount
		Image.Active = true
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Image.BackgroundTransparency = 1.000
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Selectable = true
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.Image = "rbxassetid://3570695787"
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
						         pcall(callback, tonumber(Amount.Text))
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
                    coroutine.resume(coroutine.create(function()
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
					                pcall(callback, tonumber(Amount.Text))
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
						         pcall(callback, tonumber(Amount.Text))
								 old = tonumber(Amount.Text)
                            end
                        )
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
			pcall(callback, tonumber(Amount.Text))
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
                pcall(callback, value)
            end
        }
	end
	
	function window:Dropdown(...)
		local args = {...}
		local Name = args[1] or "DropDown"
		local callback = args[3] or function()end
        local List = args[2].list or {}
		local flag = args[2].flag or ""
		local Location = args[2].location and args[2].location or window.flags
        local old = ""
        local Toggled = false
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
		Background.Image = "rbxassetid://3570695787"
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
		ImageLabel.Image = "rbxassetid://538059577"
		
        old = TextLabel.Text

        local down = TweenService:Create(Toggle,TweenInfo.new(0.2),{Rotation = 180})
        local up = TweenService:Create(Toggle,TweenInfo.new(0.2),{Rotation = 270})
		
		local function CreateDropDown(Array)
			self.parent.ClipsDescendants = false
			Container.ClipsDescendants = false
			local Dropdown1 = Instance.new("ImageLabel")
			local UIGridLayout = Instance.new("UIGridLayout")
			local UIPadding = Instance.new("UIPadding")
			
			Dropdown1.Name = "Dropdown"
 			Dropdown1.Parent = TextLabel
			Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
			Dropdown1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown1.BackgroundTransparency = 1.000
			Dropdown1.Position = UDim2.new(0.5, 0, 0, 0)
			Dropdown1.Size = UDim2.new(1, 0, 0, 0)
			Dropdown1.Image = "rbxassetid://3570695787"
			Dropdown1.ImageColor3 = Color3.fromRGB(70, 70, 70)
			Dropdown1.ScaleType = Enum.ScaleType.Slice
			Dropdown1.SliceCenter = Rect.new(100, 100, 100, 100)
			Dropdown1.SliceScale = 0.040
			Dropdown1.ClipsDescendants = true
			Dropdown1.ZIndex = 5
			
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
				Image.Image = "rbxassetid://3570695787"
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
					pcall(callback, TextButton.Text)
				end)
			end
			Dropdown1:TweenSize(UDim2.new(1,0,0,UIGridLayout.AbsoluteContentSize.Y + 25),nil,nil,0.2,true)
		end
		
		function CloseDropdown(v)
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
			coroutine.resume(coroutine.create(function()
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
			end))
			Toggled = not Toggled
			if Options.flag and Options.flag ~= "" then
				Location[Options.flag] = Toggled
			end
			ToggleImage.ImageColor3 = Toggled and Color3.fromRGB(140, 140, 140) or Background.ImageColor3
			pcall(Callback, Toggled)
		end)
		
		return {
			Set = function(self, val)
				Toggled = val
				if Options.flag and Options.flag ~= "" then
					Location[Options.flag] = Toggled
				end
				ToggleImage.ImageColor3 = Toggled and Color3.fromRGB(140, 140, 140) or Background.ImageColor3
				pcall(Callback, Toggled)
			end
		}
	end
	
	function window:Folder(...)
		local Args = {...}
		local Name = Args[1] or "Folder"
		local Folder = deepcopy(window)
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
		Title.Image = "rbxassetid://3570695787"
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
		ImageLabel.Image = "http://www.roblox.com/asset/?id=538059577"
		
		local FolderContainer = Instance.new("ImageLabel")
		local UIListLayout = Instance.new("UIListLayout")
		Folder.parent = FolderContainer

		FolderContainer.Name = "FolderContainer"
		FolderContainer.Parent = self.parent
		FolderContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		FolderContainer.BackgroundTransparency = 1.000
		FolderContainer.Position = UDim2.new(0, 0, 0.994350255, 0)
		FolderContainer.Size = UDim2.new(1, 0, 0, 0)
		FolderContainer.Image = "rbxassetid://3570695787"
		FolderContainer.ImageColor3 = Color3.fromRGB(65, 65, 65)
		FolderContainer.ScaleType = Enum.ScaleType.Slice
		FolderContainer.SliceCenter = Rect.new(100, 100, 100, 100)
		FolderContainer.SliceScale = 0.040
		FolderContainer.ClipsDescendants = true
		
		UIListLayout.Parent = FolderContainer
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		
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
				coroutine.resume(coroutine.create(function() 
					pcall(v, Folder.toggled)
				end))
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
