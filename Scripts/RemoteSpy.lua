function Drag(GuiObject)
	local Dragging=false
	GuiObject.Active=true
	GuiObject.Selectable=true
	local RelitivePos=Vector2.new(0,0)
	GuiObject.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			local MousePos = game:GetService('UserInputService'):GetMouseLocation() - Vector2.new(0, 36)
			RelitivePos=Vector2.new(MousePos.X,MousePos.Y)-GuiObject.AbsolutePosition
			Dragging=true
		end
	end)
	local a
	a = game:GetService('UserInputService').InputChanged:Connect(function(input,gameProcessed)
		if GuiObject == nil then
			a:Disconnect()
		end
		if input.UserInputType==Enum.UserInputType.MouseMovement and Dragging then
			local MousePos = game:GetService('UserInputService'):GetMouseLocation() - Vector2.new(0, 36)
			GuiObject.Parent.AnchorPoint = Vector2.new(0,0)
			GuiObject.Parent:TweenPosition(UDim2.new(0,MousePos.X-RelitivePos.X,0,MousePos.Y-RelitivePos.Y),'Out','Quad',0.2,true)
		end
	end)
	local b
	b = game:GetService('UserInputService').InputEnded:Connect(function(input)
		if GuiObject == nil then
			b:Disconnect()
		end
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			Dragging=false
		end
	end)
end
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("ImageLabel")
local TitleBar = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local Image = Instance.new("ImageLabel")
local List = Instance.new("ImageLabel")
local Container = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local UIPadding = Instance.new("UIPadding")
local RemotePage = Instance.new("Frame")
local Buttons = Instance.new("ImageLabel")
local Copy = Instance.new("ImageButton")
local Middle = Instance.new("ImageLabel")
local TextName = Instance.new("TextLabel")
local UIGridLayout_2 = Instance.new("UIGridLayout")
local UIPadding_2 = Instance.new("UIPadding")
local Decompile = Instance.new("ImageButton")
local Middle_2 = Instance.new("ImageLabel")
local TextName_2 = Instance.new("TextLabel")
local Disable = Instance.new("ImageButton")
local Middle_3 = Instance.new("ImageLabel")
local TextName_3 = Instance.new("TextLabel")
local Exclude = Instance.new("ImageButton")
local Middle_4 = Instance.new("ImageLabel")
local TextName_4 = Instance.new("TextLabel")
local Fire = Instance.new("ImageButton")
local Middle_5 = Instance.new("ImageLabel")
local TextName_5 = Instance.new("TextLabel")
local CodeBlock = Instance.new("ImageLabel")
local Container_2 = Instance.new("ScrollingFrame")
local Lines = Instance.new("TextLabel")
local Codebox = Instance.new("Frame")
local _keywords = Instance.new("TextLabel")
local _globals = Instance.new("TextLabel")
local _strings = Instance.new("TextLabel")
local _numbers = Instance.new("TextLabel")
local _comments = Instance.new("TextLabel")
local _normals = Instance.new("TextLabel")
local Toggles = Instance.new("Frame")
local Spying = Instance.new("ImageButton")
local ImageLabel = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")
local UIPadding_3 = Instance.new("UIPadding")
local ExcludeList = Instance.new("ImageButton")
local ImageLabel_2 = Instance.new("ImageLabel")
local TextLabel_2 = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local DisableList = Instance.new("ImageButton")
local ImageLabel_3 = Instance.new("ImageLabel")
local TextLabel_3 = Instance.new("TextLabel")
local Clear = Instance.new("ImageButton")
local ImageLabel_4 = Instance.new("ImageLabel")
local TextLabel_4 = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.DisplayOrder = 2147483647
ScreenGui.ResetOnSpawn = false

Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Main.BackgroundTransparency = 1.000
Main.ClipsDescendants = true
Main.Selectable = true
Main.Active = true
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 620, 0, 386)
Main.Image = "rbxassetid://3570695787"
Main.ImageColor3 = Color3.fromRGB(37, 37, 37)
Main.ScaleType = Enum.ScaleType.Slice
Main.SliceCenter = Rect.new(100, 100, 100, 100)
Main.SliceScale = 0.040

TitleBar.Parent = Main
TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TitleBar.BackgroundTransparency = 1.000
TitleBar.ClipsDescendants = true
TitleBar.Size = UDim2.new(1, 0, 0, 26)
TitleBar.Image = "rbxassetid://3570695787"
TitleBar.ImageColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.ScaleType = Enum.ScaleType.Slice
TitleBar.SliceCenter = Rect.new(100, 100, 100, 200)
TitleBar.SliceScale = 0.040

Title.Parent = TitleBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 7, 0, 0)
Title.Size = UDim2.new(-0.190476194, 200, 1, 0)
Title.Font = Enum.Font.Gotham
Title.Text = "Remote Spy"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16.000
Title.TextXAlignment = Enum.TextXAlignment.Left

Toggle.Parent = TitleBar
Toggle.AnchorPoint = Vector2.new(1, 0.5)
Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Toggle.BackgroundTransparency = 1.000
Toggle.Position = UDim2.new(1, -3, 0.5, 0)
Toggle.Size = UDim2.new(0, 25, 0, 25)
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = ""
Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
Toggle.TextSize = 14.000

