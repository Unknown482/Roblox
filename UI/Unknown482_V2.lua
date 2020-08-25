local Library = {
    count = 0,
    Windows = {},
    Toggled = true,
    Color = Color3.fromRGB(0, 250, 0),
    Rainbow = false
}
local ScreenGui = Instance.new("ScreenGui")
if game:GetService("CoreGui") then
    ScreenGui.Parent = game:GetService("CoreGui")
else
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end
ScreenGui.DisplayOrder = 2147483647
ScreenGui.ResetOnSpawn = false

function Drag(GuiObject)
    local Dragging = false
    GuiObject.Active = true
    GuiObject.Selectable = true
    local RelitivePos = Vector2.new(0, 0)
    GuiObject.InputBegan:Connect(
        function(input)
            local Mouse = game.Players.LocalPlayer:GetMouse()
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                RelitivePos = Vector2.new(Mouse.X, Mouse.Y) - GuiObject.AbsolutePosition
                Dragging = true
            end
        end
    )
    game:GetService("UserInputService").InputChanged:Connect(
        function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
                local Mouse = game.Players.LocalPlayer:GetMouse()
                GuiObject:TweenPosition(
                    UDim2.new(0, Mouse.X - RelitivePos.X, 0, Mouse.Y - RelitivePos.Y),
                    "Out",
                    "Quad",
                    0.2,
                    true
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
end

game:GetService("UserInputService").InputBegan:Connect(
    function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.RightControl then
            Library.Toggled = not Library.Toggled
            for i, v in pairs(ScreenGui:GetChildren()) do
                v:TweenPosition(
                    Library.Toggled and UDim2.new(0, (i - 1) * (v.AbsoluteSize.X + 10) + 35, 0, 20) or
                        UDim2.new(-0.5, 0, -0.5, 0),
                    "InOut",
                    "Quad",
                    0.2,
                    true
                )
            end
        end
    end
)
function Library:Destroy()
    for i, v in pairs(Library.Windows) do
        v:Destroy()
    end
    ScreenGui:Destroy()
end
function Library:CreateWindow(name)
    local Window = Instance.new("ImageLabel")
    local WindowInst = {
        onToggle = Instance.new("BindableEvent"),
        window = Window,
        Toggled = false,
        flags = {}
    }
    table.insert(Library.Windows, table.getn(Library.Windows) + 1, WindowInst)
    Library.count = Library.count + 1
    local Title = Instance.new("TextLabel")
    local Colorbar = Instance.new("Frame")
    local Toggle = Instance.new("TextButton")
    local Main = Instance.new("ImageLabel")
    local UIPadding = Instance.new("UIPadding")
    local UIGridLayout = Instance.new("UIGridLayout")
    Drag(Window)
    Window.Name = name
    Window.Parent = ScreenGui
    Window.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Window.BackgroundTransparency = 1.000
    Window.Size = UDim2.new(0, 185, 0, 28)
    Window.ZIndex = 2
    Window.Image = "rbxassetid://3570695787"
    Window.ImageColor3 = Color3.fromRGB(45, 45, 45)
    Window.ScaleType = Enum.ScaleType.Slice
    Window.SliceCenter = Rect.new(100, 100, 100, 100)
    Window.SliceScale = 0.040
    Window.Position = UDim2.new(0, (Library.count - 1) * (Window.AbsoluteSize.X + 10) + 35, 0, 20)

    Title.Name = "Title"
    Title.Parent = Window
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.ZIndex = 2
    Title.Font = Enum.Font.SourceSans
    Title.Text = name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18.000
    Title.TextWrapped = true

    Colorbar.Name = "Colorbar"
    Colorbar.Parent = Window
    Colorbar.AnchorPoint = Vector2.new(1, 1)
    Colorbar.BackgroundColor3 = Library.Color
    Colorbar.BorderSizePixel = 0
    Colorbar.Position = UDim2.new(1, 0, 1, 0)
    Colorbar.Size = UDim2.new(1, 0, 0, 2)
    Colorbar.ZIndex = 2
    coroutine.resume(
        coroutine.create(
            function()
                while Library.Rainbow do
                    wait()
                    Colorbar.BackgroundColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                end
            end
        )
    )
    Toggle.Name = "Toggle"
    Toggle.Parent = Window
    Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.BackgroundTransparency = 1.000
    Toggle.BorderSizePixel = 0
    Toggle.Position = UDim2.new(0.848484814, 0, 0, 0)
    Toggle.Size = UDim2.new(0, 25, 0, 25)
    Toggle.ZIndex = 3
    Toggle.Font = Enum.Font.SourceSans
    Toggle.Text = "▼"
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.TextSize = 20.000
    Toggle.TextWrapped = true

    Main.Name = "Main"
    Main.Parent = Window
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.BackgroundTransparency = 1.000
    Main.ClipsDescendants = true
    Main.Size = UDim2.new(1, 0, 2.17857146, 135)
    Main.Image = "rbxassetid://3570695787"
    Main.ImageColor3 = Color3.fromRGB(55, 55, 55)
    Main.ScaleType = Enum.ScaleType.Slice
    Main.SliceCenter = Rect.new(100, 100, 100, 100)
    Main.SliceScale = 0.040
    Main.ClipsDescendants = true

    UIPadding.Parent = Main
    UIPadding.PaddingTop = UDim.new(0, 30)

    UIGridLayout.Parent = Main
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
    UIGridLayout.CellSize = UDim2.new(1, 0, 0, 27)
    local TweenService = game:GetService "TweenService"
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

    Toggle.MouseButton1Down:Connect(
        function()
            Main.ClipsDescendants = true
            WindowInst.Toggled = not WindowInst.Toggled
            WindowInst.onToggle:Fire(WindowInst.Toggled)
            if not WindowInst.Toggled then
                Main:TweenSize(UDim2.new(0, Window.AbsoluteSize.X, 0, 28), nil, nil, 0.2, true)
                up:Play()
            else
                Main:TweenSize(
                    UDim2.new(0, Window.AbsoluteSize.X, 0, ((#Main:GetChildren() - 2) * 27) + 34),
                    nil,
                    nil,
                    0.2,
                    true
                )
                down:Play()
            end
        end
    )

    local function Resize()
        Main.Size = UDim2.new(0, Window.AbsoluteSize.X, 0, ((#Main:GetChildren() - 2) * 27) + 34)
    end
    Resize()
    function WindowInst:Button(name, callback)
        callback = callback or function()
            end
        local Time = 0.5
        local ButtonFrame = Instance.new("Frame")
        local Button = Instance.new("TextButton")
        local Image = Instance.new("ImageLabel")

        ButtonFrame.Name = "Button"
        ButtonFrame.Parent = Main
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonFrame.BackgroundTransparency = 1.000
        ButtonFrame.BorderSizePixel = 0
        ButtonFrame.NextSelectionRight = Button
        ButtonFrame.Size = UDim2.new(1, 0, 0, 25)

        Button.Name = "Button"
        Button.Parent = ButtonFrame
        Button.AnchorPoint = Vector2.new(0.5, 0.5)
        Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Button.BackgroundTransparency = 1.000
        Button.BorderColor3 = Color3.fromRGB(71, 71, 71)
        Button.BorderSizePixel = 0
        Button.Position = UDim2.new(0.5, 0, 0.5, 0)
        Button.Size = UDim2.new(0, 175, 0, 23)
        Button.ZIndex = 2
        Button.Font = Enum.Font.SourceSans
        Button.Text = name
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 16.000
        Button.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

        Image.Name = "Image"
        Image.Parent = Button
        Image.Active = true
        Image.AnchorPoint = Vector2.new(0.5, 0.5)
        Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Image.BackgroundTransparency = 1.000
        Image.Position = UDim2.new(0.5, 0, 0.5, 0)
        Image.Selectable = true
        Image.Size = UDim2.new(1, 0, 1, 0)
        Image.Image = "rbxassetid://3570695787"
        Image.ImageColor3 = Color3.fromRGB(42, 42, 42)
        Image.ScaleType = Enum.ScaleType.Slice
        Image.SliceCenter = Rect.new(100, 100, 100, 100)
        Image.SliceScale = 0.040
        Button.MouseButton1Down:Connect(
            function()
                coroutine.resume(
                    coroutine.create(
                        function()
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
                            Circle:TweenSizeAndPosition(
                                UDim2.new(0, Size, 0, Size),
                                UDim2.new(0.5, -Size / 2, 0.5, -Size / 2),
                                "Out",
                                "Quad",
                                Time,
                                false,
                                nil
                            )
                            for i = 1, 10 do
                                Circle.ImageTransparency = Circle.ImageTransparency + 0.01
                                wait(Time / 10)
                            end
                            Circle:Destroy()
                        end
                    )
                )
                pcall(callback)
            end
        )
        Resize()
        return {
            Fire = function(self)
                pcall(callback)
            end
        }
    end
    function WindowInst:Toggle(name, options, callback)
        callback = callback or function()
            end
        local Toggled = options.default or false
        local flag = options.flag or ""
        local Time = 0.5
        local Toggle = Instance.new("Frame")

        local Toggle = Instance.new("Frame")
        local ToggleButton = Instance.new("TextButton")
        local Image = Instance.new("ImageLabel")
        local Text = Instance.new("TextLabel")

        Toggle.Name = "Toggle"
        Toggle.Parent = Main
        Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.BackgroundTransparency = 1.000
        Toggle.BorderSizePixel = 0
        Toggle.Size = UDim2.new(1, 0, 0, 25)

        ToggleButton.Name = "ToggleButton"
        ToggleButton.Parent = Toggle
        ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        ToggleButton.BackgroundTransparency = 1.000
        ToggleButton.BorderColor3 = Color3.fromRGB(71, 71, 71)
        ToggleButton.BorderSizePixel = 0
        ToggleButton.Position = UDim2.new(0.980000019, 0, 0.5, 0)
        ToggleButton.Size = UDim2.new(0, 21, 0, 21)
        ToggleButton.ZIndex = 2
        ToggleButton.Font = Enum.Font.SourceSansBold
        ToggleButton.Text = Toggled and utf8.char(10003) or ""
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleButton.TextSize = 18.000
        ToggleButton.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        ToggleButton.TextWrapped = true

        Image.Name = "Image"
        Image.Parent = ToggleButton
        Image.Active = true
        Image.AnchorPoint = Vector2.new(0.5, 0.5)
        Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Image.BackgroundTransparency = 1.000
        Image.Position = UDim2.new(0.5, 0, 0.5, 0)
        Image.Selectable = true
        Image.Size = UDim2.new(1, 0, 1, 0)
        Image.Image = "rbxassetid://3570695787"
        Image.ImageColor3 = Color3.fromRGB(70, 70, 70)
        Image.ScaleType = Enum.ScaleType.Slice
        Image.SliceCenter = Rect.new(100, 100, 100, 100)
        Image.SliceScale = 0.040

        Text.Name = "Text"
        Text.Parent = Toggle
        Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Text.BackgroundTransparency = 1.000
        Text.BorderSizePixel = 0
        Text.Position = UDim2.new(0.0399999991, 0, 0, 0)
        Text.Size = UDim2.new(0, 129, 0, 25)
        Text.Font = Enum.Font.SourceSans
        Text.Text = name
        Text.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text.TextSize = 16.000
        Text.TextWrapped = true
        Text.TextXAlignment = Enum.TextXAlignment.Left
        ToggleButton.MouseButton1Down:Connect(
            function()
                coroutine.resume(
                    coroutine.create(
                        function()
                            Toggled = not Toggled
                            if flag ~= "" then
                                WindowInst.flags[flag] = Toggled
                            end
                            ToggleButton.Text = Toggled and utf8.char(10003) or ""
                            local Circle = Instance.new("ImageLabel")
                            Circle.Name = "Circle"
                            Circle.Parent = ToggleButton
                            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Circle.BackgroundTransparency = 1.000
                            Circle.ZIndex = 100
                            Circle.Image = "rbxassetid://266543268"
                            Circle.ImageTransparency = 0.900
                            local Mouse = game.Players.LocalPlayer:GetMouse()
                            ToggleButton.ClipsDescendants = true
                            local NewX = Mouse.X - Circle.AbsolutePosition.X
                            local NewY = Mouse.Y - Circle.AbsolutePosition.Y
                            Circle.Position = UDim2.new(0, NewX, 0, NewY)
                            local Size = 0
                            if ToggleButton.AbsoluteSize.X > ToggleButton.AbsoluteSize.Y then
                                Size = ToggleButton.AbsoluteSize.X * 1.5
                            elseif ToggleButton.AbsoluteSize.X < ToggleButton.AbsoluteSize.Y then
                                Size = ToggleButton.AbsoluteSize.Y * 1.5
                            elseif ToggleButton.AbsoluteSize.X == ToggleButton.AbsoluteSize.Y then
                                Size = ToggleButton.AbsoluteSize.X * 1.5
                            end
                            Circle:TweenSizeAndPosition(
                                UDim2.new(0, Size, 0, Size),
                                UDim2.new(0.5, -Size / 2, 0.5, -Size / 2),
                                "Out",
                                "Quad",
                                Time,
                                false,
                                nil
                            )
                            for i = 1, 10 do
                                Circle.ImageTransparency = Circle.ImageTransparency + 0.01
                                wait(Time / 10)
                            end
                            Circle:Destroy()
                        end
                    )
                )
                pcall(callback, Toggled)
            end
        )
        Resize()
        return {
            Set = function(self, value)
                Toggled = value
                ToggleButton.Text = Toggled and utf8.char(10003) or ""
                pcall(callback, Toggled)
            end
        }
    end

    function WindowInst:Slider(name, options, callback)
        callback = callback or function()
            end
        local min = options.min or 0
        local max = options.max or 10
        local default = math.clamp(options.default, min, max) or min
        local step = options.step or 1
        local callonstartup = options.callonstartup or false
        local flag = options.flag or ""
        if flag ~= "" then
            WindowInst.flags[flag] = default
        end
        if callonstartup then
            pcall(callback, default)
        end

        local Slider = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local Back = Instance.new("ImageLabel")
        local Fill = Instance.new("ImageLabel")
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
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 15.000
        Title.TextWrapped = true
        Title.TextXAlignment = Enum.TextXAlignment.Left

        Back.Name = "Back"
        Back.Parent = Slider
        Back.AnchorPoint = Vector2.new(0.5, 0.5)
        Back.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Back.BackgroundTransparency = 1.000
        Back.Position = UDim2.new(0.504999995, 0, 0.779999971, 0)
        Back.Size = UDim2.new(0, 165, 0, 4)
        Back.Image = "rbxassetid://3570695787"
        Back.ImageColor3 = Color3.fromRGB(75, 75, 75)
        Back.ScaleType = Enum.ScaleType.Slice
        Back.SliceCenter = Rect.new(100, 100, 100, 100)
        Back.SliceScale = 0.040

        Fill.Name = "Fill"
        Fill.Parent = Back
        Fill.BackgroundColor3 = Color3.fromRGB(22, 166, 0)
        Fill.BackgroundTransparency = 1.000
        Fill.Position = UDim2.new(0.00281458977, 0, 0, 0)
        Fill.Size = UDim2.new((1 - ((max - default) / (max - min))), 0, 1, 0)
        Fill.Image = "rbxassetid://3570695787"
        Fill.ImageColor3 = Library.Color
        Fill.ScaleType = Enum.ScaleType.Slice
        Fill.SliceCenter = Rect.new(100, 100, 100, 100)
        Fill.SliceScale = 0.040
        coroutine.resume(
            coroutine.create(
                function()
                    while Library.Rainbow do
                        wait()
                        Fill.ImageColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                    end
                end
            )
        )
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
        Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
        Amount.TextSize = 15.000
        Amount.TextWrapped = true
        Amount.TextXAlignment = Enum.TextXAlignment.Right
        Amount.TextYAlignment = Enum.TextYAlignment.Top
        Resize()
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
    function WindowInst:Box(name, options, callback)
        callback = callback or function()
            end
        local type = options.type or "string"
        local default = options.default or ""
        local flag = options.flag or ""
        local placeholder = options.placeholder or ""
        local min = options.min or 0
        local max = options.max or 9e9

        if type == "number" and not tonumber(default) then
            default = "0"
        end
        if flag ~= "" then
            WindowInst.flags[flag] = default
        end

        local Box = Instance.new("Frame")
        local Tttle = Instance.new("TextLabel")
        local Box_2 = Instance.new("TextBox")
        local Image = Instance.new("ImageLabel")

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
        Tttle.Position = UDim2.new(0.0399999991, 0, 0, 0)
        Tttle.Size = UDim2.new(0, 129, 0, 25)
        Tttle.Font = Enum.Font.SourceSans
        Tttle.Text = name
        Tttle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tttle.TextSize = 16.000
        Tttle.TextWrapped = true
        Tttle.TextXAlignment = Enum.TextXAlignment.Left

        Box_2.Name = "Box"
        Box_2.Parent = Box
        Box_2.AnchorPoint = Vector2.new(1, 0.5)
        Box_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        Box_2.BackgroundTransparency = 1.000
        Box_2.BorderSizePixel = 0
        Box_2.Position = UDim2.new(0.980000019, 0, 0.5, 0)
        Box_2.Size = UDim2.new(0, 60, 0, 21)
        Box_2.ZIndex = 2
        Box_2.Font = Enum.Font.SourceSans
        Box_2.Text = default
        Box_2.PlaceholderText = placeholder
        Box_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        Box_2.TextSize = 15.000
        Box_2.TextWrapped = true

        Image.Name = "Image"
        Image.Parent = Box_2
        Image.Active = true
        Image.AnchorPoint = Vector2.new(0.5, 0.5)
        Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Image.BackgroundTransparency = 1.000
        Image.Position = UDim2.new(0.5, 0, 0.5, 0)
        Image.Selectable = true
        Image.Size = UDim2.new(1, 0, 1, 0)
        Image.Image = "rbxassetid://3570695787"
        Image.ImageColor3 = Color3.fromRGB(70, 70, 70)
        Image.ScaleType = Enum.ScaleType.Slice
        Image.SliceCenter = Rect.new(100, 100, 100, 100)
        Image.SliceScale = 0.040
        Resize()
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
    function WindowInst:Label(name)
        local Label = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        Label.Name = "Label"
        Label.Parent = Main
        Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Label.BackgroundTransparency = 1.000
        Label.BorderSizePixel = 0
        Label.Size = UDim2.new(1, 0, 0, 25)
        Title.Name = "Title"
        Title.Parent = Label
        Title.AnchorPoint = Vector2.new(0.5, 0.5)
        Title.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
        Title.BackgroundTransparency = 1.000
        Title.BorderSizePixel = 0
        Title.Text = name
        Title.Position = UDim2.new(0.5, 0, 0.5, 0)
        Title.Size = UDim2.new(1, 0, 0, 23)
        Title.Font = Enum.Font.SourceSans
        Title.TextSize = 16
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Resize()
    end
    function WindowInst:Section(name)
        local Label = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        Label.Name = "Label"
        Label.Parent = Main
        Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Label.BackgroundTransparency = 1.000
        Label.BorderSizePixel = 0
        Label.Size = UDim2.new(1, 0, 0, 25)
        Title.Name = "Title"
        Title.Parent = Label
        Title.AnchorPoint = Vector2.new(0.5, 0.5)
        Title.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
        Title.BackgroundTransparency = 0
        Title.BorderSizePixel = 0
        Title.Text = name
        Title.Position = UDim2.new(0.5, 0, 0.5, 0)
        Title.Size = UDim2.new(1, 0, 0, 23)
        Title.Font = Enum.Font.SourceSans
        Title.TextSize = 16
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Resize()
    end
    function WindowInst:Dropdown(name, options, callback)
        local List = options.list or {}
        local flag = options.flag or ""
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
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextSize = 18.000
        Toggle.TextWrapped = true

        TextLabel.Parent = Dropdown
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        TextLabel.Size = UDim2.new(0, 175, 0, 23)
        TextLabel.ZIndex = 2
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.Text = tostring(List[1])
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 16.000
        old = TextLabel.Text

        Image.Name = "Image"
        Image.Parent = TextLabel
        Image.Active = true
        Image.AnchorPoint = Vector2.new(0.5, 0.5)
        Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Image.BackgroundTransparency = 1.000
        Image.Position = UDim2.new(0.5, 0, 0.5, 0)
        Image.Selectable = true
        Image.Size = UDim2.new(1, 0, 1, 0)
        Image.ZIndex = 1
        Image.Image = "rbxassetid://3570695787"
        Image.ImageColor3 = Color3.fromRGB(42, 42, 42)
        Image.ScaleType = Enum.ScaleType.Slice
        Image.SliceCenter = Rect.new(100, 100, 100, 100)
        Image.SliceScale = 0.040
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
        WindowInst.onToggle.Event:Connect(
            function(t)
                if Toggled then
                    up:Play()
                    Toggled = false
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.Text = old
                    if Dropdown:FindFirstChild("DropDown") then
                        Dropdown:FindFirstChild("DropDown"):TweenSize(
                            UDim2.new(0, 175, 0, 0),
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
            Toggle.ZIndex = 7
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
                Dropdown1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Dropdown1.BorderSizePixel = 0
                Dropdown1.ZIndex = 3
                Dropdown1.ClipsDescendants = true
                Dropdown1.Position = UDim2.new(0.5, 0, 0, 12)
                Dropdown1.Size = UDim2.new(0, 175, 0, 0)
                Dropdown1.Visible = true

                ScrollingFrame.Parent = Dropdown1
                ScrollingFrame.Active = true
                ScrollingFrame.AnchorPoint = Vector2.new(0, 1)
                ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ScrollingFrame.BackgroundTransparency = 1.000
                ScrollingFrame.BorderSizePixel = 0
                ScrollingFrame.ZIndex = 3
                ScrollingFrame.Position = UDim2.new(0, 0, 1, 0)
                ScrollingFrame.Size = UDim2.new(0, 175, 0.91, 0)
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
                    Button.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
                    Button.BorderSizePixel = 0
                    Button.Font = Enum.Font.SourceSans
                    Button.Name = tostring(v)
                    Button.Text = tostring(v)
                    Button.ZIndex = 4
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.TextSize = 16.000
                    Button.MouseButton1Down:Connect(
                        function()
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        pcall(callback, Button.Name)
                                    end
                                )
                            )
                            if flag ~= "" then
                                WindowInst.flags[flag] = Button.Name
                            end
                            TextLabel.Text = Button.Name
                            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Toggled = false
                            up:Play()
                            Dropdown1:TweenSize(
                                UDim2.new(0, 175, 0, 0),
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
                Dropdown1:TweenSize(UDim2.new(0, 175, 0, 132), "Out", "Quad", 0.2, true)
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
                Dropdown1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Dropdown1.BorderSizePixel = 0
                Dropdown1.ZIndex = 3
                Dropdown1.ClipsDescendants = true
                Dropdown1.Position = UDim2.new(0.5, 0, 0, 12)
                Dropdown1.Size = UDim2.new(0, 175, 0, 0)

                UIGridLayout.Parent = Dropdown1
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
                UIGridLayout.CellSize = UDim2.new(0, 175, 0, 23)

                UIPadding.Parent = Dropdown1
                UIPadding.PaddingTop = UDim.new(0, 12)
                for i, v in pairs(array) do
                    local Button = Instance.new("TextButton")
                    Button.Parent = Dropdown1
                    Button.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
                    Button.BorderSizePixel = 0
                    Button.Name = tostring(v)
                    Button.Text = tostring(v)
                    Button.ZIndex = 4
                    Button.Font = Enum.Font.SourceSans
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.TextSize = 16.000
                    Button.MouseButton1Down:Connect(
                        function()
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        pcall(callback, Button.Name)
                                    end
                                )
                            )
                            if flag ~= "" then
                                WindowInst.flags[flag] = Button.Name
                            end
                            TextLabel.Text = Button.Name
                            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Toggled = false
                            up:Play()
                            Dropdown1:TweenSize(
                                UDim2.new(0, 175, 0, 0),
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
                Dropdown1:TweenSize(UDim2.new(0, 175, 0, table.getn(array) * 24 + 11), "Out", "Quad", 0.2, true)
            end
        end
        Toggle.MouseButton1Down:Connect(
            function()
                if not Toggled then
                    down:Play()
                    CreateDropDown(List)
                else
                    if Dropdown:FindFirstChild("DropDown") then
                        up:Play()
                        Toggled = false
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.Text = old
                        Dropdown:FindFirstChild("DropDown"):TweenSize(
                            UDim2.new(0, 175, 0, 0),
                            "Out",
                            "Quad",
                            0.2,
                            true,
                            function()
                                Toggle.ZIndex = 3
                                TextLabel.ZIndex = 2
                                Image.ZIndex = 1
                                Dropdown:FindFirstChild("DropDown"):Destroy()
                            end
                        )
                    end
                end
            end
        )
        game:GetService("UserInputService").WindowFocusReleased:Connect(
            function()
                    if Dropdown:FindFirstChild("DropDown") then
                        up:Play()
                        Toggled = false
                        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        TextLabel.Text = old
                        Dropdown:FindFirstChild("DropDown"):TweenSize(
                            UDim2.new(0, 175, 0, 0),
                            "Out",
                            "Quad",
                            0.2,
                            true,
                            function()
                                Toggle.ZIndex = 3
                                TextLabel.ZIndex = 2
                                Image.ZIndex = 1
                                Dropdown:FindFirstChild("DropDown"):Destroy()
                            end
                        )
                    end
            end
        )
        Resize()
        return {
            Refresh = function(self, array)
                List = array
                TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.Text = tostring(array[1])
                if flag ~= "" then
                    WindowInst.flags[flag] = tostring(array[1])
                end
                up:Play()
                Toggled = false
                if Dropdown:FindFirstChild("DropDown") then
                    Dropdown:FindFirstChild("DropDown"):TweenSize(
                        UDim2.new(0, 175, 0, 0),
                        "Out",
                        "Quad",
                        0.2,
                        true,
                        function()
                            Toggle.ZIndex = 3
                            TextLabel.ZIndex = 2
                            Image.ZIndex = 1
                            Dropdown:FindFirstChild("DropDown"):Destroy()
                        end
                    )
                end
            end
        }
    end
    function WindowInst:SearchBox(name, options, callback)
        local List = options.list or {}
        local flag = options.flag or ""
        local old = tostring(List[1])
        local Searching = false
        if flag ~= "" then
            WindowInst.flags[flag] = tostring(List[1])
        end
        local SearchBox = Instance.new("Frame")
        local TextBox = Instance.new("TextBox")
        local Image = Instance.new("ImageLabel")

        SearchBox.Name = "SearchBox"
        SearchBox.Parent = Main
        SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SearchBox.BackgroundTransparency = 1.000
        SearchBox.BorderSizePixel = 0
        SearchBox.Size = UDim2.new(1, 0, 0, 25)

        TextBox.Parent = SearchBox
        TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
        TextBox.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
        TextBox.BackgroundTransparency = 1.000
        TextBox.BorderSizePixel = 0
        TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
        TextBox.Size = UDim2.new(0, 175, 0, 23)
        TextBox.ZIndex = 2
        TextBox.Font = Enum.Font.SourceSans
        TextBox.Text = tostring(List[1])
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.TextSize = 16.000
        TextBox.PlaceholderText = name

        Image.Name = "Image"
        Image.Parent = TextBox
        Image.Active = true
        Image.AnchorPoint = Vector2.new(0.5, 0.5)
        Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Image.BackgroundTransparency = 1.000
        Image.Position = UDim2.new(0.5, 0, 0.5, 0)
        Image.Selectable = true
        Image.ZIndex = 1
        Image.Size = UDim2.new(1, 0, 1, 0)
        Image.Image = "rbxassetid://3570695787"
        Image.ImageColor3 = Color3.fromRGB(42, 42, 42)
        Image.ScaleType = Enum.ScaleType.Slice
        Image.SliceCenter = Rect.new(100, 100, 100, 100)
        Image.SliceScale = 0.040
        WindowInst.onToggle.Event:Connect(
            function(t)
                if Searching then
                    up:Play()
                    Searching = false
                    TextBox.Text = old
                    if SearchBox:FindFirstChild("DropDown") then
                        SearchBox:FindFirstChild("DropDown"):TweenSize(
                            UDim2.new(0, 175, 0, 0),
                            "Out",
                            "Quad",
                            0.2,
                            true,
                            function()
                                SearchBox:FindFirstChild("DropDown"):Destroy()
                            end
                        )
                    end
                end
            end
        )
        local function CreateDropDown(array, shouldtween)
            Searching = true
            Main.ClipsDescendants = false
            TextBox.ZIndex = 7
            Image.ZIndex = 6
            for i, v in pairs(SearchBox:GetChildren()) do
                if v.Name == "DropDown" then
                    v:Destroy()
                end
            end
            if table.getn(array) > 5 then
                local Dropdown1 = Instance.new("Frame")
                local ScrollingFrame = Instance.new("ScrollingFrame")
                local UIGridLayout = Instance.new("UIGridLayout")
                local TextButton = Instance.new("TextButton")

                Dropdown1.Name = "DropDown"
                Dropdown1.Parent = SearchBox
                Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
                Dropdown1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Dropdown1.BorderSizePixel = 0
                Dropdown1.ZIndex = 3
                Dropdown1.ClipsDescendants = true
                Dropdown1.Position = UDim2.new(0.5, 0, 0, 12)
                Dropdown1.Size = UDim2.new(0, 175, 0, 0)
                if shouldtween then
                    Dropdown1.Size = UDim2.new(0, 175, 0, 0)
                else
                    Dropdown1.Size = UDim2.new(0, 175, 0, 132)
                end
                Dropdown1.Visible = true

                ScrollingFrame.Parent = Dropdown1
                ScrollingFrame.Active = true
                ScrollingFrame.AnchorPoint = Vector2.new(0, 1)
                ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ScrollingFrame.BackgroundTransparency = 1.000
                ScrollingFrame.BorderSizePixel = 0
                ScrollingFrame.ZIndex = 3
                ScrollingFrame.Position = UDim2.new(0, 0, 1, 0)
                ScrollingFrame.Size = UDim2.new(0, 175, 0.91, 0)
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
                    Button.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
                    Button.BorderSizePixel = 0
                    Button.Name = tostring(v)
                    Button.Text = tostring(v)
                    Button.ZIndex = 4
                    Button.Font = Enum.Font.SourceSans
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.TextSize = 16.000
                    Button.MouseButton1Down:Connect(
                        function()
                            Searching = false
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        pcall(callback, Button.Name)
                                    end
                                )
                            )
                            if flag ~= "" then
                                WindowInst.flags[flag] = Button.Name
                            end
                            TextBox.ZIndex = 2
                            Image.ZIndex = 1
                            TextBox.Text = Button.Name
                            old = Button.Name
                            Dropdown1:TweenSize(
                                UDim2.new(0, 175, 0, 0),
                                "Out",
                                "Quad",
                                0.2,
                                true,
                                function()
                                    Dropdown1:Destroy()
                                    Main.ClipsDescendants = true
                                end
                            )
                        end
                    )
                end
                if shouldtween then
                    Dropdown1:TweenSize(UDim2.new(0, 175, 0, 132), "Out", "Quad", 0.2, true)
                end
            else
                local Dropdown1 = Instance.new("Frame")
                local UIGridLayout = Instance.new("UIGridLayout")
                local UIPadding = Instance.new("UIPadding")

                Dropdown1.Name = "DropDown"
                Dropdown1.Parent = SearchBox
                Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
                Dropdown1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Dropdown1.BorderSizePixel = 0
                Dropdown1.ZIndex = 3
                Dropdown1.ClipsDescendants = true
                Dropdown1.Position = UDim2.new(0.5, 0, 0, 12)
                if shouldtween then
                    Dropdown1.Size = UDim2.new(0, 175, 0, 0)
                else
                    Dropdown1.Size = UDim2.new(0, 175, 0, table.getn(array) * 24 + 11)
                end

                UIGridLayout.Parent = Dropdown1
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 1)
                UIGridLayout.CellSize = UDim2.new(0, 175, 0, 23)

                UIPadding.Parent = Dropdown1
                UIPadding.PaddingTop = UDim.new(0, 12)
                for i, v in pairs(array) do
                    local Button = Instance.new("TextButton")
                    Button.Parent = Dropdown1
                    Button.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
                    Button.BorderSizePixel = 0
                    Button.Name = tostring(v)
                    Button.Text = tostring(v)
                    Button.ZIndex = 5
                    Button.Font = Enum.Font.SourceSans
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.TextSize = 16.000
                    Button.MouseButton1Down:Connect(
                        function()
                            Searching = false
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        pcall(callback, Button.Name)
                                    end
                                )
                            )
                            if flag ~= "" then
                                WindowInst.flags[flag] = Button.Name
                            end
                            TextBox.ZIndex = 2
                            Image.ZIndex = 1
                            TextBox.Text = Button.Name
                            old = Button.Name
                            Dropdown1:TweenSize(
                                UDim2.new(0, 175, 0, 0),
                                "Out",
                                "Quad",
                                0.2,
                                true,
                                function()
                                    Dropdown1:Destroy()
                                    Main.ClipsDescendants = true
                                end
                            )
                        end
                    )
                end
                if shouldtween then
                    Dropdown1:TweenSize(UDim2.new(0, 175, 0, table.getn(array) * 24 + 11), "Out", "Quad", 0.2, true)
                end
            end
        end
        TextBox.FocusLost:Connect(
            function(enterpessed, button)
                wait()
                wait()
                if Searching and SearchBox:FindFirstChild("DropDown") then
                    TextBox.Text = old
                    SearchBox:FindFirstChild("DropDown"):TweenSize(
                        UDim2.new(0, 175, 0, 0),
                        "Out",
                        "Quad",
                        0.2,
                        true,
                        function()
                            SearchBox:FindFirstChild("DropDown"):Destroy()
                        end
                    )
                end
            end
        )
        TextBox.Focused:Connect(
            function()
                CreateDropDown(List, true)
                TextBox:GetPropertyChangedSignal("Text"):Connect(
                    function()
                        local newlist = {}
                        for i, v in pairs(List) do
                            if
                                string.match(string.lower(tostring(v)), string.lower(TextBox.Text)) and
                                    TextBox.Text ~= ""
                             then
                                table.insert(newlist, table.getn(newlist) + 1, v)
                            end
                        end
                        CreateDropDown(TextBox.Text == "" and List or newlist, false)
                    end
                )
            end
        )
        Resize()
        return {
            Refresh = function(self, array)
                List = array
                if Searching and SearchBox:FindFirstChild("DropDown") then
                    TextBox.Text = old
                    SearchBox:FindFirstChild("DropDown"):TweenSize(
                        UDim2.new(0, 175, 0, 0),
                        "Out",
                        "Quad",
                        0.2,
                        true,
                        function()
                            SearchBox:FindFirstChild("DropDown"):Destroy()
                        end
                    )
                end
            end
        }
    end
    function WindowInst:Destroy()
        for i, v in pairs(WindowInst.flags) do
            v = nil
        end
        Window:Destroy()
    end
    return WindowInst
end

return Library
