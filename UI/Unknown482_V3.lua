local TweenService = game:GetService("TweenService")
local Lib = {
	AccentColor = Color3.fromRGB(0, 255, 0),
	BackColor = Color3.fromRGB(50, 50, 50),
	SecondColor = Color3.fromRGB(40, 40, 40),
	ThirdColor = Color3.fromRGB(60, 60, 60),
	SectionColor = Color3.fromRGB(35, 35, 35),
	TextColor = Color3.fromRGB(255, 255, 255),
	Toggled = true,
	Count = 0
}
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.DisplayOrder = 2147483647
if game:GetService("CoreGui") then
	ScreenGui.Parent = game:GetService("CoreGui")
else
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false
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

game:GetService("UserInputService").InputBegan:Connect(
    function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.RightControl then
            Lib.Toggled = not Lib.Toggled
            for i, v in pairs(ScreenGui:GetChildren()) do
				v:TweenPosition(Lib.Toggled and UDim2.new(0, (i - 1) * (v.AbsoluteSize.X + 10) + 35, 0, 20) 
					or UDim2.new(-0.5, 0, -0.5, 0),"InOut","Quad",0.2,true)
            end
        end
    end
)
function Lib:CreateWindow(...)
	local args = {...}
	local WindowInst = {
		AccentColor = args[2] and args[2].AccentColor or Lib.AccentColor,
		BackColor = args[2] and args[2].BackColor or Lib.BackColor,
		SecondColor = args[2] and args[2].SecondColor or Lib.SecondColor,
		ThirdColor = args[2] and args[2].ThirdColor or Lib.ThirdColor,
		SectionColor = args[2] and args[2].SectionColor or Lib.SectionColor,
		TextColor = args[2] and args[2].TextColor or Lib.TextColor,
		Toggled = true,
		flags = {},
		ToggleEvent = Instance.new("BindableEvent")
	}
	local name = args[1] or "Window"
	local Top = Instance.new("Frame")
	local ColorBar = Instance.new("Frame")
	local Main = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local TextLabel = Instance.new("TextLabel")
	local Toggle = Instance.new("TextButton")
	Drag(Top)

	Toggle.Name = "Toggle"
	Toggle.Parent = Top
	Toggle.AnchorPoint = Vector2.new(1, 0.5)
	Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Toggle.BackgroundTransparency = 1.000
	Toggle.Position = UDim2.new(1, 0, 0.433333337, 0)
	Toggle.Size = UDim2.new(0, 26, 0, 26)
	Toggle.Font = Enum.Font.SourceSans
	Toggle.Text = "▼"
	Toggle.TextColor3 = WindowInst.TextColor
	Toggle.TextSize = 20.000
	Toggle.TextWrapped = true
	
	Top.Name = "Top"
	Top.Parent = ScreenGui
	Top.BackgroundColor3 = WindowInst.SecondColor
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(0, 180, 0, 28)
	Top.Position = UDim2.new(0, Lib.Count * (Top.AbsoluteSize.X + 10) + 35 + 20, 0, 20)
	Lib.Count = Lib.Count + 1
	
	ColorBar.Name = "ColorBar"
	ColorBar.Parent = Top
	ColorBar.BackgroundColor3 = WindowInst.AccentColor
	ColorBar.BorderSizePixel = 0
	ColorBar.Position = UDim2.new(0, 0, 0.93, 0)
	ColorBar.Size = UDim2.new(1, 0, 0, 2)
	ColorBar.ZIndex = 2
	
	Main.Name = "Main"
	Main.Parent = Top
	Main.BackgroundColor3 = WindowInst.BackColor
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0, 0, 1, 0)
	Main.Size = UDim2.new(1, 0, 0, 100)
	
	UIListLayout.Parent = Main
	UIListLayout.Padding = UDim.new(0,0)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	UIPadding.Parent = Main
	UIPadding.PaddingBottom = UDim.new(0, 2)
	UIPadding.PaddingTop = UDim.new(0, 2)
	
	TextLabel.Parent = Top
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = name
	TextLabel.TextColor3 = WindowInst.TextColor
	TextLabel.TextSize = 18.000
	TextLabel.TextWrapped = true
	
	local down =
 	    TweenService:Create(
	    Toggle,
	    TweenInfo.new(0.2),
	    {
	    	Rotation = 0
	    }
	)
	local up =
 	    TweenService:Create(
	    Toggle,
	    TweenInfo.new(0.2),
	    {
	    	Rotation = 90
	    }
	)
	Toggle.MouseButton1Click:Connect(function()
		Main.ClipsDescendants = true
		WindowInst.Toggled = not WindowInst.Toggled
		WindowInst.ToggleEvent:Fire(WindowInst.Toggled)
		if WindowInst.Toggled then
			down:Play()
			Main:TweenSize(UDim2.new(1,0,0,UIListLayout.AbsoluteContentSize.Y + 3), "Out", "Quad", 0.2, true)
		else
			up:Play()
			Main:TweenSize(UDim2.new(1,0,0,0), "Out", "Quad", 0.2, true)
		end
	end)
	
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Main.Size = UDim2.new(1,0,0,UIListLayout.AbsoluteContentSize.Y + 3)
	end)
	
    function WindowInst:Dropdown(...)
		local args = {...}
		local name = args[1] or "DropDown"
		local callback = args[3] or function()end
        local List = args[2].list or {}
        local flag = args[2].flag or ""
        local old = ""
        local Toggled = false
        if flag ~= "" then
            WindowInst.flags[flag] = tostring(List[1])
        end
 
        local Dropdown = Instance.new("Frame")
        local Toggle = Instance.new("TextButton")
        local TextLabel = Instance.new("TextLabel")
        local Image = Instance.new("ImageLabel")
 
        Dropdown.Name = "Dropdown"
        Dropdown.Parent = Main
        Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Dropdown.BackgroundTransparency = 1.000
        Dropdown.BorderSizePixel = 0
        Dropdown.Size = UDim2.new(1, 0, 0, 25)
 
        Toggle.Name = "Toggle"
        Toggle.Parent = Dropdown
        Toggle.AnchorPoint = Vector2.new(1, 0.5)
        Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.BackgroundTransparency = 1.000
        Toggle.BorderSizePixel = 0
        Toggle.Position = UDim2.new(0.970000029, 0, 0.5, 0)
        Toggle.Rotation = 90.000
        Toggle.Size = UDim2.new(0, 23, 0, 23)
        Toggle.ZIndex = 3
        Toggle.Font = Enum.Font.SourceSans
        Toggle.Text = "▼"
        Toggle.TextColor3 = WindowInst.TextColor
        Toggle.TextSize = 20.000
        Toggle.TextWrapped = true
 
        TextLabel.Parent = Dropdown
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel.BackgroundColor3 = WindowInst.SecondColor
		TextLabel.BorderSizePixel = 0
        TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        TextLabel.Size = UDim2.new(0.959999979, 0, 0, 22)
        TextLabel.ZIndex = 2
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.Text = tostring(List[1])
        TextLabel.TextColor3 = WindowInst.TextColor
        TextLabel.TextSize = 16.000

        old = TextLabel.Text

        local down =
            TweenService:Create(
            Toggle,
            TweenInfo.new(0.2),
            {
                Rotation = 0
            }
        )
        local up =
            TweenService:Create(
            Toggle,
            TweenInfo.new(0.2),
            {
                Rotation = 90
            }
        )
        WindowInst.ToggleEvent.Event:Connect(
            function(t)
				Toggle.Rotation = t and (Toggled and 0 or 90) or 0
                if Toggled then
                    up:Play()
                    Toggled = false
                    TextLabel.TextColor3 = WindowInst.TextColor
                    TextLabel.Text = old
                    if Dropdown:FindFirstChild("DropDown") then
                        Dropdown:FindFirstChild("DropDown"):TweenSize(
                            UDim2.new(0, 173, 0, 0),
                            "Out",
                            "Quad",
                            0.2,
                            true,
                            function()
                                Dropdown:FindFirstChild("DropDown"):Destroy()
                            end
                        )
                    end
                end
            end
        )
 
        local function CreateDropDown(array)
            Toggled = true
            Main.ClipsDescendants = false
            Toggle.ZIndex = 8
            TextLabel.ZIndex = 7
            Image.ZIndex = 6
            if table.getn(array) > 5 then
                local Dropdown1 = Instance.new("Frame")
                local ScrollingFrame = Instance.new("ScrollingFrame")
                local UIGridLayout = Instance.new("UIGridLayout")
                local TextButton = Instance.new("TextButton")
                old = TextLabel.Text
                TextLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
                TextLabel.Text = name
 
                Dropdown1.Name = "DropDown"
                Dropdown1.Parent = Dropdown
                Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
                Dropdown1.BackgroundColor3 = WindowInst.BackColor
                Dropdown1.BorderSizePixel = 0
                Dropdown1.ZIndex = 3
                Dropdown1.ClipsDescendants = true
                Dropdown1.Position = UDim2.new(0.5, 0, 0, 12)
                Dropdown1.Size = UDim2.new(0, 176, 0, 0)
                Dropdown1.Visible = true
 
                ScrollingFrame.Parent = Dropdown1
                ScrollingFrame.Active = true
                ScrollingFrame.AnchorPoint = Vector2.new(0, 1)
                ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ScrollingFrame.BackgroundTransparency = 1.000
                ScrollingFrame.BorderSizePixel = 0
                ScrollingFrame.ZIndex = 3
                ScrollingFrame.Position = UDim2.new(0, 0, 1, -1)
                ScrollingFrame.Size = UDim2.new(0, 173, 0.89, 0)
                ScrollingFrame.BottomImage = ScrollingFrame.MidImage
                ScrollingFrame.TopImage = ScrollingFrame.MidImage
                ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, table.getn(array) * 24)
                ScrollingFrame.ScrollBarThickness = 5
 
                UIGridLayout.Parent = ScrollingFrame
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
                UIGridLayout.CellSize = UDim2.new(0, 170, 0, 23)
 
                for i, v in pairs(array) do
                    local Button = Instance.new("TextButton")
                    Button.Parent = ScrollingFrame
                    Button.BackgroundColor3 = WindowInst.SecondColor
                    Button.BorderSizePixel = 0
                    Button.Font = Enum.Font.SourceSans
                    Button.Name = tostring(v)
                    Button.Text = tostring(v)
                    Button.ZIndex = 4
                    Button.TextColor3 = WindowInst.TextColor
                    Button.TextSize = 16.000
	                Button.MouseButton1Click:Connect(function()
						if flag ~= "" then
	                    	WindowInst.flags[flag] = Button.Name
	                    end
	                    coroutine.resume(coroutine.create(function()
	                     	pcall(callback, Button.Name)
						end))
	                    TextLabel.Text = Button.Name
	                    TextLabel.TextColor3 = WindowInst.TextColor
	                    Toggled = false
	                    up:Play()
	                    Dropdown1:TweenSize(UDim2.new(0, 173, 0, 0), "Out", "Quad",0.2,true,function()
	                        Toggle.ZIndex = 3
	                        TextLabel.ZIndex = 2
	                        Image.ZIndex = 1
	                        Dropdown1:Destroy()
	                        Main.ClipsDescendants = true
	                    end)
                    end)
                end
                Dropdown1:TweenSize(UDim2.new(0, 173, 0, 134), "Out", "Quad", 0.2, true)
            else
                local Dropdown1 = Instance.new("Frame")
                local UIGridLayout = Instance.new("UIGridLayout")
                local UIPadding = Instance.new("UIPadding")
                old = TextLabel.Text
                TextLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
                TextLabel.Text = name
 
                Dropdown1.Name = "DropDown"
                Dropdown1.Parent = Dropdown
                Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
                Dropdown1.BackgroundColor3 = WindowInst.BackColor
                Dropdown1.BorderSizePixel = 0
                Dropdown1.ZIndex = 3
                Dropdown1.ClipsDescendants = true
                Dropdown1.Position = UDim2.new(0.5, 0, 0, 12)
                Dropdown1.Size = UDim2.new(0, 173, 0, 0)
 
                UIGridLayout.Parent = Dropdown1
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
                UIGridLayout.CellSize = UDim2.new(0, 173, 0, 23)
 
                UIPadding.Parent = Dropdown1
                UIPadding.PaddingTop = UDim.new(0, 14)
                for i, v in pairs(array) do
                    local Button = Instance.new("TextButton")
                    Button.Parent = Dropdown1
                    Button.BackgroundColor3 = WindowInst.SecondColor
                    Button.BorderSizePixel = 0
                    Button.Name = tostring(v)
                    Button.Text = tostring(v)
                    Button.ZIndex = 4
                    Button.Font = Enum.Font.SourceSans
                    Button.TextColor3 = WindowInst.TextColor
                    Button.TextSize = 16.000
                    Button.MouseButton1Click:Connect(
                        function()
	                        if flag ~= "" then
                                WindowInst.flags[flag] = Button.Name
                            end
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        pcall(callback, Button.Name)
                                    end
                                )
                            )
                            TextLabel.Text = Button.Name
                            TextLabel.TextColor3 = WindowInst.TextColor
                            Toggled = false
                            up:Play()
                            Dropdown1:TweenSize(
                                UDim2.new(0, 173, 0, 0),
                                "Out",
                                "Quad",
                                0.2,
                                true,
                                function()
                                    Toggle.ZIndex = 3
                                    TextLabel.ZIndex = 2
                                    Image.ZIndex = 1
                                    Dropdown1:Destroy()
                                    Main.ClipsDescendants = true
                                end
                            )
                        end
                    )
                end
                Dropdown1:TweenSize(UDim2.new(0, 173, 0, table.getn(array) * 24 + 14), "Out", "Quad", 0.2, true)
            end
        end
        Toggle.MouseButton1Click:Connect(
            function()
                if not Toggled then
                    down:Play()
                    CreateDropDown(List)
                else
                    if Dropdown:FindFirstChild("DropDown") then
                        up:Play()
                        Toggled = false
                        TextLabel.TextColor3 = WindowInst.TextColor
                        TextLabel.Text = old
                        Dropdown:FindFirstChild("DropDown"):TweenSize(UDim2.new(0, 173, 0, 0),"Out","Quad",0.2,true,function()
                            Toggle.ZIndex = 3
                            TextLabel.ZIndex = 2
                            Image.ZIndex = 1
                            Dropdown:FindFirstChild("DropDown"):Destroy()
                        end)
                    end
                end
            end
        )
        game:GetService("UserInputService").WindowFocusReleased:Connect(function()
                if Dropdown:FindFirstChild("DropDown") then
                    up:Play()
                    Toggled = false
                    TextLabel.TextColor3 = WindowInst.TextColor
                    TextLabel.Text = old
                    Dropdown:FindFirstChild("DropDown"):TweenSize( UDim2.new(0, 173, 0, 0), "Out", "Quad", 0.2, true, function()
                        Toggle.ZIndex = 3
                        TextLabel.ZIndex = 2
                        Image.ZIndex = 1
                        Dropdown:FindFirstChild("DropDown"):Destroy()
   	        		end)
                end
        end)
        return {
            Refresh = function(self, array)
                List = array
                TextLabel.TextColor3 = WindowInst.TextColor
                TextLabel.Text = tostring(array[1])
                if flag ~= "" then
                    WindowInst.flags[flag] = tostring(array[1])
                end
                up:Play()
                Toggled = false
                if Dropdown:FindFirstChild("DropDown") then
                    Dropdown:FindFirstChild("DropDown"):TweenSize(UDim2.new(0, 173, 0, 0), "Out", "Quad", 0.2, true, function()
                        Toggle.ZIndex = 3
                        TextLabel.ZIndex = 2
                        Image.ZIndex = 1
                        Dropdown:FindFirstChild("DropDown"):Destroy()
                	end)
                end
            end
        }
    end
	
	function WindowInst:Label(...)
		local args = {...}
		local name = args[1] or "Label"
		local Label = Instance.new("TextLabel")

		Label.Name = "Label"
		Label.Parent = Main
		Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Label.BackgroundTransparency = 1.000
		Label.Size = UDim2.new(1, 0, 0, 28)
		Label.Font = Enum.Font.SourceSans
		Label.TextColor3 = WindowInst.TextColor
		Label.TextSize = 16.000
		Label.Text = name
		
		return{
			Set = function(self, value)
				Label.Text = value
			end
		}
	end
	
	function WindowInst:Box(...)
		local args = {...}
		local name = args[1] or "Box"
        local callback = args[3] or function() end
        local type = args[2].type or "string"
        local default = args[2].default or ""
        local flag = args[2].flag or ""
        local placeholder = args[2].placeholder or ""
        local min = args[2].min or 0
        local max = args[2].max or 9e9
 
        if type == "number" and not tonumber(default) then
            default = "0"
        end
        if flag ~= "" then
            WindowInst.flags[flag] = default
        end
 
        local Box = Instance.new("Frame")
        local Tttle = Instance.new("TextLabel")
        local Box_2 = Instance.new("TextBox")
 
        Box.Name = "Box"
        Box.Parent = Main
        Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Box.BackgroundTransparency = 1.000
        Box.BorderSizePixel = 0
        Box.Size = UDim2.new(1, 0, 0, 25)
 
        Tttle.Name = "Tttle"
        Tttle.Parent = Box
        Tttle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tttle.BackgroundTransparency = 1.000
        Tttle.BorderSizePixel = 0
        Tttle.Position = UDim2.new(0.0331491861, 0, 0, 0)
        Tttle.Size = UDim2.new(0, 129, 0, 25)
        Tttle.Font = Enum.Font.SourceSans
        Tttle.Text = name
        Tttle.TextColor3 = WindowInst.TextColor
        Tttle.TextSize = 16.000
        Tttle.TextWrapped = true
        Tttle.TextXAlignment = Enum.TextXAlignment.Left
 
        Box_2.Name = "Box"
        Box_2.Parent = Box
        Box_2.AnchorPoint = Vector2.new(1, 0.5)
        Box_2.BackgroundColor3 = WindowInst.ThirdColor
        Box_2.BorderSizePixel = 0
        Box_2.Position = UDim2.new(0.980000019, 0, 0.5, 0)
        Box_2.Size = UDim2.new(0, 60, 0, 21)
        Box_2.ZIndex = 2
        Box_2.Font = Enum.Font.SourceSans
        Box_2.Text = default
        Box_2.PlaceholderText = placeholder
        Box_2.TextColor3 = WindowInst.TextColor
        Box_2.TextSize = 16.000
        Box_2.TextWrapped = true
 
        local old = Box_2.Text
        function PositiveIntegerMask(text)
            return text:gsub("[^%-%d]", "")
        end
        Box_2:GetPropertyChangedSignal("Text"):Connect(
            function()
                if (type == "number") then
                    Box_2.Text = PositiveIntegerMask(Box_2.Text)
                end
            end
        )
 
        Box_2.FocusLost:connect(
            function(enterPressed)
                if type == "number" then
                    if not tostring(Box_2.Text) then
                        Box_2.Text = tostring(0)
                    end
                    if old == "" then
                        old = tostring(0)
                    end
                    if Box_2.Text == "" then
                        Box_2.Text = tostring(0)
                    end
                    if (tonumber(Box_2.Text) > max) then
                        Box_2.Text = tostring(max)
                    end
                    if (tonumber(Box_2.Text) < min) then
                        Box_2.Text = tostring(min)
                    end
                    if flag ~= "" then
                        WindowInst.flags[flag] = tonumber(Box_2.Text)
                    end
                    pcall(callback, Box_2, tonumber(Box_2.Text), tonumber(old), enterPressed)
                else
                    if flag ~= "" then
                        WindowInst.flags[flag] = Box_2.Text
                    end
                    pcall(callback, Box_2, Box_2.Text, old, enterPressed)
                end
                old = Box_2.Text
            end
        )
        return {
            Set = function(self, value)
                if type == "number" then
                    Box_2.Text = tostring(value)
                    if flag ~= "" then
                        WindowInst.flags[flag] = tonumber(Box_2.Text)
                    end
                    pcall(callback, Box_2, tonumber(Box_2.Text), tonumber(old), true)
                else
                    Box_2.Text = tostring(value)
                    if flag ~= "" then
                        WindowInst.flags[flag] = Box_2.Text
                    end
                    pcall(callback, Box_2, Box_2.Text, old, true)
                end
            end
        }
    end
	
	function WindowInst:Slider(...)
		local args = {...}
        local callback = args[3] or function() end
		local name = args[1]
        local min = args[2].min or 0
        local max = args[2].max or 10
        local default = math.clamp(args[2].default, min, max) or min
        local step = args[2].step or 1
        local callonstartup = args[2].callonstartup or false
        local flag = args[2].flag or ""
        if flag ~= "" then
            WindowInst.flags[flag] = default
        end
        if callonstartup then
            pcall(callback, default)
        end
 
        local Slider = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local Back = Instance.new("Frame")
        local Fill = Instance.new("Frame")
        local Handle = Instance.new("TextButton")
        local Image = Instance.new("ImageLabel")
        local Amount = Instance.new("TextLabel")
 
        Slider.Name = "Slider"
        Slider.Parent = Main
        Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Slider.BackgroundTransparency = 1.000
        Slider.BorderSizePixel = 0
        Slider.Size = UDim2.new(1, 0, 0, 25)
 
        Title.Name = "Title"
        Title.Parent = Slider
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.BorderSizePixel = 0
        Title.Position = UDim2.new(0.0399999991, 0, 0, 0)
        Title.Size = UDim2.new(0, 129, 0, 13)
        Title.Font = Enum.Font.SourceSans
        Title.Text = name
        Title.TextColor3 = WindowInst.TextColor
        Title.TextSize = 15.000
        Title.TextWrapped = true
        Title.TextXAlignment = Enum.TextXAlignment.Left
 
        Back.Name = "Back"
        Back.Parent = Slider
        Back.AnchorPoint = Vector2.new(0.5, 0.5)
        Back.Position = UDim2.new(0.504999995, 0, 0.779999971, 0)
        Back.Size = UDim2.new(0, 165, 0, 4)
        Back.BackgroundColor3 = WindowInst.ThirdColor
		Back.BorderSizePixel = 0
 
        Fill.Name = "Fill"
        Fill.Parent = Back
        Fill.Position = UDim2.new(0.00281458977, 0, 0, 0)
        Fill.Size = UDim2.new((1 - ((max - default) / (max - min))), 0, 1, 0)
        Fill.BackgroundColor3 = WindowInst.AccentColor
		Fill.BorderSizePixel = 0

        Handle.Name = "Handle"
        Handle.Parent = Fill
        Handle.AnchorPoint = Vector2.new(0.5, 0.5)
        Handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Handle.BackgroundTransparency = 1.000
        Handle.BorderSizePixel = 0
        Handle.Position = UDim2.new(1, 0, 0.5, 0)
        Handle.Size = UDim2.new(0, 9, 0, 9)
        Handle.ZIndex = 2
        Handle.Font = Enum.Font.SourceSans
        Handle.Text = ""
        Handle.TextColor3 = Color3.fromRGB(0, 0, 0)
        Handle.TextSize = 14.000
 
        Image.Name = "Image"
        Image.Parent = Handle
        Image.Active = true
        Image.AnchorPoint = Vector2.new(0.5, 0.5)
        Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Image.BackgroundTransparency = 1.000
        Image.Position = UDim2.new(0.5, 0, 0.5, 0)
        Image.Selectable = true
        Image.Size = UDim2.new(1, 0, 1, 0)
        Image.Image = "rbxassetid://3570695787"
        Image.ScaleType = Enum.ScaleType.Fit
        Image.SliceCenter = Rect.new(100, 100, 100, 100)
        Image.SliceScale = 0.075
 
        Amount.Name = "Amount"
        Amount.Parent = Slider
        Amount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Amount.BackgroundTransparency = 1.000
        Amount.BorderSizePixel = 0
        Amount.Position = UDim2.new(0.730000079, 0, 0, 0)
        Amount.Size = UDim2.new(0, 40, 0, 19)
        Amount.Font = Enum.Font.SourceSans
        Amount.Text = tostring(default)
        Amount.TextColor3 = WindowInst.TextColor
        Amount.TextSize = 15.000
        Amount.TextWrapped = true
        Amount.TextXAlignment = Enum.TextXAlignment.Right
        Amount.TextYAlignment = Enum.TextYAlignment.Top
        local Dragging = false
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
        Back.InputBegan:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    coroutine.resume(
                        coroutine.create(
                            function()
                                Dragging = true
                                local Mouse = game.Players.LocalPlayer:GetMouse()
                                local Relpos = Vector2.new(Mouse.x, Mouse.y) - Fill.AbsolutePosition
                                local precentage = Relpos.x / Back.AbsoluteSize.x
 
                                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (max - min)), 0, 1, 0)
                                if step >= 1 then
                                    Amount.Text =
                                        string.format(
                                        "%.0f",
                                        math.floor((Fill.AbsoluteSize.x / Back.AbsoluteSize.x) * (max - min) + min)
                                    )
                                else
                                    local deccount = GetDecimalPlacesCount(step)
                                    local decsize = (step >= 1 and 10 or 100)
                                    Amount.Text =
                                        string.format(
                                        "%." .. (decsize == 10 and "1" or "2") .. "f",
                                        math.floor(
                                            ((Fill.AbsoluteSize.x / Back.AbsoluteSize.x) * (max - min) + min) *
                                                (decsize / (step * decsize))
                                        ) /
                                            (decsize / (step * decsize))
                                    )
                                end
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
                    coroutine.resume(
                        coroutine.create(
                            function()
                                local Mouse = game.Players.LocalPlayer:GetMouse()
                                local Relpos = Vector2.new(Mouse.x, Mouse.y) - Fill.AbsolutePosition
                                local precentage = Relpos.x / Back.AbsoluteSize.x
                                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (max - min)), 0, 1, 0)
                                if step >= 1 then
                                    Amount.Text =
                                        string.format(
                                        "%.0f",
                                        math.floor((Fill.AbsoluteSize.x / Back.AbsoluteSize.x) * (max - min) + min)
                                    )
                                else
                                    local deccount = GetDecimalPlacesCount(step)
                                    local decsize = (step >= 1 and 10 or 100)
                                    Amount.Text =
                                        string.format(
                                        "%." .. (decsize == 10 and "1" or "2") .. "f",
                                        math.floor(
                                            ((Fill.AbsoluteSize.x / Back.AbsoluteSize.x) * (max - min) + min) *
                                                (decsize / (step * decsize))
                                        ) /
                                            (decsize / (step * decsize))
                                    )
                                end
                            end
                        )
                    )
                end
            end
        )
        game:GetService("UserInputService").WindowFocusReleased:Connect(
            function()
                Dragging = false
            end
        )
        Amount:GetPropertyChangedSignal("Text"):Connect(
            function()
                if flag ~= "" then
                    WindowInst.flags[flag] = tonumber(Amount.Text)
                end
                pcall(callback, tonumber(Amount.Text))
            end
        )
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
                value = math.clamp(value, min, max)
                local precentage = value < min and 0 or value > max and 1 or (1 - ((max - value) / (max - min)))
                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (max - min)), 0, 1, 0)
                if flag ~= "" then
                    WindowInst.flags[flag] = tonumber(value)
                end
                pcall(callback, value)
            end
        }
    end
	
	function WindowInst:Section(...)
		local args = {...}
		local name = args[1] or "Section"
		local Section = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		
		Section.Name = "Section"
		Section.Parent = Main
		Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Section.BackgroundTransparency = 1.000
		Section.Size = UDim2.new(1, 0, 0, 28)
		
		TextLabel.Parent = Section
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundColor3 = WindowInst.SectionColor
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 0, 24)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = name
		TextLabel.TextColor3 = WindowInst.TextColor
		TextLabel.TextSize = 16.000
		return{
			Set = function(self, value)
				TextLabel.Text = value
			end
		}
	end
	
	function WindowInst:Button(...)
		local args = {...}
		local name = args[1] or "Button"
		local callback = args[2] or function() end

		local Button = Instance.new("Frame")
		local TextButton = Instance.new("TextButton")
		
		Button.Name = "Button"
		Button.Parent = Main
		Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundTransparency = 1.000
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(0, 0, 0.00858369097, 0)
		Button.Size = UDim2.new(1, 0, 0, 28)
		
		TextButton.Parent = Button
		TextButton.Text = name
		TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
		TextButton.BackgroundColor3 = WindowInst.SecondColor
		TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
		TextButton.BorderSizePixel = 0
		TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextButton.Size = UDim2.new(0.959999979, 0, 0, 22)
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextColor3 = WindowInst.TextColor
		TextButton.TextSize = 16.000
		
		TextButton.MouseButton1Click:Connect(function()
			pcall(callback)
		end)
		
		return {
			Fire = function(self)
				pcall(callback)
			end
        }
	end
	
	function WindowInst:Toggle(...)
		local args = {...}
		local name = args[1] or "Toggle"
		local options = args[2]
		local callback = args[3] or function() end
		local flag = options.flag or ""
		local default = options.default or false
		local Toggled = default or false
		
		local Toggle = Instance.new("Frame")
		local ToggleButton = Instance.new("TextButton")
		local TextLabel = Instance.new("TextLabel")
		
		Toggle.Name = "Toggle"
		Toggle.Parent = Main
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1.000
		Toggle.BorderSizePixel = 0
		Toggle.Position = UDim2.new(0, 0, 0.00858369097, 0)
		Toggle.Size = UDim2.new(1, 0, 0, 28)
		
		ToggleButton.Name = "ToggleButton"
		ToggleButton.Parent = Toggle
		ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
		ToggleButton.BackgroundColor3 = WindowInst.ThirdColor
		ToggleButton.BorderSizePixel = 0
		ToggleButton.Position = UDim2.new(0.92, 0, 0.5, 0)
		ToggleButton.Size = UDim2.new(0, 21, 0, 21)
		ToggleButton.Font = Enum.Font.SourceSansBold
		ToggleButton.TextColor3 = WindowInst.TextColor
		ToggleButton.TextSize = 20.000
		ToggleButton.Text = Toggled and utf8.char(10003) or ""
		
		TextLabel.Parent = Toggle
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.Position = UDim2.new(0.0331491861, 0, 0, 0)
		TextLabel.Size = UDim2.new(0, 144, 0, 26)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = name
		TextLabel.TextColor3 = WindowInst.TextColor
		TextLabel.TextSize = 16.000
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		
		ToggleButton.MouseButton1Click:Connect(function()
			Toggled = not Toggled
			WindowInst.flags[flag] = Toggled
			ToggleButton.Text = Toggled and utf8.char(10003) or ""
			pcall(callback, Toggled)
		end)
		
		return {
			Set = function(self, value)
				Toggled = value
				WindowInst.flags[flag] = Toggled
				ToggleButton.Text = Toggled and utf8.char(10003) or ""
				pcall(callback, Toggled)
			end
        }
	end
	
	function WindowInst:SectionDropDown(...)
		local SectionInst = {
			Toggled = false
		}
		local args = {...}
		local name = args[1] or "Section"
		local SectionToggle = Instance.new("Frame")
		local TextLabel = Instance.new("TextLabel")
		local Toggle = Instance.new("TextButton")
		
		SectionToggle.Name = "SectionToggle"
		SectionToggle.Parent = Main
		SectionToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SectionToggle.BackgroundTransparency = 1.000
		SectionToggle.Size = UDim2.new(1, 0, 0, 28)
		
		TextLabel.Parent = SectionToggle
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BackgroundColor3 = WindowInst.SectionColor
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 0, 26)
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.Text = name
		TextLabel.TextColor3 = WindowInst.TextColor
		TextLabel.TextSize = 18.000

		Toggle.Name = "Toggle"
		Toggle.Parent = SectionToggle
		Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
		Toggle.BackgroundTransparency = 1.000
		Toggle.Position = UDim2.new(0.928176761, 0, 0.5, 0)
		Toggle.Size = UDim2.new(0.143646404, 0, 0, 26)
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = "▼"
		Toggle.TextColor3 = WindowInst.TextColor
		Toggle.TextSize = 20.000
		Toggle.Rotation = 90
		Toggle.TextWrapped = true
		
		local SectionDropDown = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		
		SectionDropDown.Name = "SectionDropDown"
		SectionDropDown.Parent = Main
		SectionDropDown.BackgroundColor3 = WindowInst.BackColor
		SectionDropDown.BorderSizePixel = 0
		SectionDropDown.ClipsDescendants = true
		SectionDropDown.Position = UDim2.new(0, 0, 0.28, 0)
		SectionDropDown.Size = UDim2.new(1, 0, 0, 0)
		
		UIListLayout.Parent = SectionDropDown
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0,0)
	    local down =
	        TweenService:Create(
	        Toggle,
	        TweenInfo.new(0.2),
	        {
	            Rotation = 0
	        }
	    )
	    local up =
	        TweenService:Create(
	        Toggle,
	        TweenInfo.new(0.2),
	        {
	            Rotation = 90
	        }
	    )
	
		Toggle.MouseButton1Click:Connect(function()
			SectionInst.Toggled = not SectionInst.Toggled
			SectionDropDown.ClipsDescendants = true
			if SectionInst.Toggled then
				down:Play()
				SectionDropDown:TweenSize(UDim2.new(1,0,0,UIListLayout.AbsoluteContentSize.Y + 2), "Out", "Quad", 0.2, true)
			else
				up:Play()
				SectionDropDown:TweenSize(UDim2.new(1,0,0,0), "Out", "Quad", 0.2, true)
			end
		end)
		
		WindowInst.ToggleEvent.Event:Connect(function(v)
			Toggle.Rotation = v and (SectionInst.Toggled and 0 or 90) or 0
		end)
		
		function SectionInst:Set(value)
			TextLabel.Text = value
		end
		
		function SectionInst:Dropdown(...)
			local args = {...}
			local name = args[1] or "DropDown"
			local callback = args[3] or function()end
	        local List = args[2].list or {}
	        local flag = args[2].flag or ""
	        local old = ""
	        local Toggled = false
	        if flag ~= "" then
	            WindowInst.flags[flag] = tostring(List[1])
	        end
	 
	        local Dropdown = Instance.new("Frame")
	        local Toggle = Instance.new("TextButton")
	        local TextLabel = Instance.new("TextLabel")
	        local Image = Instance.new("ImageLabel")
	 
	        Dropdown.Name = "Dropdown"
	        Dropdown.Parent = SectionDropDown
	        Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        Dropdown.BackgroundTransparency = 1.000
	        Dropdown.BorderSizePixel = 0
	        Dropdown.Size = UDim2.new(1, 0, 0, 25)
	 
	        Toggle.Name = "Toggle"
	        Toggle.Parent = Dropdown
	        Toggle.AnchorPoint = Vector2.new(1, 0.5)
	        Toggle.BackgroundTransparency = 1.000
	        Toggle.Position = UDim2.new(0.970000029, 0, 0.5, 0)
	        Toggle.Rotation = 90.000
	        Toggle.Size = UDim2.new(0, 22, 0, 22)
	        Toggle.ZIndex = 3
	        Toggle.Font = Enum.Font.SourceSans
	        Toggle.Text = "▼"
	        Toggle.TextColor3 = WindowInst.TextColor
	        Toggle.TextSize = 20.000
	        Toggle.TextWrapped = true
	 
	        TextLabel.Parent = Dropdown
	        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	        TextLabel.BackgroundColor3 = WindowInst.SecondColor
			TextLabel.BorderSizePixel = 0
	        TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	        TextLabel.Size = UDim2.new(0.959999979, 0, 0, 22)
	        TextLabel.ZIndex = 2
	        TextLabel.Font = Enum.Font.SourceSans
	        TextLabel.Text = tostring(List[1])
	        TextLabel.TextColor3 = WindowInst.TextColor
	        TextLabel.TextSize = 16.000
	
	        old = TextLabel.Text
	
	        local down =
	            TweenService:Create(
	            Toggle,
	            TweenInfo.new(0.2),
	            {
	                Rotation = 0
	            }
	        )
	        local up =
	            TweenService:Create(
	            Toggle,
	            TweenInfo.new(0.2),
	            {
	                Rotation = 90
	            }
	        )
	        WindowInst.ToggleEvent.Event:Connect(
	            function(t)
					Toggle.Rotation = t and (Toggled and 0 or 90) or 0
	                if Toggled then
	                    up:Play()
	                    Toggled = false
	                    TextLabel.TextColor3 = WindowInst.TextColor
	                    TextLabel.Text = old
	                    if Dropdown:FindFirstChild("DropDown") then
	                        Dropdown:FindFirstChild("DropDown"):TweenSize(
	                            UDim2.new(0, 173, 0, 0),
	                            "Out",
	                            "Quad",
	                            0.2,
	                            true,
	                            function()
	                                Dropdown:FindFirstChild("DropDown"):Destroy()
	                            end
	                        )
	                    end
	                end
	            end
	        )
	 
	        local function CreateDropDown(array)
	            Toggled = true
	            Main.ClipsDescendants = false
				SectionDropDown.ClipsDescendants = false
	            Toggle.ZIndex = 8
	            TextLabel.ZIndex = 7
	            Image.ZIndex = 6
	            if table.getn(array) > 5 then
	                local Dropdown1 = Instance.new("Frame")
	                local ScrollingFrame = Instance.new("ScrollingFrame")
	                local UIGridLayout = Instance.new("UIGridLayout")
	                local TextButton = Instance.new("TextButton")
	                old = TextLabel.Text
	                TextLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
	                TextLabel.Text = name
	 
	                Dropdown1.Name = "DropDown"
	                Dropdown1.Parent = Dropdown
	                Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
	                Dropdown1.BackgroundColor3 = WindowInst.BackColor
	                Dropdown1.BorderSizePixel = 0
	                Dropdown1.ZIndex = 3
	                Dropdown1.ClipsDescendants = true
	                Dropdown1.Position = UDim2.new(0.5, 0, 0, 12)
	                Dropdown1.Size = UDim2.new(0, 176, 0, 0)
	                Dropdown1.Visible = true
	 
	                ScrollingFrame.Parent = Dropdown1
	                ScrollingFrame.Active = true
	                ScrollingFrame.AnchorPoint = Vector2.new(0, 1)
	                ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	                ScrollingFrame.BackgroundTransparency = 1.000
	                ScrollingFrame.BorderSizePixel = 0
	                ScrollingFrame.ZIndex = 3
	                ScrollingFrame.Position = UDim2.new(0, 0, 1, -1)
	                ScrollingFrame.Size = UDim2.new(0, 173, 0.89, 0)
	                ScrollingFrame.BottomImage = ScrollingFrame.MidImage
	                ScrollingFrame.TopImage = ScrollingFrame.MidImage
	                ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, table.getn(array) * 24)
	                ScrollingFrame.ScrollBarThickness = 5
	 
	                UIGridLayout.Parent = ScrollingFrame
	                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	                UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
	                UIGridLayout.CellSize = UDim2.new(0, 170, 0, 23)
	 
	                for i, v in pairs(array) do
	                    local Button = Instance.new("TextButton")
	                    Button.Parent = ScrollingFrame
	                    Button.BackgroundColor3 = WindowInst.SecondColor
	                    Button.BorderSizePixel = 0
	                    Button.Font = Enum.Font.SourceSans
	                    Button.Name = tostring(v)
	                    Button.Text = tostring(v)
	                    Button.ZIndex = 4
	                    Button.TextColor3 = WindowInst.TextColor
	                    Button.TextSize = 16.000
	                    Button.MouseButton1Click:Connect(function()
							if flag ~= "" then
	                        	WindowInst.flags[flag] = Button.Name
	                        end
	                        coroutine.resume(coroutine.create(function()
	                        	pcall(callback, Button.Name)
							end))
	                        TextLabel.Text = Button.Name
	                        TextLabel.TextColor3 = WindowInst.TextColor
	                        Toggled = false
	                        up:Play()
	                        Dropdown1:TweenSize(UDim2.new(0, 173, 0, 0), "Out", "Quad",0.2,true,function()
	                            Toggle.ZIndex = 3
	                            TextLabel.ZIndex = 2
	                            Image.ZIndex = 1
	                            Dropdown1:Destroy()
	                            Main.ClipsDescendants = true
								SectionDropDown.ClipsDescendants = true
	                        end)
	                    end)
	                end
	                Dropdown1:TweenSize(UDim2.new(0, 173, 0, 134), "Out", "Quad", 0.2, true)
	            else
	                local Dropdown1 = Instance.new("Frame")
	                local UIGridLayout = Instance.new("UIGridLayout")
	                local UIPadding = Instance.new("UIPadding")
	                old = TextLabel.Text
	                TextLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
	                TextLabel.Text = name
	 
	                Dropdown1.Name = "DropDown"
	                Dropdown1.Parent = Dropdown
	                Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
	                Dropdown1.BackgroundColor3 = WindowInst.BackColor
	                Dropdown1.BorderSizePixel = 0
	                Dropdown1.ZIndex = 3
	                Dropdown1.ClipsDescendants = true
	                Dropdown1.Position = UDim2.new(0.5, 0, 0, 12)
	                Dropdown1.Size = UDim2.new(0, 173, 0, 0)
	 
	                UIGridLayout.Parent = Dropdown1
	                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	                UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
	                UIGridLayout.CellSize = UDim2.new(0, 173, 0, 23)
	 
	                UIPadding.Parent = Dropdown1
	                UIPadding.PaddingTop = UDim.new(0, 14)
	                for i, v in pairs(array) do
	                    local Button = Instance.new("TextButton")
	                    Button.Parent = Dropdown1
	                    Button.BackgroundColor3 = WindowInst.SecondColor
	                    Button.BorderSizePixel = 0
	                    Button.Name = tostring(v)
	                    Button.Text = tostring(v)
	                    Button.ZIndex = 4
	                    Button.Font = Enum.Font.SourceSans
	                    Button.TextColor3 = WindowInst.TextColor
	                    Button.TextSize = 16.000
	                    Button.MouseButton1Click:Connect(function()
			                if flag ~= "" then
	                        	WindowInst.flags[flag] = Button.Name
	                        end
	                        coroutine.resume(coroutine.create(function()
	                        	pcall(callback, Button.Name)
							end))
	                        TextLabel.Text = Button.Name
	                        TextLabel.TextColor3 = WindowInst.TextColor
	                        Toggled = false
	                        up:Play()
	                        Dropdown1:TweenSize(UDim2.new(0, 173, 0, 0), "Out", "Quad",0.2,true,function()
	                            Toggle.ZIndex = 3
	                            TextLabel.ZIndex = 2
	                            Image.ZIndex = 1
	                            Dropdown1:Destroy()
	                            Main.ClipsDescendants = true
	  							SectionDropDown.ClipsDescendants = true
	                        end)
	                    end)
	                end
	                Dropdown1:TweenSize(UDim2.new(0, 173, 0, table.getn(array) * 24 + 14), "Out", "Quad", 0.2, true)
	            end
	        end
	        Toggle.MouseButton1Click:Connect(
	            function()
	                if not Toggled then
	                    down:Play()
	                    CreateDropDown(List)
	                else
	                    if Dropdown:FindFirstChild("DropDown") then
	                        up:Play()
	                        Toggled = false
	                        TextLabel.TextColor3 = WindowInst.TextColor
	                        TextLabel.Text = old
	                        Dropdown:FindFirstChild("DropDown"):TweenSize(UDim2.new(0, 173, 0, 0),"Out","Quad",0.2,true,function()
	                            Toggle.ZIndex = 3
	                            TextLabel.ZIndex = 2
	                            Image.ZIndex = 1
	                            Dropdown:FindFirstChild("DropDown"):Destroy()
	                        end)
	                    end
	                end
	            end
	        )
	        game:GetService("UserInputService").WindowFocusReleased:Connect(function()
	                if Dropdown:FindFirstChild("DropDown") then
	                    up:Play()
	                    Toggled = false
	                    TextLabel.TextColor3 = WindowInst.TextColor
	                    TextLabel.Text = old
	                    Dropdown:FindFirstChild("DropDown"):TweenSize( UDim2.new(0, 173, 0, 0), "Out", "Quad", 0.2, true, function()
	                        Toggle.ZIndex = 3
	                        TextLabel.ZIndex = 2
	                        Image.ZIndex = 1
	                        Dropdown:FindFirstChild("DropDown"):Destroy()
	   	        		end)
	                end
	        end)
	        return {
	            Refresh = function(self, array)
	                List = array
	                TextLabel.TextColor3 = WindowInst.TextColor
	                TextLabel.Text = tostring(array[1])
	                if flag ~= "" then
	                    WindowInst.flags[flag] = tostring(array[1])
	                end
	                up:Play()
	                Toggled = false
	                if Dropdown:FindFirstChild("DropDown") then
	                    Dropdown:FindFirstChild("DropDown"):TweenSize(UDim2.new(0, 173, 0, 0), "Out", "Quad", 0.2, true, function()
	                        Toggle.ZIndex = 3
	                        TextLabel.ZIndex = 2
	                        Image.ZIndex = 1
	                        Dropdown:FindFirstChild("DropDown"):Destroy()
	                	end)
	                end
	            end
	        }
	    end
		
		function SectionInst:Section(...)
			local args = {...}
			local name = args[1] or "Section"
			local Section = Instance.new("Frame")
			local TextLabel = Instance.new("TextLabel")
			
			Section.Name = "Section"
			Section.Parent = SectionDropDown
			Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Section.BackgroundTransparency = 1.000
			Section.Size = UDim2.new(1, 0, 0, 28)
			
			TextLabel.Parent = Section
			TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel.BackgroundColor3 = WindowInst.SectionColor
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			TextLabel.Size = UDim2.new(1, 0, 0, 24)
			TextLabel.Font = Enum.Font.SourceSans
			TextLabel.Text = name
			TextLabel.TextColor3 = WindowInst.TextColor
			TextLabel.TextSize = 16.000
			return{
				Set = function(self, value)
					TextLabel.Text = value
				end
			}
		end
		
		function SectionInst:Box(...)
			local args = {...}
			local name = args[1] or "Box"
	        local callback = args[3] or function() end
	        local type = args[2].type or "string"
	        local default = args[2].default or ""
	        local flag = args[2].flag or ""
	        local placeholder = args[2].placeholder or ""
	        local min = args[2].min or 0
	        local max = args[2].max or 9e9
	 
	        if type == "number" and not tonumber(default) then
	            default = "0"
	        end
	        if flag ~= "" then
	            WindowInst.flags[flag] = default
	        end
	 
	        local Box = Instance.new("Frame")
	        local Tttle = Instance.new("TextLabel")
	        local Box_2 = Instance.new("TextBox")
	 
	        Box.Name = "Box"
	        Box.Parent = SectionDropDown
	        Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        Box.BackgroundTransparency = 1.000
	        Box.BorderSizePixel = 0
	        Box.Size = UDim2.new(1, 0, 0, 25)
	 
	        Tttle.Name = "Tttle"
	        Tttle.Parent = Box
	        Tttle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        Tttle.BackgroundTransparency = 1.000
	        Tttle.BorderSizePixel = 0
	        Tttle.Position = UDim2.new(0.0331491861, 0, 0, 0)
	        Tttle.Size = UDim2.new(0, 129, 0, 25)
	        Tttle.Font = Enum.Font.SourceSans
	        Tttle.Text = name
	        Tttle.TextColor3 = WindowInst.TextColor
	        Tttle.TextSize = 16.000
	        Tttle.TextWrapped = true
	        Tttle.TextXAlignment = Enum.TextXAlignment.Left
	 
	        Box_2.Name = "Box"
	        Box_2.Parent = Box
	        Box_2.AnchorPoint = Vector2.new(1, 0.5)
	        Box_2.BackgroundColor3 = WindowInst.ThirdColor
	        Box_2.BorderSizePixel = 0
	        Box_2.Position = UDim2.new(0.980000019, 0, 0.5, 0)
	        Box_2.Size = UDim2.new(0, 60, 0, 21)
	        Box_2.ZIndex = 2
	        Box_2.Font = Enum.Font.SourceSans
	        Box_2.Text = default
	        Box_2.PlaceholderText = placeholder
	        Box_2.TextColor3 = WindowInst.TextColor
	        Box_2.TextSize = 16.000
	        Box_2.TextWrapped = true
	 
	        local old = Box_2.Text
	        function PositiveIntegerMask(text)
	            return text:gsub("[^%-%d]", "")
	        end
	        Box_2:GetPropertyChangedSignal("Text"):Connect(
	            function()
	                if (type == "number") then
	                    Box_2.Text = PositiveIntegerMask(Box_2.Text)
	                end
	            end
	        )
	 
	        Box_2.FocusLost:connect(
	            function(enterPressed)
	                if type == "number" then
	                    if not tostring(Box_2.Text) then
	                        Box_2.Text = tostring(0)
	                    end
	                    if old == "" then
	                        old = tostring(0)
	                    end
	                    if Box_2.Text == "" then
	                        Box_2.Text = tostring(0)
	                    end
	                    if (tonumber(Box_2.Text) > max) then
	                        Box_2.Text = tostring(max)
	                    end
	                    if (tonumber(Box_2.Text) < min) then
	                        Box_2.Text = tostring(min)
	                    end
	                    if flag ~= "" then
	                        WindowInst.flags[flag] = tonumber(Box_2.Text)
	                    end
	                    pcall(callback, Box_2, tonumber(Box_2.Text), tonumber(old), enterPressed)
	                else
	                    if flag ~= "" then
	                        WindowInst.flags[flag] = Box_2.Text
	                    end
	                    pcall(callback, Box_2, Box_2.Text, old, enterPressed)
	                end
	                old = Box_2.Text
	            end
	        )
	        return {
	            Set = function(self, value)
	                if type == "number" then
	                    Box_2.Text = tostring(value)
	                    if flag ~= "" then
	                        WindowInst.flags[flag] = tonumber(Box_2.Text)
	                    end
	                    pcall(callback, Box_2, tonumber(Box_2.Text), tonumber(old), true)
	                else
	                    Box_2.Text = tostring(value)
	                    if flag ~= "" then
	                        WindowInst.flags[flag] = Box_2.Text
	                    end
	                    pcall(callback, Box_2, Box_2.Text, old, true)
	                end
	            end
	        }
	    end
		
		function SectionInst:Label(...)
			local args = {...}
			local name = args[1] or "Label"
			local Label = Instance.new("TextLabel")
	
			Label.Name = "Label"
			Label.Parent = SectionDropDown
			Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Label.BackgroundTransparency = 1.000
			Label.Size = UDim2.new(1, 0, 0, 28)
			Label.Font = Enum.Font.SourceSans
			Label.TextColor3 = WindowInst.TextColor
			Label.TextSize = 16.000
			Label.Text = name
			
			return{
				Set = function(self, value)
					Label.Text = value
				end
			}
		end
		
		function SectionInst:Button(...)
			local args = {...}
			local name = args[1] or "Button"
			local callback = args[2] or function() end
	
			local Button = Instance.new("Frame")
			local TextButton = Instance.new("TextButton")
			
			Button.Name = "Button"
			Button.Parent = SectionDropDown
			Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button.BackgroundTransparency = 1.000
			Button.BorderSizePixel = 0
			Button.Position = UDim2.new(0, 0, 0.00858369097, 0)
			Button.Size = UDim2.new(1, 0, 0, 28)
			
			TextButton.Parent = Button
			TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
			TextButton.BackgroundColor3 = WindowInst.SecondColor
			TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
			TextButton.BorderSizePixel = 0
			TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
			TextButton.Size = UDim2.new(0.959999979, 0, 0, 22)
			TextButton.Font = Enum.Font.SourceSans
			TextButton.TextColor3 = WindowInst.TextColor
			TextButton.TextSize = 16.000
			TextButton.Text = name
			
			TextButton.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
			
			return {
				Fire = function(self)
					pcall(callback)
				end
	        }
		end
		function SectionInst:Toggle(...)
			local args = {...}
			local name = args[1] or "Toggle"
			local options = args[2]
			local callback = args[3] or function() end
			local flag = options.flag or ""
			local default = options.default or false
			local Toggled = default or false
			
			local Toggle = Instance.new("Frame")
			local ToggleButton = Instance.new("TextButton")
			local TextLabel = Instance.new("TextLabel")
			
			Toggle.Name = "Toggle"
			Toggle.Parent = SectionDropDown
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.BackgroundTransparency = 1.000
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0, 0, 0.00858369097, 0)
			Toggle.Size = UDim2.new(1, 0, 0, 28)
			
			ToggleButton.Name = "ToggleButton"
			ToggleButton.Parent = Toggle
			ToggleButton.AnchorPoint = Vector2.new(0.5, 0.5)
			ToggleButton.BackgroundColor3 = WindowInst.ThirdColor
			ToggleButton.BorderSizePixel = 0
			ToggleButton.Position = UDim2.new(0.92, 0, 0.5, 0)
			ToggleButton.Size = UDim2.new(0, 21, 0, 21)
			ToggleButton.Font = Enum.Font.SourceSansBold
			ToggleButton.TextColor3 = WindowInst.TextColor
			ToggleButton.TextSize = 20.000
			ToggleButton.Text = Toggled and utf8.char(10003) or ""
			
			TextLabel.Parent = Toggle
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0.0331491861, 0, 0, 0)
			TextLabel.Size = UDim2.new(0, 144, 0, 26)
			TextLabel.Font = Enum.Font.SourceSans
			TextLabel.Text = name
			TextLabel.TextColor3 = WindowInst.TextColor
			TextLabel.TextSize = 16.000
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			ToggleButton.MouseButton1Click:Connect(function()
				Toggled = not Toggled
				WindowInst.flags[flag] = Toggled
				ToggleButton.Text = Toggled and utf8.char(10003) or ""
				pcall(callback, Toggled)
			end)
			
			return {
				Set = function(self, value)
					Toggled = value
					WindowInst.flags[flag] = Toggled
					ToggleButton.Text = Toggled and utf8.char(10003) or ""
					pcall(callback, Toggled)
				end
	        }
		end
		function SectionInst:Slider(...)
			local args = {...}
	        local callback = args[3] or function() end
			local name = args[1]
	        local min = args[2].min or 0
	        local max = args[2].max or 10
	        local default = math.clamp(args[2].default, min, max) or min
	        local step = args[2].step or 1
	        local callonstartup = args[2].callonstartup or false
	        local flag = args[2].flag or ""
	        if flag ~= "" then
	            WindowInst.flags[flag] = default
	        end
	        if callonstartup then
	            pcall(callback, default)
	        end
	 
	        local Slider = Instance.new("Frame")
	        local Title = Instance.new("TextLabel")
	        local Back = Instance.new("Frame")
	        local Fill = Instance.new("Frame")
	        local Handle = Instance.new("TextButton")
	        local Image = Instance.new("ImageLabel")
	        local Amount = Instance.new("TextLabel")
	 
	        Slider.Name = "Slider"
	        Slider.Parent = SectionDropDown
	        Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        Slider.BackgroundTransparency = 1.000
	        Slider.BorderSizePixel = 0
	        Slider.Size = UDim2.new(1, 0, 0, 25)
	 
	        Title.Name = "Title"
	        Title.Parent = Slider
	        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        Title.BackgroundTransparency = 1.000
	        Title.BorderSizePixel = 0
	        Title.Position = UDim2.new(0.0399999991, 0, 0, 0)
	        Title.Size = UDim2.new(0, 129, 0, 13)
	        Title.Font = Enum.Font.SourceSans
	        Title.Text = name
	        Title.TextColor3 = WindowInst.TextColor
	        Title.TextSize = 15.000
	        Title.TextWrapped = true
	        Title.TextXAlignment = Enum.TextXAlignment.Left
	 
	        Back.Name = "Back"
	        Back.Parent = Slider
	        Back.AnchorPoint = Vector2.new(0.5, 0.5)
	        Back.Position = UDim2.new(0.504999995, 0, 0.779999971, 0)
	        Back.Size = UDim2.new(0, 165, 0, 4)
	        Back.BackgroundColor3 = WindowInst.ThirdColor
			Back.BorderSizePixel = 0
	 
	        Fill.Name = "Fill"
	        Fill.Parent = Back
	        Fill.Position = UDim2.new(0.00281458977, 0, 0, 0)
	        Fill.Size = UDim2.new((1 - ((max - default) / (max - min))), 0, 1, 0)
	        Fill.BackgroundColor3 = WindowInst.AccentColor
			Fill.BorderSizePixel = 0
	
	        Handle.Name = "Handle"
	        Handle.Parent = Fill
	        Handle.AnchorPoint = Vector2.new(0.5, 0.5)
	        Handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        Handle.BackgroundTransparency = 1.000
	        Handle.BorderSizePixel = 0
	        Handle.Position = UDim2.new(1, 0, 0.5, 0)
	        Handle.Size = UDim2.new(0, 9, 0, 9)
	        Handle.ZIndex = 2
	        Handle.Font = Enum.Font.SourceSans
	        Handle.Text = ""
	        Handle.TextColor3 = Color3.fromRGB(0, 0, 0)
	        Handle.TextSize = 14.000
	 
	        Image.Name = "Image"
	        Image.Parent = Handle
	        Image.Active = true
	        Image.AnchorPoint = Vector2.new(0.5, 0.5)
	        Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        Image.BackgroundTransparency = 1.000
	        Image.Position = UDim2.new(0.5, 0, 0.5, 0)
	        Image.Selectable = true
	        Image.Size = UDim2.new(1, 0, 1, 0)
	        Image.Image = "rbxassetid://3570695787"
	        Image.ScaleType = Enum.ScaleType.Fit
	        Image.SliceCenter = Rect.new(100, 100, 100, 100)
	        Image.SliceScale = 0.075
	 
	        Amount.Name = "Amount"
	        Amount.Parent = Slider
	        Amount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	        Amount.BackgroundTransparency = 1.000
	        Amount.BorderSizePixel = 0
	        Amount.Position = UDim2.new(0.730000079, 0, 0, 0)
	        Amount.Size = UDim2.new(0, 40, 0, 19)
	        Amount.Font = Enum.Font.SourceSans
	        Amount.Text = tostring(default)
	        Amount.TextColor3 = WindowInst.TextColor
	        Amount.TextSize = 15.000
	        Amount.TextWrapped = true
	        Amount.TextXAlignment = Enum.TextXAlignment.Right
	        Amount.TextYAlignment = Enum.TextYAlignment.Top
	        local Dragging = false
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
	        Back.InputBegan:Connect(
	            function(input)
	                if input.UserInputType == Enum.UserInputType.MouseButton1 then
	                    coroutine.resume(
	                        coroutine.create(
	                            function()
	                                Dragging = true
	                                local Mouse = game.Players.LocalPlayer:GetMouse()
	                                local Relpos = Vector2.new(Mouse.x, Mouse.y) - Fill.AbsolutePosition
	                                local precentage = Relpos.x / Back.AbsoluteSize.x
	 
	                                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (max - min)), 0, 1, 0)
	                                if step >= 1 then
	                                    Amount.Text =
	                                        string.format(
	                                        "%.0f",
	                                        math.floor((Fill.AbsoluteSize.x / Back.AbsoluteSize.x) * (max - min) + min)
	                                    )
	                                else
	                                    local deccount = GetDecimalPlacesCount(step)
	                                    local decsize = (step >= 1 and 10 or 100)
	                                    Amount.Text =
	                                        string.format(
	                                        "%." .. (decsize == 10 and "1" or "2") .. "f",
	                                        math.floor(((Fill.AbsoluteSize.x / Back.AbsoluteSize.x) * (max - min) + min) *(decsize / (step * decsize))) /(decsize / (step * decsize))
	                                    )
	                                end
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
	                    coroutine.resume(
	                        coroutine.create(
	                            function()
	                                local Mouse = game.Players.LocalPlayer:GetMouse()
	                                local Relpos = Vector2.new(Mouse.x, Mouse.y) - Fill.AbsolutePosition
	                                local precentage = Relpos.x / Back.AbsoluteSize.x
	                                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (max - min)), 0, 1, 0)
	                                if step >= 1 then
	                                    Amount.Text =
	                                        string.format(
	                                        "%.0f",
	                                        math.floor((Fill.AbsoluteSize.x / Back.AbsoluteSize.x) * (max - min) + min)
	                                    )
	                                else
	                                    local deccount = GetDecimalPlacesCount(step)
	                                    local decsize = (step >= 1 and 10 or 100)
	                                    Amount.Text =
	                                        string.format(
	                                        "%." .. (decsize == 10 and "1" or "2") .. "f",
	                                        math.floor(((Fill.AbsoluteSize.x / Back.AbsoluteSize.x) * (max - min) + min) *(decsize / (step * decsize))) /(decsize / (step * decsize))
	                                    )
	                                end
	                            end
	                        )
	                    )
	                end
	            end
	        )
	        game:GetService("UserInputService").WindowFocusReleased:Connect(
	            function()
	                Dragging = false
	            end
	        )
	        Amount:GetPropertyChangedSignal("Text"):Connect(
	            function()
	                if flag ~= "" then
	                    WindowInst.flags[flag] = tonumber(Amount.Text)
	                end
	                pcall(callback, tonumber(Amount.Text))
	            end
	        )
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
	                value = math.clamp(value, min, max)
	                local precentage = value < min and 0 or value > max and 1 or (1 - ((max - value) / (max - min)))
	                Fill.Size = UDim2.new(Snap(math.clamp(precentage, 0, 1), step / (max - min)), 0, 1, 0)
	                if flag ~= "" then
	                    WindowInst.flags[flag] = tonumber(value)
	                end
	                pcall(callback, value)
	            end
	        }
	    end
		return SectionInst
	end
	return WindowInst
end

return Lib