Image.Parent = Toggle
Image.AnchorPoint = Vector2.new(0.5, 0.5)
Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Image.BackgroundTransparency = 1.000
Image.Position = UDim2.new(0.5, 0, 0.5, 0)
Image.Rotation = 90.000
Image.Size = UDim2.new(0.5, 0, 0.5, 0)
Image.Image = "rbxassetid://4918373417"

List.Parent = Main
List.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
List.BackgroundTransparency = 1.000
List.ClipsDescendants = true
List.Position = UDim2.new(0, 6, 0, 58)
List.Size = UDim2.new(0, 180, 1, -64)
List.Image = "rbxassetid://3570695787"
List.ImageColor3 = Color3.fromRGB(32, 32, 32)
List.ScaleType = Enum.ScaleType.Slice
List.SliceCenter = Rect.new(100, 100, 100, 100)
List.SliceScale = 0.040

Container.Parent = List
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.BackgroundTransparency = 1.000
Container.BorderSizePixel = 0
Container.Size = UDim2.new(1, 0, 1, 0)
Container.ScrollBarImageColor3 = Color3.new(97, 97, 97)
Container.ScrollBarThickness = 4
Container.CanvasSize = UDim2.new(0,0,0,0)

UIGridLayout.Parent = Container
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 4)
UIGridLayout.CellSize = UDim2.new(1, -6, 0, 23)

UIPadding.Parent = Container
UIPadding.PaddingLeft = UDim.new(0, 3)
UIPadding.PaddingTop = UDim.new(0, 3)

RemotePage.Parent = Main
RemotePage.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RemotePage.BackgroundTransparency = 1.000
RemotePage.ClipsDescendants = true
RemotePage.Position = UDim2.new(0, 193, 0, 58)
RemotePage.Size = UDim2.new(1, -200, 1, -64)

Buttons.Parent = RemotePage
Buttons.AnchorPoint = Vector2.new(0, 1)
Buttons.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Buttons.BackgroundTransparency = 1.000
Buttons.Position = UDim2.new(0, 0, 1, 0)
Buttons.Size = UDim2.new(1, 0, 0, 65)
Buttons.Image = "rbxassetid://3570695787"
Buttons.ImageColor3 = Color3.fromRGB(32, 32, 32)
Buttons.ScaleType = Enum.ScaleType.Slice
Buttons.SliceCenter = Rect.new(100, 100, 100, 100)
Buttons.SliceScale = 0.040

Copy.Parent = Buttons
Copy.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Copy.BackgroundTransparency = 1.000
Copy.Position = UDim2.new(0.0295105707, 0, 0.903088927, 0)
Copy.Size = UDim2.new(0, 112, 0, 27)
Copy.Image = "rbxassetid://3570695787"
Copy.ImageColor3 = Color3.fromRGB(99, 99, 99)
Copy.ScaleType = Enum.ScaleType.Slice
Copy.SliceCenter = Rect.new(100, 100, 100, 100)
Copy.SliceScale = 0.040

Middle.Parent = Copy
Middle.AnchorPoint = Vector2.new(0.5, 0.5)
Middle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Middle.BackgroundTransparency = 1.000
Middle.Position = UDim2.new(0.5, 0, 0.5, 0)
Middle.Size = UDim2.new(1, -2, 1, -2)
Middle.Image = "rbxassetid://3570695787"
Middle.ImageColor3 = Color3.fromRGB(45, 45, 45)
Middle.ScaleType = Enum.ScaleType.Slice
Middle.SliceCenter = Rect.new(100, 100, 100, 100)
Middle.SliceScale = 0.040

TextName.Parent = Copy
TextName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextName.BackgroundTransparency = 1.000
TextName.Size = UDim2.new(0.991071582, 0, 1, 0)
TextName.Font = Enum.Font.Gotham
TextName.Text = "Copy"
TextName.TextColor3 = Color3.fromRGB(255, 255, 255)
TextName.TextSize = 18.000

UIGridLayout_2.Parent = Buttons
UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout_2.CellSize = UDim2.new(0.333, -4, 0, 25)

UIPadding_2.Parent = Buttons
UIPadding_2.PaddingBottom = UDim.new(0, 5)
UIPadding_2.PaddingLeft = UDim.new(0, 4)
UIPadding_2.PaddingRight = UDim.new(0, 4)
UIPadding_2.PaddingTop = UDim.new(0, 5)

Decompile.Parent = Buttons
Decompile.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Decompile.BackgroundTransparency = 1.000
Decompile.Position = UDim2.new(0.0295105707, 0, 0.903088927, 0)
Decompile.Size = UDim2.new(0, 112, 0, 27)
Decompile.Image = "rbxassetid://3570695787"
Decompile.ImageColor3 = Color3.fromRGB(99, 99, 99)
Decompile.ScaleType = Enum.ScaleType.Slice
Decompile.SliceCenter = Rect.new(100, 100, 100, 100)
Decompile.SliceScale = 0.040

Middle_2.Parent = Decompile
Middle_2.AnchorPoint = Vector2.new(0.5, 0.5)
Middle_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Middle_2.BackgroundTransparency = 1.000
Middle_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Middle_2.Size = UDim2.new(1, -2, 1, -2)
Middle_2.Image = "rbxassetid://3570695787"
Middle_2.ImageColor3 = Color3.fromRGB(45, 45, 45)
Middle_2.ScaleType = Enum.ScaleType.Slice
Middle_2.SliceCenter = Rect.new(100, 100, 100, 100)
Middle_2.SliceScale = 0.040

TextName_2.Parent = Decompile
TextName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextName_2.BackgroundTransparency = 1.000
TextName_2.Size = UDim2.new(0.991071582, 0, 1, 0)
TextName_2.Font = Enum.Font.Gotham
TextName_2.Text = "Decompile"
TextName_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextName_2.TextSize = 18.000

Disable.Parent = Buttons
Disable.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Disable.BackgroundTransparency = 1.000
Disable.Position = UDim2.new(0.0295105707, 0, 0.903088927, 0)
Disable.Size = UDim2.new(0, 112, 0, 27)
Disable.Image = "rbxassetid://3570695787"
Disable.ImageColor3 = Color3.fromRGB(99, 99, 99)
Disable.ScaleType = Enum.ScaleType.Slice
Disable.SliceCenter = Rect.new(100, 100, 100, 100)
Disable.SliceScale = 0.040

Middle_3.Parent = Disable
Middle_3.AnchorPoint = Vector2.new(0.5, 0.5)
Middle_3.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Middle_3.BackgroundTransparency = 1.000
Middle_3.Position = UDim2.new(0.5, 0, 0.5, 0)
Middle_3.Size = UDim2.new(1, -2, 1, -2)
Middle_3.Image = "rbxassetid://3570695787"
Middle_3.ImageColor3 = Color3.fromRGB(45, 45, 45)
Middle_3.ScaleType = Enum.ScaleType.Slice
Middle_3.SliceCenter = Rect.new(100, 100, 100, 100)
Middle_3.SliceScale = 0.040

TextName_3.Parent = Disable
TextName_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextName_3.BackgroundTransparency = 1.000
TextName_3.Size = UDim2.new(0.991071582, 0, 1, 0)
TextName_3.Font = Enum.Font.Gotham
TextName_3.Text = "Disable"
TextName_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextName_3.TextSize = 18.000

Exclude.Parent = Buttons
Exclude.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Exclude.BackgroundTransparency = 1.000
Exclude.Position = UDim2.new(0.0295105707, 0, 0.903088927, 0)
Exclude.Size = UDim2.new(0, 112, 0, 27)
Exclude.Image = "rbxassetid://3570695787"
Exclude.ImageColor3 = Color3.fromRGB(99, 99, 99)
Exclude.ScaleType = Enum.ScaleType.Slice
Exclude.SliceCenter = Rect.new(100, 100, 100, 100)
Exclude.SliceScale = 0.040

Middle_4.Parent = Exclude
Middle_4.AnchorPoint = Vector2.new(0.5, 0.5)
Middle_4.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Middle_4.BackgroundTransparency = 1.000
Middle_4.Position = UDim2.new(0.5, 0, 0.5, 0)
Middle_4.Size = UDim2.new(1, -2, 1, -2)
Middle_4.Image = "rbxassetid://3570695787"
Middle_4.ImageColor3 = Color3.fromRGB(45, 45, 45)
Middle_4.ScaleType = Enum.ScaleType.Slice
Middle_4.SliceCenter = Rect.new(100, 100, 100, 100)
Middle_4.SliceScale = 0.040

TextName_4.Parent = Exclude
TextName_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextName_4.BackgroundTransparency = 1.000
TextName_4.Size = UDim2.new(0.991071582, 0, 1, 0)
TextName_4.Font = Enum.Font.Gotham
TextName_4.Text = "Exclude"
TextName_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextName_4.TextSize = 18.000

Fire.Parent = Buttons
Fire.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Fire.BackgroundTransparency = 1.000
Fire.Position = UDim2.new(0.0295105707, 0, 0.903088927, 0)
Fire.Size = UDim2.new(0, 112, 0, 27)
Fire.Image = "rbxassetid://3570695787"
Fire.ImageColor3 = Color3.fromRGB(99, 99, 99)
Fire.ScaleType = Enum.ScaleType.Slice
Fire.SliceCenter = Rect.new(100, 100, 100, 100)
Fire.SliceScale = 0.040

Middle_5.Parent = Fire
Middle_5.AnchorPoint = Vector2.new(0.5, 0.5)
Middle_5.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Middle_5.BackgroundTransparency = 1.000
Middle_5.Position = UDim2.new(0.5, 0, 0.5, 0)
Middle_5.Size = UDim2.new(1, -2, 1, -2)
Middle_5.Image = "rbxassetid://3570695787"
Middle_5.ImageColor3 = Color3.fromRGB(45, 45, 45)
Middle_5.ScaleType = Enum.ScaleType.Slice
Middle_5.SliceCenter = Rect.new(100, 100, 100, 100)
Middle_5.SliceScale = 0.040

TextName_5.Parent = Fire
TextName_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextName_5.BackgroundTransparency = 1.000
TextName_5.Size = UDim2.new(0.991071582, 0, 1, 0)
TextName_5.Font = Enum.Font.Gotham
TextName_5.Text = "Fire Remote"
TextName_5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextName_5.TextSize = 18.000

CodeBlock.Parent = RemotePage
CodeBlock.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
CodeBlock.BackgroundTransparency = 1.000
CodeBlock.Size = UDim2.new(1, 0, 1, -70)
CodeBlock.Image = "rbxassetid://3570695787"
CodeBlock.ImageColor3 = Color3.fromRGB(32, 32, 32)
CodeBlock.ScaleType = Enum.ScaleType.Slice
CodeBlock.SliceCenter = Rect.new(100, 100, 100, 100)
CodeBlock.SliceScale = 0.040

Container_2.Parent = CodeBlock
Container_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container_2.BackgroundTransparency = 1.000
Container_2.BorderSizePixel = 0
Container_2.Size = UDim2.new(1, 0, 1, 0)
Container_2.CanvasSize = UDim2.new(0, 0, 0, 0)
Container_2.ScrollBarThickness = 4

Lines.Parent = Container_2
Lines.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Lines.BorderSizePixel = 0
Lines.Size = UDim2.new(0, 20, 1, 0)
Lines.Font = Enum.Font.Code
Lines.Text = "1"
Lines.TextColor3 = Color3.fromRGB(255, 255, 255)
Lines.TextSize = 15.000
Lines.TextYAlignment = Enum.TextYAlignment.Top

Codebox.Parent = Container_2
Codebox.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Codebox.BorderSizePixel = 0
Codebox.Position = UDim2.new(0, 20, 0, 0)
Codebox.Size = UDim2.new(1, -20, 1, 0)

_keywords.Parent = Codebox
_keywords.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_keywords.BackgroundTransparency = 1.000
_keywords.Size = UDim2.new(1, 0, 1, 0)
_keywords.ZIndex = 4
_keywords.Font = Enum.Font.Code
_keywords.Text = ""
_keywords.TextColor3 = Color3.fromRGB(200, 69, 71)
_keywords.TextSize = 15.000
_keywords.TextXAlignment = Enum.TextXAlignment.Left
_keywords.TextYAlignment = Enum.TextYAlignment.Top

_globals.Parent = Codebox
_globals.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_globals.BackgroundTransparency = 1.000
_globals.Size = UDim2.new(1, 0, 1, 0)
_globals.ZIndex = 4
_globals.Font = Enum.Font.Code
_globals.Text = ""
_globals.TextColor3 = Color3.fromRGB(61, 255, 255)
_globals.TextSize = 15.000
_globals.TextXAlignment = Enum.TextXAlignment.Left
_globals.TextYAlignment = Enum.TextYAlignment.Top

_strings.Parent = Codebox
_strings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_strings.BackgroundTransparency = 1.000
_strings.Size = UDim2.new(1, 0, 1, 0)
_strings.ZIndex = 3
_strings.Font = Enum.Font.Code
_strings.Text = ""
_strings.TextColor3 = Color3.fromRGB(150, 255, 142)
_strings.TextSize = 15.000
_strings.TextXAlignment = Enum.TextXAlignment.Left
_strings.TextYAlignment = Enum.TextYAlignment.Top

_numbers.Parent = Codebox
_numbers.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_numbers.BackgroundTransparency = 1.000
_numbers.Size = UDim2.new(1, 0, 1, 0)
_numbers.ZIndex = 2
_numbers.Font = Enum.Font.Code
_numbers.Text = ""
_numbers.TextColor3 = Color3.fromRGB(255, 191, 0)
_numbers.TextSize = 15.000
_numbers.TextXAlignment = Enum.TextXAlignment.Left
_numbers.TextYAlignment = Enum.TextYAlignment.Top

_comments.Parent = Codebox
_comments.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_comments.BackgroundTransparency = 1.000
_comments.Size = UDim2.new(1, 0, 1, 0)
_comments.ZIndex = 5
_comments.Font = Enum.Font.Code
_comments.Text = ""
_comments.TextColor3 = Color3.fromRGB(88, 88, 88)
_comments.TextSize = 15.000
_comments.TextXAlignment = Enum.TextXAlignment.Left
_comments.TextYAlignment = Enum.TextYAlignment.Top

_normals.Parent = Codebox
_normals.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
_normals.BackgroundTransparency = 1.000
_normals.Size = UDim2.new(1, 0, 1, 0)
_normals.Font = Enum.Font.Code
_normals.Text = ""
_normals.TextColor3 = Color3.fromRGB(255, 255, 255)
_normals.TextSize = 15.000
_normals.TextXAlignment = Enum.TextXAlignment.Left
_normals.TextYAlignment = Enum.TextYAlignment.Top

Toggles.Parent = Main
Toggles.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Toggles.BorderSizePixel = 0
Toggles.ClipsDescendants = true
Toggles.Position = UDim2.new(0, 0, 0, 26)
Toggles.Size = UDim2.new(1, 0, 0, 30)

Spying.Parent = Toggles
Spying.BackgroundTransparency = 1.000
Spying.LayoutOrder = 1
Spying.Position = UDim2.new(0.0119760484, 0, 0.17845118, 0)
Spying.Size = UDim2.new(0, 70, 1, 0)
Spying.Image = "rbxassetid://3570695787"
Spying.ImageColor3 = Color3.fromRGB(0, 189, 0)
Spying.ScaleType = Enum.ScaleType.Slice
Spying.SliceCenter = Rect.new(100, 100, 100, 100)
Spying.SliceScale = 0.040

ImageLabel.Parent = Spying
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(1, -2, 1, -2)
ImageLabel.Image = "rbxassetid://3570695787"
ImageLabel.ImageColor3 = Color3.fromRGB(45, 45, 45)
ImageLabel.ScaleType = Enum.ScaleType.Slice
ImageLabel.SliceCenter = Rect.new(100, 100, 100, 100)
ImageLabel.SliceScale = 0.040

TextLabel.Parent = Spying
TextLabel.AnchorPoint = Vector2.new(1, 0)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(1, 0, 0, 0)
TextLabel.Size = UDim2.new(1, 0, 1, -2)
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = "Spying"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 16.000
TextLabel.TextWrapped = true

UIPadding_3.Parent = Toggles
UIPadding_3.PaddingBottom = UDim.new(0, 3)
UIPadding_3.PaddingLeft = UDim.new(0, 7)
UIPadding_3.PaddingRight = UDim.new(0, 7)
UIPadding_3.PaddingTop = UDim.new(0, 3)

ExcludeList.Parent = Toggles
ExcludeList.BackgroundTransparency = 1.000
ExcludeList.LayoutOrder = 3
ExcludeList.Position = UDim2.new(0.0119760484, 0, 0.17845118, 0)
ExcludeList.Size = UDim2.new(0, 105, 1, 0)
ExcludeList.Image = "rbxassetid://3570695787"
ExcludeList.ImageColor3 = Color3.fromRGB(99, 99, 99)
ExcludeList.ScaleType = Enum.ScaleType.Slice
ExcludeList.SliceCenter = Rect.new(100, 100, 100, 100)
ExcludeList.SliceScale = 0.040

ImageLabel_2.Parent = ExcludeList
ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ImageLabel_2.BackgroundTransparency = 1.000
ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel_2.Size = UDim2.new(1, -2, 1, -2)
ImageLabel_2.Image = "rbxassetid://3570695787"
ImageLabel_2.ImageColor3 = Color3.fromRGB(45, 45, 45)
ImageLabel_2.ScaleType = Enum.ScaleType.Slice
ImageLabel_2.SliceCenter = Rect.new(100, 100, 100, 100)
ImageLabel_2.SliceScale = 0.040

TextLabel_2.Parent = ExcludeList
TextLabel_2.AnchorPoint = Vector2.new(1, 0)
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(1, 0, 0, 0)
TextLabel_2.Size = UDim2.new(1, 0, 1, -2)
TextLabel_2.Font = Enum.Font.Gotham
TextLabel_2.Text = "Exclude List"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 16.000
TextLabel_2.TextWrapped = true

UIListLayout.Parent = Toggles
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

DisableList.Parent = Toggles
DisableList.BackgroundTransparency = 1.000
DisableList.LayoutOrder = 4
DisableList.Position = UDim2.new(0.0119760484, 0, 0.17845118, 0)
DisableList.Size = UDim2.new(0, 100, 1, 0)
DisableList.Image = "rbxassetid://3570695787"
DisableList.ImageColor3 = Color3.fromRGB(99, 99, 99)
DisableList.ScaleType = Enum.ScaleType.Slice
DisableList.SliceCenter = Rect.new(100, 100, 100, 100)
DisableList.SliceScale = 0.040

ImageLabel_3.Parent = DisableList
ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel_3.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ImageLabel_3.BackgroundTransparency = 1.000
ImageLabel_3.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel_3.Size = UDim2.new(1, -2, 1, -2)
ImageLabel_3.Image = "rbxassetid://3570695787"
ImageLabel_3.ImageColor3 = Color3.fromRGB(45, 45, 45)
ImageLabel_3.ScaleType = Enum.ScaleType.Slice
ImageLabel_3.SliceCenter = Rect.new(100, 100, 100, 100)
ImageLabel_3.SliceScale = 0.040

TextLabel_3.Parent = DisableList
TextLabel_3.AnchorPoint = Vector2.new(1, 0)
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Position = UDim2.new(1, 0, 0, 0)
TextLabel_3.Size = UDim2.new(1, 0, 1, -2)
TextLabel_3.Font = Enum.Font.Gotham
TextLabel_3.Text = "Disable List"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextSize = 16.000
TextLabel_3.TextWrapped = true

Clear.Parent = Toggles
Clear.BackgroundTransparency = 1.000
Clear.LayoutOrder = 2
Clear.Position = UDim2.new(0.0119760484, 0, 0.17845118, 0)
Clear.Size = UDim2.new(0, 60, 1, 0)
Clear.Image = "rbxassetid://3570695787"
Clear.ImageColor3 = Color3.fromRGB(99, 99, 99)
Clear.ScaleType = Enum.ScaleType.Slice
Clear.SliceCenter = Rect.new(100, 100, 100, 100)
Clear.SliceScale = 0.040

ImageLabel_4.Parent = Clear
ImageLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel_4.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ImageLabel_4.BackgroundTransparency = 1.000
ImageLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel_4.Size = UDim2.new(1, -2, 1, -2)
ImageLabel_4.Image = "rbxassetid://3570695787"
ImageLabel_4.ImageColor3 = Color3.fromRGB(45, 45, 45)
ImageLabel_4.ScaleType = Enum.ScaleType.Slice
ImageLabel_4.SliceCenter = Rect.new(100, 100, 100, 100)
ImageLabel_4.SliceScale = 0.040

TextLabel_4.Parent = Clear
TextLabel_4.AnchorPoint = Vector2.new(1, 0)
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.Position = UDim2.new(1, 0, 0, 0)
TextLabel_4.Size = UDim2.new(1, 0, 1, -2)
TextLabel_4.Font = Enum.Font.Gotham
TextLabel_4.Text = "Clear"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextSize = 16.000
TextLabel_4.TextWrapped = true
Drag(TitleBar)
UIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	Container.CanvasSize = UDim2.new(0,UIGridLayout.AbsoluteContentSize.X,0,UIGridLayout.AbsoluteContentSize.Y+5)
end)
function GetFullName(instance)
	local str = ""
	local current = instance
	while wait() do
		if current == game then
			str="game."..str
			break
		end
		if str~="" then
			str=current.Name.."."..str
		else
			str=current.Name..str
		end
		current = current.Parent
	end
	return str
end
local lua_keywords = {"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}
local global_env = {"getrawmetatable", "game", "workspace", "script", "math", "string", "table", "print", "wait", "BrickColor", "Color3", "next", "pairs", "ipairs", "select", "unpack", "Instance", "Vector2", "Vector3", "CFrame", "Ray", "UDim2", "Enum", "assert", "error", "warn", "tick", "loadstring", "_G", "shared", "getfenv", "setfenv", "newproxy", "setmetatable", "getmetatable", "os", "debug", "pcall", "ypcall", "xpcall", "rawequal", "rawset", "rawget", "tonumber", "tostring", "type", "typeof", "_VERSION", "coroutine", "delay", "require", "spawn", "LoadLibrary", "settings", "stats", "time", "UserSettings", "version", "Axes", "ColorSequence", "Faces", "ColorSequenceKeypoint", "NumberRange", "NumberSequence", "NumberSequenceKeypoint", "gcinfo", "elapsedTime", "collectgarbage", "PhysicalProperties", "Rect", "Region3", "Region3int16", "UDim", "Vector2int16", "Vector3int16"}
local text = ""
local function strings(s)
	if type(s) == "string" then
		local highlight = ""
		local quote1 = false
		local quote2 = false
		local temptext = ""
		s:gsub(".",function(c)
			if not quote1 and c == "\"" then
				quote1 = true
			elseif quote1 and c == "\"" then
				quote1 = false
			elseif not quote2 and c == "'" then
				quote2 = true
			elseif quote2 and c == "'" then
				quote2 = false
			end
			if not quote1 and c == "\"" then
				highlight = highlight..c
				temptext = temptext.." "
			elseif quote2 and c == "'" then
				highlight = highlight..c
				temptext = temptext.." "
			elseif c == "\n" then
				highlight = highlight.."\n"
				temptext = temptext.."\n"
			elseif c == "\t" then
				highlight = highlight.."\t"
				temptext = temptext.."\t"
			elseif quote1 or quote2 then
				highlight = highlight..c
				temptext = temptext.." "
			elseif not quote1 and not quote2 then
				highlight = highlight.." "
				temptext = temptext..c
			end
		end)
		text = temptext
		return highlight
	end	
end
local function numbers(s)
	if type(s) == "string" then
		local highlight = ""
		local temptext = ""
		s:gsub(".", function(c)
			if tonumber(c) ~= nil then
				highlight = highlight..c
				temptext = temptext.." "
			elseif c == "\n" then
				highlight = highlight.."\n"
				temptext = temptext.."\n"
			elseif c == "\t" then
				highlight = highlight.."\t"
				temptext = temptext.."\t"
			else 
				highlight = highlight.." "
				temptext = temptext..c
			end
		end)
		return highlight
	end
end
local function comments(s)
	if type(s) == "string" then
		local highlight = ""
		local i = 0
		local comment = false
		local temptext = ""
		s:gsub(".", function(c)
			i=i+1
			if s:sub(i,i+1)=="--" then
				comment = true
			elseif comment and c=="\n" then
				comment = false
			end
			if comment  then
				highlight = highlight..c
				temptext = temptext..""
			elseif c == "\n" then
				highlight = highlight.."\n"
				temptext = temptext.."\n"
			elseif c == "\t" then
				highlight = highlight.."\t"
				temptext = temptext.."\t"
			else 
				highlight = highlight.." "
				temptext = temptext..c
			end
		end)
		text = temptext
		return highlight
	end
end
local function highlight(s,r)
	if type(s) == "string" and type(r) == "table" then
		local K = {}
		local Tokens =
			{
			["="] = true,
			["."] = true,
			[","] = true,
			["("] = true,
			[")"] = true,
			["["] = true,
			["]"] = true,
			["{"] = true,
			["}"] = true,
			[":"] = true,
			["*"] = true,
			["/"] = true,
			["+"] = true,
			["-"] = true,
			["%"] = true,
			[";"] = true,
			["~"] = true
		}
		for i, v in pairs(r) do
			K[v] = true
		end
		s = s:gsub(".",function(c)
			if Tokens[c] ~= nil then
				return " "
			else
				return c
			end
		end)
		s = s:gsub("%S+", function(w)
			if K[w] ~= nil then
				return w
			else
				return (" "):rep(#w)
			end
		end)
		return s
	end
end
function UpdateText(newtext)
	text = newtext
	text = text:gsub("\13", "")
	text = text:gsub("\9", "    ")
	_comments.Text = comments(text)
	_strings.Text = strings(text)
	_numbers.Text = numbers(text)
	_keywords.Text = highlight(text, lua_keywords)
	_globals.Text = highlight(text, global_env)
	_normals.Text = text
	Lines.Text = ""
	local line = 1
	text:gsub("\n", function()
		line = line + 1
	end)
	Lines.Text = ""
	for i = 1, line do
		Lines.Text = Lines.Text .. i .. "\n"
	end
end
_normals:GetPropertyChangedSignal("TextBounds"):Connect(function()
	Container_2.CanvasSize = UDim2.new(0,_normals.TextBounds.X+50,0,_normals.TextBounds.Y+50)
end)
local Remotes = {
	["RemoteFunction"] = {
		Color = Color3.new(0.792157, 0.396078, 0.792157);
		Icon = "http://www.roblox.com/asset/?id=413369623";
		Invoke = "InvokeServer"
	};
	["RemoteEvent"] = {
		Color = Color3.new(0.831373, 0.788235, 0.176471);
		Icon = "rbxassetid://413369506";
		Invoke = "FireServer"
	};
}
local Enabled = true
local Selected = {
	Remote = nil;
	Args = nil;
	Script = nil;
}
Fire.MouseButton1Click:Connect(function()
	if Selected.Remote and Selected.Remote.ClassName == "RemoteEvent" then
		Selected.Remote:FireServer(unpack(Selected.Args))
	elseif Selected.Remote and Selected.Remote.ClassName == "RemoteFunction" then
		Selected.Remote:InvokeServer(unpack(Selected.Args))
	end
end)
Spying.MouseButton1Click:Connect(function()
	Enabled = not Enabled
	Spying.ImageColor3 = Enabled and Color3.new(0,189,0) or Color3.new(189,0,0)
end)
Clear.MouseButton1Click:Connect(function()
	for i,v in pairs(Container:GetChildren()) do 
		if v:IsA("ImageButton") then
			v:Destroy()
		end
	end
end)
local Excluded = {}
local Disabled = {}
function ConvertToString(val)
	if type(val) == "number" or type(val) == "boolean" then
		return tostring(val)
	elseif type(val) == "string" then
		return "\""..val.."\""
	elseif typeof(val) == 'Axes' then
		
	elseif typeof(val) == 'BrickColor' then
		return "BrickColor.new(Color3.new("..tostring(val.r)..", "..tostring(val.g)..", "..tostring(val.b).."))"
	elseif typeof(val) == 'CFrame' then
		local str = "CFrame.new("
		for i,v in pairs({val:components()}) do
			if i>1 then
				str = str..", "
			end
			str = str..tostring(v)
		end
		str = str..")"
		return str
	elseif typeof(val) == "Color3" then
		return "Color3.new("..tostring(val.r)..", "..tostring(val.g)..", "..tostring(val.b)..")"
	elseif typeof(val) == "ColorSequence" then
		local str = "ColorSequence.new({"
		for i,v in pairs(val.Keypoints) do
			str = str..ConvertToString(v)..";"
		end
		str = str.."})"
		return str
	elseif typeof(val) == "ColorSequenceKeypoint" then
		return "ColorSequenceKeypoint.new("..val.Time..", "..val.Value..")"
	elseif typeof(val) == "DateTime" then
		return "DateTime.fromUnixTimestampMillis("..val.UnixTimestampMillis..")"
	elseif typeof(val) == "EnumItem" then
		return ConvertToString(val.Value)
	elseif typeof(val) == "Enums" then
		return "Enum"
	elseif typeof(val) == "Faces" then
		
	elseif typeof(val) == "Instance" then
		return GetFullName(val)
	end
end
function GenerateScript(Remote,...)
	local Args = {...}
	local String = ""
	local function ArgGen(Args,tabledepth,multiline)
		if tabledepth > 1 then
			String = String.."{ "
			if multiline then
				String = String.."\n"
			end
		elseif tabledepth == 1 then
			String = String.."local args = { "
			if multiline then
				String = String.."\n"
			end
		end
		for i,v in pairs(Args) do
			if multiline then
				for i=1,tabledepth do
					String = String.."    "
				end
			end
			String = String.."["..ConvertToString(i).."] = "
			if type(v) == "table" then
				ArgGen(v,tabledepth+1,multiline)
			else
				String = String..ConvertToString(v)
			end
			String = String.."; "
			if multiline then
				String = String.."\n"
			end
		end
		if multiline then
			for i=1,tabledepth-1 do
				String = String.."    "
			end
		end
		String = String.."} "
	end
	ArgGen(Args,1,true)
	String = String.."\n"..GetFullName(Remote)..":"..Remotes[Remote.ClassName].Invoke.."(unpack(args))"
	print(String)
	return String
end
function RemoteFired(Remote,Script,...)
	local Args = {...}
	local RemoteButton = Instance.new("ImageButton")
	local Middle = Instance.new("ImageLabel")
	local TextName = Instance.new("TextLabel")
	local Icon = Instance.new("ImageLabel")
	
	RemoteButton.Parent = Container
	RemoteButton.BackgroundTransparency = 1.000
	RemoteButton.Position = UDim2.new(0.0119760484, 0, 0.17845118, 0)
	RemoteButton.Size = UDim2.new(0, 140, 0, 238)
	RemoteButton.Image = "rbxassetid://3570695787"
	RemoteButton.ImageColor3 = Remotes[Remote.ClassName].Color
	RemoteButton.ScaleType = Enum.ScaleType.Slice
	RemoteButton.SliceCenter = Rect.new(100, 100, 100, 100)
	RemoteButton.SliceScale = 0.040
	
	Middle.Parent = RemoteButton
	Middle.AnchorPoint = Vector2.new(0.5, 0.5)
	Middle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	Middle.BackgroundTransparency = 1.000
	Middle.Position = UDim2.new(0.5, 0, 0.5, 0)
	Middle.Size = UDim2.new(1, -2, 1, -2)
	Middle.Image = "rbxassetid://3570695787"
	Middle.ImageColor3 = Color3.fromRGB(45, 45, 45)
	Middle.ScaleType = Enum.ScaleType.Slice
	Middle.SliceCenter = Rect.new(100, 100, 100, 100)
	Middle.SliceScale = 0.040
	
	TextName.Parent = RemoteButton
	TextName.AnchorPoint = Vector2.new(1, 0)
	TextName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextName.BackgroundTransparency = 1.000
	TextName.Position = UDim2.new(1, 0, 0, 0)
	TextName.Size = UDim2.new(1, -23, 1, 0)
	TextName.Font = Enum.Font.Gotham
	TextName.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextName.TextSize = 16.000
	TextName.TextWrapped = true
	TextName.TextXAlignment = Enum.TextXAlignment.Left
	TextName.Text = Remote.Name
	
	Icon.Parent = RemoteButton
	Icon.AnchorPoint = Vector2.new(0, 0.5)
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1.000
	Icon.Position = UDim2.new(0, 0, 0.5, 0)
	Icon.Size = UDim2.new(0, 19, 0, 19)
	Icon.Image = Remotes[Remote.ClassName].Icon
	RemoteButton.MouseButton1Click:Connect(function()
		local temp = syn.get_thread_identity()
		syn.set_thread_identity(6)
		CodeBlockText = GenerateScript(Remote,data,unpack(Args))
		UpdateText(CodeBlockText)
		Selected.Remote = Remote
		Selected.Args = Args
		Selected.Script = Script
		syn.set_thread_identity(temp)
	end)
end
Copy.MouseButton1Click:Connect(function()
	setclipboard(CodeBlockText)
end)
Decompile.MouseButton1Click:Connect(function()
	CodeBlockText = decompile(Selected.Script)
	UpdateText(CodeBlockText)
end)
Disable.MouseButton1Click:Connect(function()
	table.insert(Disabled,#Disabled+1,Selected.Remote)
end)
Exclude.MouseButton1Click:Connect(function()
	table.insert(Excluded,#Excluded+1,Selected.Remote)
end)
local checkcaller = is_protosmasher_caller or checkcaller
local getnamecallmethod = get_namecall_method or getnamecallmethod
local newcclosure = protect_function or newcclosure or function(...)
	return ...
end
local GameMt = getrawmetatable(game)
local OldNameCall = GameMt.__namecall;
(make_writeable or setreadonly or set_readonly)(GameMt, false)
GameMt.__namecall = newcclosure(function(Self, ...)
	local NamecallMethod = getnamecallmethod()
	if table.find(Disabled,Self) then
		return nil
	end
	if Remotes[Self.ClassName] and NamecallMethod == Remotes[Self.ClassName].Invoke and not table.find(Excluded,Self) and Enabled then
		local temp = syn.get_thread_identity()
		syn.set_thread_identity(6)
		RemoteFired(Self,getcallingscript(),...)
		syn.set_thread_identity(2)
		return OldNameCall(Self, ...)
	end
	return OldNameCall(Self, ...)
end);
(make_writeable or setreadonly or set_readonly)(GameMt, false)
