local Library = {toggled = true; count = 0; MousePos = game:GetService('UserInputService'):GetMouseLocation() - Vector2.new(0, 36); Windows = {}}
local TweenService = game:GetService('TweenService')
local ScreenGui = Instance.new('ScreenGui')
function Drag(GuiObject)
local Dragging=false
GuiObject.Active=true
GuiObject.Selectable=true
local RelitivePos=Vector2.new(0,0)
GuiObject.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
RelitivePos=Vector2.new(Library.MousePos.X,Library.MousePos.Y)-GuiObject.AbsolutePosition
Dragging=true
end
end)
local a
a = game:GetService('UserInputService').InputChanged:Connect(function(input,gameProcessed)
if GuiObject == nil then
a:Disconnect()
end
if input.UserInputType==Enum.UserInputType.MouseMovement and Dragging then
GuiObject.Parent:TweenPosition(UDim2.new(0,Library.MousePos.X-RelitivePos.X,0,Library.MousePos.Y-RelitivePos.Y),'Out','Quad',0.2,true)
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
ScreenGui.Parent = get_hidden_gui and get_hidden_gui() or game:GetService('CoreGui')
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647

game:GetService('UserInputService').InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.RightControl then
        Library.toggled = not Library.toggled
        for i, v in ipairs(ScreenGui:GetChildren()) do
			v:TweenPosition(Library.toggled and UDim2.new(0,20+((i - 1)*(v.AbsoluteSize.X + 10)),0,20) 
				or UDim2.new(-0.5, 0, -0.5, 0),'InOut','Quad',0.2,true)
        end
    end
end)

local function MouseOver(GuiObject)
	local Size = GuiObject.AbsoluteSize
	local Pos = GuiObject.AbsolutePosition
	return (Library.MousePos.X >= Pos.X) and (Library.MousePos.Y >= Pos.Y) and (Library.MousePos.X <= (Pos.X + Size.X)) and (Library.MousePos.Y <= (Pos.Y + Size.Y))
end
-- Done
function Library:CreateWindow(...)
	local Args = {...}
	local Window = {toggled = true, flags = {}, parent = nil, Objects={}}
	local data = {
		name = Args[1] or 'Window';
		showing = true;
	}
	Library.count = Library.count + 1
	local Main = Instance.new('ImageLabel')
	local UIListLayout = Instance.new('UIListLayout')
	local Top = Instance.new('ImageLabel')
	local Title = Instance.new('TextLabel')
	local Toggle = Instance.new('TextButton')
	local Image = Instance.new('ImageLabel')
	Main.Parent = ScreenGui
	Main.Active = true
	Main.BackgroundTransparency = 1
	Main.Selectable = true
	Main.Size = UDim2.new(0, 220, 0, 224)
	Main.Image = 'rbxassetid://3570695787'
	Main.ImageColor3 = Color3.fromRGB(30, 30, 30)
	Main.ScaleType = Enum.ScaleType.Slice
	Main.SliceCenter = Rect.new(100, 100, 100, 100)
	Main.SliceScale = 0.040
	Main.Position = UDim2.new(0,20+((Library.count - 1)*(Main.AbsoluteSize.X + 10)),0,20)
	Window.parent = Main

	UIListLayout.Parent = Main
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		Main.Size = UDim2.fromOffset(UIListLayout.AbsoluteContentSize.X, UIListLayout.AbsoluteContentSize.Y+2)
	end)
	
	Drag(Top)
	Top.Parent = Main
	Top.BackgroundTransparency = 1
	Top.Position = UDim2.new(0, 20, 0, 20)
	Top.Size = UDim2.new(1, 0, 0, 35)
	Top.Image = 'rbxassetid://3570695787'
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
	Title.Text = data.name
	Title.TextWrapped = true
	
	Toggle.Parent = Top
	Toggle.AnchorPoint = Vector2.new(1, 0.5)
	Toggle.BackgroundTransparency = 1
	Toggle.Position = UDim2.new(1, -5, 0.5, 0)
	Toggle.Size = UDim2.new(0, 25, 0, 25)
	Toggle.Font = Enum.Font.Gotham
	Toggle.Text = ''
	Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
	
	Image.Parent = Toggle
	Image.AnchorPoint = Vector2.new(0.5, 0.5)
	Image.BackgroundTransparency = 1
	Image.Position = UDim2.new(0.5, 0, 0.5, 0)
	Image.Rotation = 90
	Image.Size = UDim2.new(0.4, 0, 0.4, 0)
	Image.Image = 'rbxassetid://4918373417'
	Image.ImageColor3 = Color3.fromRGB(80, 80, 80)
	
	local down = TweenService:Create( Image, TweenInfo.new(0.2),{ Rotation = 90 })
	local up = TweenService:Create( Image, TweenInfo.new(0.2),{ Rotation = 180 })
	
	Toggle.MouseButton1Click:Connect(function()
		Window.toggled = not Window.toggled
		Main.ClipsDescendants = true
		Main:TweenSize((Window.toggled and UDim2.new(0,Main.Size.X.Offset,0, UIListLayout.AbsoluteContentSize.Y+2) or UDim2.new(0,Main.Size.X.Offset,0, 35)), nil, nil, 0.2, true)
		if Window.toggled then
			down:Play()
		else
			up:Play()
		end
	end)
	-- Done
	function Window:Button(...)
		local Args = {...}
		local selfButton = {}
		local Name = Args[1] or 'Button'
		local callback = Args[2] or function() end
		local Button = Instance.new('Frame')
		local TextButton = Instance.new('TextButton')
		local Image = Instance.new('ImageLabel')

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
		Image.Image = 'rbxassetid://3570695787'
		Image.ImageColor3 = Color3.fromRGB(45, 45, 45)
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		
		local Normal = TweenService:Create(Image, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(45,45,45)})
		local Hovering = TweenService:Create(Image, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(38,38,38)})
		local Pressed = TweenService:Create(Image, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(255,75,75)})
		
		function selfButton:Fire()
			if type(callback) == 'function' then
				local Success, Err = pcall(callback, selfButton)
				if not Success then
					error(Err)
				end
			end
		end
		
		function selfButton:Destroy()
			Normal:Destroy()
			Hovering:Destroy()
			Pressed:Destroy()
			Button:Destroy()
			for i,v in pairs(selfButton) do
				v = nil
			end
			setmetatable(selfButton,nil)
			selfButton = nil
		end
		
		TextButton.MouseButton1Click:Connect(function()
			if type(callback) == 'function' then
				local Success, Err = pcall(callback, selfButton)
				if not Success then
					error(Err)
				end
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
		
		setmetatable(selfButton, {
			__newindex = function(Table, index, value)
				if rawequal(Table, selfButton) then
					if rawequal(index,'name') then
						if type(value)=='string' then
							TextButton.Text = value
							data.name = value
						else return end
					end
				elseif rawequal(index,'callback') then
					data.callback = value
				elseif rawequal(index,'visible') then
					data.visible = value
					Button.Visible = data.visible
				end
			end;
			__index = function(Table, index)
				if data[index] ~= nil then
					return data[index]
				end
			end;
			__tostring = function(Table)
				return data.name
			end;
		})
		table.insert(self.Objects,#self.Objects+1,selfButton)
		return selfButton
	end
	-- Done
	function Window:Box(...)
		Args = {...}
		local Options = Args[2] or {}
		local SelfBox = {}
		local data = {
			name = Args[1] or 'TextBox';
			type = Options.type or 'string';
			min = Options.min or 0;
			max = Options.max or 9e9;
			flag = Options.flag or '';
			location = Options.location or Window.flags;
			callback = Args[3] or function() end;
			placeholder = Options.placeholder or '';
			visible = Options.visible or true;
		}
		data.default = Options.default or (data.type == 'number' and 0 or '')
		data.text = data.default
		if data.flag ~= '' then
			data.location[data.flag] = data.default
		end
		local Name = Args[1] or 'Box'
		local Box = Instance.new("Frame")
		local Holder = Instance.new("Frame")
		local Center = Instance.new("ImageLabel")
		local Outline = Instance.new("ImageLabel")
		local Title = Instance.new("TextLabel")
		local TextBox = Instance.new("TextBox")

		Box.Parent = self.parent
		Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Box.BackgroundTransparency = 1.000
		Box.ClipsDescendants = true
		Box.Size = UDim2.new(1, 0, 0, 40)
		
		Holder.Parent = Box
		Holder.AnchorPoint = Vector2.new(0, 0.5)
		Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Holder.BackgroundTransparency = 1.000
		Holder.Position = UDim2.new(0,4,0.5,0)
		Holder.Size = UDim2.new(1, -8, 1, -8)
		
		Center.Parent = Holder
		Center.AnchorPoint = Vector2.new(0.5, 0.5)
		Center.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Center.BackgroundTransparency = 1.000
		Center.Position = UDim2.new(0.5, 0, 0.5, 0)
		Center.Size = UDim2.new(1, -4, 1, -4)
		Center.ZIndex = 2
		Center.Image = "rbxassetid://3570695787"
		Center.ImageColor3 = Color3.fromRGB(30, 30, 30)
		Center.ScaleType = Enum.ScaleType.Slice
		Center.SliceCenter = Rect.new(100, 100, 100, 100)
		Center.SliceScale = 0.040
		
		Outline.Parent = Holder
		Outline.AnchorPoint = Vector2.new(0.5, 0.5)
		Outline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Outline.BackgroundTransparency = 1.000
		Outline.Position = UDim2.new(0.5, 0, 0.5, 0)
		Outline.Size = UDim2.new(1, 0, 1, 0)
		Outline.Image = "rbxassetid://3570695787"
		Outline.ImageColor3 = Color3.fromRGB(60, 60, 60)
		Outline.ScaleType = Enum.ScaleType.Slice
		Outline.SliceCenter = Rect.new(100, 100, 100, 100)
		Outline.SliceScale = 0.040
		
		Title.Parent = Holder
		Title.AnchorPoint = Vector2.new(0, 0.5)
		Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0, 6, 0, 3)
		Title.Size = UDim2.new(0, 32, 0, 15)
		Title.ZIndex = 3
		Title.Font = Enum.Font.GothamBold
		Title.Text = data.name
		Title.TextColor3 = Color3.fromRGB(100, 100, 100)
		Title.TextSize = 14.000
		Title.Size = UDim2.new(0, Title.TextBounds.X + 7, 0, 15)
		
		TextBox.Parent = Holder
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1
		TextBox.Position = UDim2.new(0, 7, 0, 8)
		TextBox.Size = UDim2.new(0, 200, 0, 18)
		TextBox.ClearTextOnFocus = false
		TextBox.ClipsDescendants = true
		TextBox.Font = Enum.Font.Gotham
		TextBox.Text = (string.lower(data.type) == 'number' and (tostring(data.default) or tostring(data.min)) or data.default)
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.PlaceholderText = data.placeholder
		TextBox.TextSize = 16
		TextBox.ZIndex = 3
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		
		local Normal = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(60,60,60)})
		local Hovering = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(100,100,100)})
		local Selected = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(255,75,75)})
		local MouseOverB = false
		local old = data.default
		function PositiveIntegerMask(text)
			return text:gsub('[^%-%d]', '')
		end
		
		function SelfBox:Destroy()
			data.location[data.flag] = nil
			Box:Destroy()
			Normal:Destroy()
			Hovering:Destroy()
			Selected:Destroy()
			PositiveIntegerMask=nil
			old=nil
			MouseOverB=nil
			for i,v in pairs(SelfBox) do
				v=nil
			end
			setmetatable(SelfBox,nil)
			data=nil
			Options=nil
			SelfBox=nil
		end
		
		setmetatable(SelfBox, {
			__newindex = function(Table, index, value)
				spawn(function()
					if rawequal(Table, SelfBox) then
						if rawequal(index,'text') then
							if type(value)=='string' or type(value)=='number' or type(value)=='table' then
								if type(value)=='table' and (type(value[1])=='string' or type(value[1])=='number') then
									if data.type == 'number' then
										data.text = tostring(math.clamp(tonumber(value[1]), data.min, data.max))
										if type(data.callback) == 'function' then
											if data.flag ~= '' then
												data.location[data.flag] = tonumber(TextBox.Text)
											end
											local Success, Err = pcall(data.callback, tonumber(data.text), tonumber(old), false, SelfBox)
											if not Success then
												error(Err)
											end
										end
									else
										if data.flag ~= '' then
											data.location[data.flag] = tonumber(TextBox.Text)
										end
										data.text = value[1]
										if type(data.callback) == 'function' then
											local Success, Err = pcall(data.callback, data.text, old, false, SelfBox)
											if not Success then
												error(Err)
											end
										end
									end
								else
									if type(value)=='number' then
										data.text = tostring(value)
									else
										data.text = value
									end
									if data.type == 'number' then
										data.text = tostring(math.clamp(tonumber(data.text), data.min, data.max))
									end
								end
								TextBox.Text = tostring(data.text)
								TextBox.Size = UDim2.new(0, 200, 0, 18)
								Holder.Size = UDim2.new(1,-8,1,-8)
							else return end
						elseif rawequal(index,'name') then
							if type(value)=='string' then
								Title.Text = value
								Title.Size = UDim2.new(0, Title.TextBounds.X + 7, 0, 15)
								data.name = value
							else return end
						elseif rawequal(index,'placeholder') then
							if type(value)=='string' then
								TextBox.PlaceholderText = value
								data.placeholder = value
							end
						elseif rawequal(index,'flag') then
							if type(value)=='string' then
								data.location[data.flag] = nil
								data.flag = value
								data.location[data.flag] = data.toggled
							else return end
						elseif rawequal(index,'location') then
							if type(value)=='table' then
								data.location[data.flag] = nil
								data.location = value
								data.location[data.flag] = data.toggled
							else return end
						elseif rawequal(index,'type') then
							if type(value)=="string" then
								local temptype = string.lower(value)
								if temptype == 'string' or temptype == 'number' then 
									data.type = value
								end
							end
						elseif rawequal(index,'callback') then
							data.callback = value
						elseif rawequal(index,'min') or rawequal(index,'max') then
							if type(value)=="number" then
								data[index] = value
								if data.type == 'number' then
									data.text = tostring(math.clamp(tonumber(TextBox.Text), data.min, data.min))
								end
							end
						elseif rawequal(index,'visible') then
							data.visible = value
							Box.Visible = data.visible
						end
					end
				end)
			end;
			__index = function(Table, index)
				if data[index] ~= nil then
					return data[index]
				end
			end;
			__tostring = function(Table)
				return data.name
			end;
		})
        TextBox:GetPropertyChangedSignal('Text'):Connect(function()
            if data.type == 'number' then
                TextBox.Text = PositiveIntegerMask(TextBox.Text)
			end
			if TextBox.TextBounds.X > 200 then
				Holder.Size = UDim2.new(0,TextBox.TextBounds.X+15,0,32)
				Box.ClipsDescendants = false
				self.parent.ClipsDescendants = false
				Main.ClipsDescendants = false
				TextBox.Size = UDim2.new(0, TextBox.TextBounds.X+5, 0, 18)
			else
				TextBox.Size = UDim2.new(0, 200, 0, 18)
				Holder.Size = UDim2.new(1,-8,1,-8)
			end
		end)
		
		TextBox.Focused:Connect(function()
			Selected:Play()
			if TextBox.TextBounds.X > 200 then
				Holder.Size = UDim2.new(0,TextBox.TextBounds.X+15,0,32)
				Box.ClipsDescendants = false
				self.parent.ClipsDescendants = false
				Main.ClipsDescendants = false
				TextBox.Size = UDim2.new(0, TextBox.TextBounds.X+5, 0, 18)
			else
				TextBox.Size = UDim2.new(0, 200, 0, 18)
				Holder.Size = UDim2.new(1,-8,1,-8)
			end
		end)
		
		TextBox.FocusLost:Connect(function(EnterPressed)
			Holder.Size = UDim2.new(1,-8,1,-8)
			TextBox.Size = UDim2.new(0, 200, 0, 18)
			Box.ClipsDescendants = true
			self.parent.ClipsDescendants = true
			Main.ClipsDescendants = true
			if MouseOverB then
				Hovering:Play()
			else
				Normal:Play()
			end
			if data.type == 'number' then
				if tonumber(TextBox.Text) then
					TextBox.Text = tostring(math.clamp(tonumber(TextBox.Text), data.min, data.max))
				else
					TextBox.Text = tostring(data.min > 0 and data.min or 0)
				end
				if data.flag ~= '' then
					data.location[data.flag] = tonumber(TextBox.Text)
				end
				if type(data.callback) == 'function' then
					local Success, Err = pcall(data.callback, tonumber(TextBox.Text), tonumber(old), EnterPressed, SelfBox)
					if not Success then
						error(Err)
					end
				end
			else
				if data.flag ~= '' then
					data.location[data.flag] = TextBox.Text
				end
				if type(data.callback) == 'function' then
					local Success, Err = pcall(data.callback, TextBox.Text, old, EnterPressed, SelfBox)
					if not Success then
						error(Err)
					end
				end
			end
			data.text = TextBox.Text
			old = TextBox.Text
		end)
		
		Main:GetPropertyChangedSignal("Size"):Connect(function()
			
		end)
		
		Box.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				TextBox:CaptureFocus()
			end
		end)
		
		Box.MouseEnter:Connect(function()
			MouseOverB = true
			if not TextBox:IsFocused() then
				Hovering:Play()
			end
		end)
		Box.MouseLeave:Connect(function()
			MouseOverB = false
			if not TextBox:IsFocused() then
				Normal:Play()
			end
		end)
		table.insert(self.Objects,#self.Objects+1,SelfBox)
		return SelfBox
	end
	-- Done
	function Window:Dropdown(...)
		local Args = {...}
		local Options = Args[2] or {}
		local selfDropdown = {}
		local data = {
			name = (Args[1] or 'Dropdown');
			callback = (Args[3] or function() end);
			location = (Options.location and Options.location or Window.flags);
			flag = (Options.flag or '');
			list = (Args[2] and Args[2].list or {});
			visible = (Args[2] and Args[2].visible or true);
		}
        local old = ''
		local toggled = false
		if data.flag ~= '' then
			data.location[data.flag] = tostring(data.list[1])
		end
		
		local Dropdown = Instance.new('Frame')
		local Button = Instance.new('TextButton')
		local Image = Instance.new('ImageLabel')
		local Toggle = Instance.new('TextLabel')
		local Image_2 = Instance.new('ImageLabel')

		Dropdown.Parent = self.parent
		Dropdown.BackgroundTransparency = 1
		Dropdown.Size = UDim2.new(1, 0, 0, 30)
		Dropdown.Visible = data.visible
		
		Button.Parent = Dropdown
		Button.AnchorPoint = Vector2.new(0.5, 0.5)
		Button.BackgroundTransparency = 1
		Button.Position = UDim2.new(0.5, 0, 0.5, 0)
		Button.Size = UDim2.new(1, -10, 0, 25)
		Button.ZIndex = 3
		Button.Font = Enum.Font.Gotham
		Button.Text = tostring(data.list[1])
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button.TextSize = 18

		Image.Parent = Button
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundTransparency = 1
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.ZIndex = 2
		Image.Image = 'rbxassetid://3570695787'
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
		Toggle.Font = Enum.Font.Gotham
		Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
		
		Image_2.Parent = Toggle
		Image_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Image_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Image_2.BackgroundTransparency = 1
		Image_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image_2.Rotation = 180
		Image_2.Size = UDim2.new(0.400000006, 0, 0.400000006, 0)
		Image_2.ZIndex = 2
		Image_2.Image = 'rbxassetid://4918373417'
		Image_2.ImageColor3 = Color3.fromRGB(156, 156, 156)
		
        old = Button.Text

		local Normal = TweenService:Create(Image, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(45,45,45)})
		local Hovering = TweenService:Create(Image, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(38,38,38)})
		
		local function CloseDropdown()
            if Button:FindFirstChild('Dropdown') then
				Image.SliceCenter = Rect.new(100, 100, 100, 100)
                toggled = false
				Button.Text = old
				Button.TextColor3 = Color3.fromRGB(255,255,255)
				Button:FindFirstChild('Dropdown'):TweenSize( UDim2.new(0, 173, 0, 0), 'Out', 'Quad', 0.2, true, function()
					Image.ZIndex = 2
					Image_2.ZIndex = 3
					Button.ZIndex = 3
                    Button:FindFirstChild('Dropdown'):Destroy()
   	        	end)
        	end
		end
		
		local ToBeDeleted = {}
		
		local function CreateDropDown(Array)
			self.parent.ClipsDescendants = false
			Main.ClipsDescendants = false
			local Dropdown1 = Instance.new('ImageLabel')
			
			Dropdown1.Name = 'Dropdown'
 			Dropdown1.Parent = Button
			Dropdown1.AnchorPoint = Vector2.new(0.5, 0)
			Dropdown1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown1.BackgroundTransparency = 1
			Dropdown1.Position = UDim2.new(0.5, 0, 0, 0)
			Dropdown1.Size = UDim2.new(1, 0, 0, 0)
			Dropdown1.Image = 'rbxassetid://3570695787'
			Dropdown1.ImageColor3 = Color3.fromRGB(42, 42, 42)
			Dropdown1.ScaleType = Enum.ScaleType.Slice
			Dropdown1.SliceCenter = Rect.new(100, 100, 100, 100)
			Dropdown1.SliceScale = 0.040
			Dropdown1.ClipsDescendants = true
			Dropdown1.ZIndex = 5	
			if #Array <= 5 then
				local UIGridLayout = Instance.new('UIGridLayout')
				local UIPadding = Instance.new('UIPadding')
				UIGridLayout.Parent = Dropdown1
				UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
				UIGridLayout.CellSize = UDim2.new(1, 0, 0, 24)
				
				UIPadding.Parent = Dropdown1
				UIPadding.PaddingTop = UDim.new(0, 25)
				
				Button.Text = data.name
				Button.TextColor3 = Color3.fromRGB(120,120,120)
				
				for	i,v in pairs(Array) do
					local TextButton = Instance.new('TextButton')
					local Image_3 = Instance.new('ImageLabel')
					
					TextButton.Parent = Dropdown1
					TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
					TextButton.BackgroundTransparency = 1
					TextButton.BorderSizePixel = 0
					TextButton.Size = UDim2.new(0, 200, 0, 50)
					TextButton.ZIndex = 2
					TextButton.Text = tostring(v)
					TextButton.Font = Enum.Font.Gotham
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.TextSize = 18
					TextButton.ZIndex = 7
					
					Image_3.Parent = TextButton
					Image_3.Active = true
					Image_3.AnchorPoint = Vector2.new(0.5, 0.5)
					Image_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Image_3.BackgroundTransparency = 1
					Image_3.Position = UDim2.new(0.5, 0, 0.5, 0)
					Image_3.Selectable = true
					Image_3.Size = UDim2.new(1, 0, 1, 0)
					Image_3.Image = 'rbxassetid://3570695787'
					Image_3.ImageColor3 = Color3.fromRGB(50, 50, 50)
					Image_3.ScaleType = Enum.ScaleType.Slice
					Image_3.SliceCenter = Rect.new(100, 100, 100, 100)
					Image_3.SliceScale = i == #Array and 0.040 or 0.01
					Image_3.ZIndex = 6
					
					local Normal = TweenService:Create(Image_3, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(50,50,50)})
					local Hovering = TweenService:Create(Image_3, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(40,40,40)})
					local Pressed = TweenService:Create(Image_3, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(30,30,30)})
					
					table.insert(ToBeDeleted,#ToBeDeleted+1,Normal)
					table.insert(ToBeDeleted,#ToBeDeleted+1,Hovering)
					table.insert(ToBeDeleted,#ToBeDeleted+1,Pressed)
					
					TextButton.MouseButton1Click:Connect(function()
						Button.Text = TextButton.Text
						old = TextButton.Text
						toggled = false
						Image.SliceCenter = Rect.new(100, 100, 100, 100)
				        if data.flag ~= '' then
				            data.location[data.flag] = TextButton.Text
						end
						Button.TextColor3 = Color3.fromRGB(255,255,255)
						Dropdown1:TweenSize(UDim2.new(1,0,0,0),nil,nil,0.2,true,function()
							Image.ZIndex = 2
							Image_2.ZIndex = 3
							Button.ZIndex = 3
							Dropdown1:Destroy()
						end)
						if type(data.callback) == 'function' then
							local Success, Err = pcall(data.callback, TextButton.Text, selfDropdown)
							if not Success then
								error(Err)
							end
						end
						for i,v in pairs(ToBeDeleted) do
							v:Destroy()
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
				local UIGridLayout = Instance.new('UIGridLayout')
				local UIPadding = Instance.new('UIPadding')
				local ScrollingFrame = Instance.new('ScrollingFrame')

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
				
				Button.Text = data.name
				Button.TextColor3 = Color3.fromRGB(120,120,120)
				
				for	i,v in pairs(Array) do
					local TextButton = Instance.new('TextButton')
					local Image_3 = Instance.new('ImageLabel')
					
					TextButton.Parent = ScrollingFrame
					TextButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
					TextButton.BackgroundTransparency = 1
					TextButton.BorderSizePixel = 0
					TextButton.Size = UDim2.new(0, 200, 0, 50)
					TextButton.ZIndex = 2
					TextButton.Text = tostring(v)
					TextButton.Font = Enum.Font.Gotham
					TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextButton.TextSize = 18
					TextButton.ZIndex = 7
					
					Image_3.Parent = TextButton
					Image_3.Active = true
					Image_3.AnchorPoint = Vector2.new(0.5, 0.5)
					Image_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Image_3.BackgroundTransparency = 1
					Image_3.Position = UDim2.new(0.5, 0, 0.5, 0)
					Image_3.Selectable = true
					Image_3.Size = UDim2.new(1, 0, 1, 0)
					Image_3.Image = 'rbxassetid://3570695787'
					Image_3.ImageColor3 = Color3.fromRGB(50, 50, 50)
					Image_3.ScaleType = Enum.ScaleType.Slice
					Image_3.SliceCenter = Rect.new(100, 100, 100, 100)
					Image_3.SliceScale = i == #Array and 0.040 or 0.01
					Image_3.ZIndex = 6
					
					local Normal = TweenService:Create(Image_3, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(50,50,50)})
					local Hovering = TweenService:Create(Image_3, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(40,40,40)})
					local Pressed = TweenService:Create(Image_3, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(30,30,30)})
					
					table.insert(ToBeDeleted,#ToBeDeleted+1,Normal)
					table.insert(ToBeDeleted,#ToBeDeleted+1,Hovering)
					table.insert(ToBeDeleted,#ToBeDeleted+1,Pressed)
					
					TextButton.MouseButton1Click:Connect(function()
						Button.Text = TextButton.Text
						old = TextButton.Text
						toggled = false
						Image.SliceCenter = Rect.new(100, 100, 100, 100)
				        if data.flag ~= '' then
				            data.location[data.flag] = TextButton.Text
						end
						Button.TextColor3 = Color3.fromRGB(255,255,255)
						Dropdown1:TweenSize(UDim2.new(1,0,0,0),nil,nil,0.2,true,function()
							Image.ZIndex = 2
							Image_2.ZIndex = 3
							Button.ZIndex = 3
							Dropdown1:Destroy()
						end)
						if type(data.callback) == 'function' then
							local Success, Err = pcall(data.callback, TextButton.Text, selfDropdown)
							if not Success then
								error(Err)
							end
						end
						for i,v in pairs(ToBeDeleted) do
							v:Destroy()
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
		
		game:GetService('UserInputService').WindowFocusReleased:Connect(CloseDropdown)
		
		Button.MouseButton2Click:Connect(function()
			if type(data.callback) == 'function' then
				local Success, Err = pcall(data.callback, Button.Text, selfDropdown)
				if not Success then
					error(Err)
				end
			end
		end)
		
		Button.MouseButton1Click:Connect(function()
			toggled = not toggled
			if toggled then 
				Image.ZIndex = 8
				Image_2.ZIndex = 9
				Button.ZIndex = 9
				Image.SliceCenter = Rect.new(100, 100, 100, 200)
				CreateDropDown(data.list)
			else
				Button.Text = old
				Image.SliceCenter = Rect.new(100, 100, 100, 100)
				for i,v in pairs(Button:GetChildren()) do
					if v.Name == 'Dropdown' then
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
		
		function selfDropdown:Destroy()
			for i,v in pairs(ToBeDeleted) do
				local s,e = pcall(function() v:Destroy() end)
				if not s then
					v = nil
				end
			end
			ToBeDeleted = nil
			data.location[data.flag] = nil
			Dropdown:Destroy()
			Normal:Destroy()
			Hovering:Destroy()
			for i,v in pairs(selfDropdown) do
				v=nil
			end
			setmetatable(selfDropdown,nil)
			data=nil
			Options=nil
			selfDropdown=nil
		end
		
		setmetatable(selfDropdown, {
			__newindex = function(Table, index, value)
				if rawequal(Table, selfDropdown) then
					if rawequal(index,'list') then
						if type(value)=='table' then
							CloseDropdown()
							Button.Text = tostring(value[1])
							old = tostring(value[1])
							data.list = value
							if data.flag ~= "" then
								data.location[data.flag] = tostring(value[1])
							end
						else return end
					elseif rawequal(index,'name') then
						if type(value)=='string' then
							if toggled then
								Button.Text = value
							end
							data.name = value
						else return end
					elseif rawequal(index,'flag') then
						if type(value)=='string' then
							data.location[data.flag] = nil
							data.flag = value
							data.location[data.flag] = data.toggled
						else return end
					elseif rawequal(index,'location') then
						if type(value)=='table' then
							data.location[data.flag] = nil
							data.location = value
							data.location[data.flag] = data.toggled
						else return end
					elseif rawequal(index,'callback') then
						data.callback = value
					elseif rawequal(index,'visible') then
						data.visible = value
						Dropdown.Visible = data.visible
					end
				end
			end;
			__index = function(Table, index)
				if data[index] ~= nil then
					return data[index]
				end
			end;
			__tostring = function(Table)
				return data.name
			end;
		})
		table.insert(self.Objects,#self.Objects+1,selfDropdown)
		return selfDropdown
	end
	-- Done
	function Window:Toggle(...)
		local Args = {...}
		local Options = Args[2] or {}
		local data = {
			name = (Args[1] or 'Toggle');
			callback = (Args[3] or function() end);
			toggled = (Options.default or false);
			location = (Options.location and Options.location or Window.flags);
			flag = (Options.flag or '');
			visible = (Options.visible or true);
		}
		local SelfToggle = {}
		
		if data.flag ~= "" then
			data.location[data.flag] = data.toggled
		end
		
		local Toggle = Instance.new('Frame')
		local Title = Instance.new('TextLabel')
		local Outline = Instance.new('ImageLabel')
		local Center = Instance.new('ImageLabel')
		local Checkmark = Instance.new('ImageLabel')

		Toggle.Parent = self.parent
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1
		Toggle.Size = UDim2.new(1, 0, 0, 30)
		Toggle.Visible = data.visible
		
		Title.Parent = Toggle
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, 7, 0, 0)
		Title.Size = UDim2.new(1, -7, 1, 0)
		Title.Font = Enum.Font.Gotham
		Title.Text = data.name
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 16
		Title.TextWrapped = true
		Title.TextXAlignment = Enum.TextXAlignment.Left

		Outline.Parent = Toggle
		Outline.AnchorPoint = Vector2.new(1, 0.5)
		Outline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Outline.BackgroundTransparency = 1
		Outline.Position = UDim2.new(1, -5, 0.5, 0)
		Outline.Size = UDim2.new(0, 26, 0, 26)
		Outline.Image = 'rbxassetid://3570695787'
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
		Center.Image = 'rbxassetid://3570695787'
		Center.ImageColor3 = Color3.fromRGB(30, 30, 30)
		Center.ScaleType = Enum.ScaleType.Slice
		Center.SliceCenter = Rect.new(100, 100, 100, 100)
		Center.SliceScale = 0.040
		
		Checkmark.Parent = Toggle
		Checkmark.AnchorPoint = Vector2.new(1, 0.5)
		Checkmark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Checkmark.BackgroundTransparency = 1
		Checkmark.Position = UDim2.new(1, -10, 0.5, 0)
		Checkmark.Size = UDim2.new(0, 16, 0, 16)
		Checkmark.ImageColor3 = Color3.fromRGB(30,30,30)
		Checkmark.Image = 'rbxassetid://4919148038'
		
		if data.toggled then
			Center.Size = UDim2.new(0,0,0,Center.Size.Y.Offset)
			Outline.ImageColor3 = Color3.fromRGB(255,75,75)
			Center.ImageColor3 = Color3.fromRGB(255,75,75)
		end
		
		local Normal = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(60,60,60)})
		local Hovering = TweenService:Create(Outline, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(100,100,100)})
		local toggledOn1 = TweenService:Create(Outline, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255,75,75)})
		local toggledOn2 = TweenService:Create(Center, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255,75,75)})
		local toggledOff1 = TweenService:Create(Outline, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(60,60,60)})
		local toggledOff2 = TweenService:Create(Center, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(30,30,30)})
		
		function SelfToggle:Destroy() 
			Normal:Destroy()
			Hovering:Destroy()
			toggledOn1:Destroy()
			toggledOn2:Destroy()
			toggledOff1:Destroy()
			toggledOff2:Destroy()
			if data then
				data.location[data.flag] = nil
				data = nil
			end
			if Toggle then
				Toggle:Destroy()
			end
			setmetatable(SelfToggle,nil)
			if SelfToggle then
				for i,v in pairs(SelfToggle) do
					v = nil
				end
				SelfToggle = nil
			end
		end
		
		setmetatable(SelfToggle, {
			__newindex = function(Table, index, value)
				spawn(function()
					if rawequal(Table, SelfToggle) then
						if rawequal(index,'toggled') then
							if type(value)=='boolean' or type(value)=='table' then
								if type(value)=='table' and type(value[1])=='boolean' then
									data.toggled = value[1]
									if data.flag ~= '' then
										data.location[data.flag] = data.toggled
									end
									if type(data.callback) == 'function' then
										local Success, Err = pcall(data.callback, data.toggled, SelfToggle)
										if not Success then
											error(Err)
										end
									end
								else
									data.toggled = value
									if data.flag ~= '' then
										data.location[data.flag] = data.toggled
									end
								end
								if data.toggled then
									toggledOn1:Play()
									toggledOn2:Play()
									wait(0.15)
									Center:TweenSize(UDim2.new(0,0,0,Center.Size.Y.Offset), nil, nil, 0.1, true)
								else
									Center:TweenSize(UDim2.new(0,Center.Size.Y.Offset,0,Center.Size.Y.Offset), nil, nil, 0.1, true)
									wait(0.15)
									toggledOff1:Play()
									toggledOff2:Play()
								end
							else return end
						elseif rawequal(index,'name') then
							if type(value)=='string' then
								Title.Text = value
								data.name = value
							else return end
						elseif rawequal(index,'flag') then
							if type(value)=='string' then
								data.location[data.flag] = nil
								data.flag = value
								data.location[data.flag] = data.toggled
							else return end
						elseif rawequal(index,'location') then
							if type(value)=='table' then
								data.location[data.flag] = nil
								data.location = value
								data.location[data.flag] = data.toggled
							else return end
						elseif rawequal(index,'callback') then
							data.callback = value
						elseif rawequal(index,'visible') then
							data.visible = value
							Toggle.Visible = data.visible
						end
					end
				end)
			end;
			__index = function(Table, index)
				if data[index] ~= nil then
					return data[index]
				end
			end;
			__tostring = function(Table)
				return data.name
			end;
		})
		
		Toggle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				SelfToggle.toggled = {not data.toggled}
			end
		end)
		
		Toggle.MouseEnter:Connect(function()
			MouseOverB = true
			if not data.toggled then
				Hovering:Play()
				Center.Size = UDim2.new(0,Center.Size.Y.Offset,0,Center.Size.Y.Offset)
			end
		end)
		Toggle.MouseLeave:Connect(function()
			MouseOverB = false
			if not data.toggled then
				Normal:Play()
				Center.Size = UDim2.new(0,Center.Size.Y.Offset,0,Center.Size.Y.Offset)
			end
		end)
		table.insert(self.Objects,#self.Objects+1,SelfToggle)
		return SelfToggle
	end
	-- Done
	function Window:Slider(...)
		local Args = {...}
		local SelfSlider = {}
		local data = {
			Name = Args[1] or 'Slider';
			callback = Args[3] or function()end;
			flag = Args[2] and Args[2].flag or '';
			min = Args[2] and Args[2].min or 0;
			max = Args[2] and Args[2].max or 100;
			step = Args[2] and Args[2].step or 1;
			location = Args[2] and Args[2].location or Window.flags;
			visible = Args[2] and Args[2].visible or true
		}
		data.value = Args[2] and Args[2].default or data.min;
		if data.flag ~= '' then
			data.location[data.flag] = data.value
		end
		
		local Box = Instance.new('Frame')
		local Title = Instance.new('TextLabel')
		local Amount = Instance.new('TextBox')
		local Image = Instance.new('ImageLabel')
		local Background = Instance.new('Frame')
		local BackgroundImage = Instance.new('ImageLabel')
		local Fill = Instance.new('ImageLabel')
		local Handle = Instance.new('ImageButton')

		Box.Parent = self.parent
		Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Box.BackgroundTransparency = 1.000
		Box.ClipsDescendants = true
		Box.Visible = data.visible
		Box.Size = UDim2.new(1, 0, 0, 40)
		
		Title.Parent = Box
		Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0, 7, 0, 4)
		Title.Size = UDim2.new(0, 213, 0, 15)
		Title.Font = Enum.Font.Gotham
		Title.Text = data.Name
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 16.000
		Title.TextXAlignment = Enum.TextXAlignment.Left
		
		Amount.Parent = Box
		Amount.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		Amount.BackgroundTransparency = 1.000
		Amount.BorderSizePixel = 0
		Amount.Position = UDim2.new(0.7409091, 0, 0.075000003, 0)
		Amount.Size = UDim2.new(0, 50, 0, 18)
		Amount.ZIndex = 2
		Amount.Font = Enum.Font.Gotham
		Amount.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
		Amount.Text = tostring(data.value)
		Amount.TextColor3 = Color3.fromRGB(255, 255, 255)
		Amount.TextSize = 14.000
		
		Image.Parent = Amount
		Image.Active = true
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Image.BackgroundTransparency = 1.000
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Selectable = true
		Image.Size = UDim2.new(1, 0, 1, 0)
		Image.Image = 'rbxassetid://3570695787'
		Image.ImageColor3 = Color3.fromRGB(45, 45, 45)
		Image.ScaleType = Enum.ScaleType.Slice
		Image.SliceCenter = Rect.new(100, 100, 100, 100)
		Image.SliceScale = 0.040
		
		Background.Parent = Box
		Background.AnchorPoint = Vector2.new(0.5, 1)
		Background.BackgroundTransparency = 1.000
		Background.Position = UDim2.new(0.5, 0, 1, -2)
		Background.Size = UDim2.new(1, -20, 0, 17)
		
		BackgroundImage.Parent = Background
		BackgroundImage.AnchorPoint = Vector2.new(0.5, 0.5)
		BackgroundImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BackgroundImage.BackgroundTransparency = 1.000
		BackgroundImage.Position = UDim2.new(0.5, 0, 0.5, 0)
		BackgroundImage.Size = UDim2.new(1, 0, 0, 6)
		BackgroundImage.Image = 'rbxassetid://3570695787'
		BackgroundImage.ImageColor3 = Color3.fromRGB(60, 60, 60)
		BackgroundImage.ScaleType = Enum.ScaleType.Slice
		BackgroundImage.SliceCenter = Rect.new(100, 100, 100, 100)
		BackgroundImage.SliceScale = 0.040
		
		Fill.Parent = Background
		Fill.AnchorPoint = Vector2.new(0, 0.5)
		Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Fill.BackgroundTransparency = 1.000
		Fill.Position = UDim2.new(math.clamp((((data.max - 0) / (data.max - data.min))-1)*-1, 0, 1),0,0.5,0)
		Fill.Size = UDim2.new((1 - (((data.max - data.value) / (data.max - data.min))+Fill.Position.X.Scale)), 0, 0, 6)
		Fill.Image = 'rbxassetid://3570695787'
		Fill.ImageColor3 = Color3.fromRGB(100, 100, 100)
		Fill.ScaleType = Enum.ScaleType.Slice
		Fill.SliceCenter = Rect.new(100, 100, 100, 100)
		Fill.SliceScale = 0.040
		
		Handle.Parent = Fill
		Handle.AnchorPoint = Vector2.new(0.5, 0.5)
		Handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Handle.BackgroundTransparency = 1.000
		Handle.Position = UDim2.new(1, 0, 0.5, 0)
		Handle.Size = UDim2.new(0, 0, 0, 0)
		Handle.Image = 'rbxassetid://3570695787'
		Handle.ImageColor3 = Color3.fromRGB(100, 100, 100)
		Handle.ScaleType = Enum.ScaleType.Fit
		Handle.SliceCenter = Rect.new(100, 100, 100, 100)
		Handle.SliceScale = 0.040
		if Fill.Position.X.Scale > 0 and Fill.Size.X.Scale < 0 then
			Handle.Position = UDim2.new(0,0,0.5,0)
		else
			Handle.Position = UDim2.new(1,0,0.5,0)
		end
		local Normal1 = TweenService:Create(Fill, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(100,100,100)})
		local Normal2 = TweenService:Create(Handle, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(100,100,100)})
		local Dragging1 = TweenService:Create(Fill, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(255,75,75)})
		local Dragging2 = TweenService:Create(Handle, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(255,75,75)})
		local Dragging = false
		local selfslider = {}
		local old = tonumber(Amount.Text)
		
		function SelfSlider:Destroy()
			Normal1:Destroy()
			Normal2:Destroy()
			Dragging1:Destroy()
			Dragging2:Destroy()
			Box:Destroy()
			if data.flag ~= '' then
				data.location[data.flag] = nil
			end
			data = nil
			for i,v in pairs(SelfSlider) do
				v = nil
			end
			setmetatable(SelfSlider,nil)
			SelfSlider=nil
		end
		
        local function Snap(num, snap)
            if snap == 0 then
                return num
            else
                return math.floor(num / snap + 0.5) * snap
            end
		end
		local function round(n)
			return math.floor(n + 0.5)
		end
        local function GetDecimalPlacesCount(num)
            num = tostring(num)
            if string.match(num, '.') then
                local dec = string.split(num, '.')
                return #tostring(tonumber(dec[2]))
            else
                return 0
            end
        end
        Handle.MouseButton1Down:Connect(function()
			Dragging = true
			Dragging1:Play()
			Dragging2:Play()
		end)
        Background.InputBegan:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    coroutine.resume(
                        coroutine.create(
                            function()
								Dragging = true
								Dragging1:Play()
								Dragging2:Play()
                                local Relpos = Library.MousePos - Fill.AbsolutePosition
                                local precentage = Relpos.x / Background.AbsoluteSize.x
								Fill.Size = UDim2.new(Snap(math.clamp(precentage, (0-Fill.Position.X.Scale), (1-Fill.Position.X.Scale)), data.step / (
									data.max - data.min)), 0, 0, 6)
								if Fill.Position.X.Scale > 0 and Fill.Size.X.Scale <= 0 then
									Handle.Position = UDim2.new(0,0,0.5,0)
								elseif Fill.Position.X.Scale > 0 then
									Handle.Position = UDim2.new(1,0,0.5,0)
								end
                                if data.step >= 1 then
                                    Amount.Text =
                                        string.format(
                                        '%.0f',
                                        round(((Fill.AbsoluteSize.x / Background.AbsoluteSize.x)+Fill.Position.X.Scale) * (data.max - data.min) + data.min))
                                else
                                    local deccount = GetDecimalPlacesCount(data.step)
                                    local decsize = (data.step >= 1 and 10 or 100)
					                Amount.Text =
					                    string.format(
					                    '%.' .. (decsize == 10 and '1' or '2') .. 'f',
					                    round(
					                        (((Fill.AbsoluteSize.x / Background.AbsoluteSize.x)+Fill.Position.X.Scale) * (data.max - data.min) + data.min) *
					                            (decsize / (data.step * decsize))
					                    ) /
					                        (decsize / (data.step * decsize))
					                                        )
								end
								data.value = tonumber(Amount.Text)
								if type(data.callback) == 'function' then
									local Success, Err = pcall(data.callback, tonumber(Amount.Text), selfslider)
									if not Success then
										error(Err)
									end
								end
								if data.flag ~= '' then
									data.location[data.flag] = tonumber(Amount.Text)
								end
								old = tonumber(Amount.Text)
                            end
                        )
                    )
                end
            end
        )
        game:GetService('UserInputService').InputEnded:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
				    Dragging = false
					Normal1:Play()
					Normal2:Play()
					if not MouseOver(Background) then
						Handle:TweenSize(UDim2.new(0, 0, 0, 0), nil, nil, 0.1, true)
					end
                end
            end
        )
		game:GetService('UserInputService').InputChanged:Connect(function(input, gameProcessed)
		    if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
		        spawn(function()
		            local Relpos = Library.MousePos - Fill.AbsolutePosition
		            local precentage = Relpos.x / Background.AbsoluteSize.x
					Fill.Size = UDim2.new(Snap(math.clamp(precentage, (0-Fill.Position.X.Scale), (1-Fill.Position.X.Scale)), data.step / 
						(data.max - data.min)), 0, 0, 6)
					if Fill.Position.X.Scale > 0 and Fill.Size.X.Scale <= 0 then
						Handle.Position = UDim2.new(0,0,0.5,0)
					elseif Fill.Position.X.Scale > 0 then
						Handle.Position = UDim2.new(1,0,0.5,0)
					end
		            if data.step >= 1 then
		                Amount.Text =
		                    string.format(
		                    '%.0f',
		                    round(((Fill.AbsoluteSize.x / Background.AbsoluteSize.x)+Fill.Position.X.Scale) * (data.max - data.min) + data.min))
		                if data.flag ~= '' then
		                    data.location[data.flag] = tonumber(Amount.Text)
						end
						if type(data.callback) == 'function' then
			                local Success, Err = pcall(data.callback, tonumber(Amount.Text), selfslider)
			                if not Success then
			                    error(Err)
							end
						end
		            else
		                local deccount = GetDecimalPlacesCount(data.step)
		                local decsize = (data.step >= 1 and 10 or 100)
		                Amount.Text =
		                    string.format(
		                    '%.' .. (decsize == 10 and '1' or '2') .. 'f',
		                    round(
		                        (((Fill.AbsoluteSize.x / Background.AbsoluteSize.x)+Fill.Position.X.Scale) * (data.max - data.min) + data.min) *
		                            (decsize / (data.step * decsize))
		                    ) /
		                        (decsize / (data.step * decsize))
		                                        )
					end
					data.value = tonumber(Amount.Text)
		            if data.flag ~= '' then
		                data.location[data.flag] = tonumber(Amount.Text)
					end
					if type(data.callback) == 'function' then
			            local Success, Err = pcall(data.callback, tonumber(Amount.Text), selfslider)
			            if not Success then
			                error(Err)
						end
					end
		            old = tonumber(Amount.Text)
		        end)
		    end
		end)
		game:GetService('UserInputService').WindowFocusReleased:Connect(function()
			Dragging = false
			Normal1:Play()
			Normal2:Play()
			Handle:TweenSize(UDim2.new(0, 0, 0, 0), nil, nil, 0.1, true)
        end)
		
        function PositiveIntegerMask(text)
            return text:gsub('[^%-%d]', '')
        end
        Amount:GetPropertyChangedSignal('Text'):Connect(function()
            if (type == 'number') then
                Amount.Text = PositiveIntegerMask(Amount.Text)
            end
        end)
		
		Background.MouseLeave:Connect(function()
			if not Dragging then
				Handle:TweenSize(UDim2.new(0, 0, 0, 0), nil, nil, 0.1, true)
			end
		end)
		
		Background.MouseEnter:Connect(function()
			Handle:TweenSize(UDim2.new(0, 13, 0, 13), nil, nil, 0.1, true)
		end)
		
		Amount.FocusLost:Connect(function()
			if tonumber(Amount.Text) then
				Amount.Text = math.clamp(tonumber(Amount.Text), data.min, data.max)
			else
				Amount.Text = tostring(old)
			end
			Fill.Size = UDim2.new((1 - (((data.max - tonumber(Amount.Text)) / (data.max - data.min))+Fill.Position.X.Scale)), 0, 0, 6)
			if Fill.Position.X.Scale > 0 and Fill.Size.X.Scale <= 0 then
				Handle.Position = UDim2.new(0,0,0.5,0)
			elseif Fill.Position.X.Scale > 0 then
				Handle.Position = UDim2.new(1,0,0.5,0)
			end
	        if data.flag ~= '' then
	            data.location[data.flag] = tonumber(Amount.Text)
			end
			data.value = tonumber(Amount.Text)
			if type(data.callback) == 'function' then
				local Success, Err = pcall(data.callback, tonumber(Amount.Text), selfslider)
				if not Success then
					error(Err)
				end
			end
			old = tonumber(Amount.Text)
		end)
		
		setmetatable(SelfSlider, {
			__newindex = function(Table, index, value)
				spawn(function()
					if rawequal(Table, SelfSlider) then
						if rawequal(index,'value') then
							if type(value)=='number' or type(value)=='table' then
								if type(value)=='table' and type(value[1])=='number' then
									if data.flag ~= '' then
										data.location[data.flag] = value
									end
									data.value = value[1]
									if type(data.callback) == 'function' then
										local Success, Err = pcall(data.callback, data.value, SelfSlider)
										if not Success then
											error(Err)
										end
									end
								else
									if data.flag ~= '' then
										data.location[data.flag] = value
									end
									data.value = value
								end
								if tonumber(value) then
									Amount.Text = math.clamp(tonumber(value), data.min, data.max)
									value = math.clamp(tonumber(value), data.min, data.max)
								else
									Amount.Text = tostring(old)
									value = old
								end
								Fill.Size = UDim2.new((1 - (((data.max - value) / (data.max - data.min))+Fill.Position.X.Scale)), 0, 0, 6)
								if Fill.Position.X.Scale > 0 and Fill.Size.X.Scale <= 0 then
									Handle.Position = UDim2.new(0,0,0.5,0)
								elseif Fill.Position.X.Scale > 0 then
									Handle.Position = UDim2.new(1,0,0.5,0)
								end
								old = value
							else return end
						elseif rawequal(index,'name') then
							if type(value)=='string' then
								Title.Text = value
								data.name = value
							else return end
						elseif rawequal(index,'flag') then
							if type(value)=='string' then
								data.location[data.flag] = nil
								data.flag = value
								data.location[data.flag] = data.toggled
							else return end
						elseif rawequal(index,'location') then
							if type(value)=='table' then
								data.location[data.flag] = nil
								data.location = value
								data.location[data.flag] = data.toggled
							else return end
						elseif rawequal(index,'callback') then
							data.callback = value
						elseif rawequal(index,'min') or rawequal(index,'max') then
							data[index] = value
							if (index == 'min' and value+1 < data.max) or (index == 'max' and value-1 > data.min) then
								data.value = math.clamp(data.value, data.min, data.max)
								Amount.Text = tostring(data.value)
								Fill.Position = UDim2.new(math.clamp((((data.max - 0) / (data.max - data.min))-1)*-1, 0, 1),0,0.5,0)
								Fill.Size = UDim2.new((1 - (((data.max - data.value) / (data.max - data.min))+Fill.Position.X.Scale)), 0, 0, 6)
							else
								if index == 'min' then
									warn("min can't be greater or equal to max")
								elseif index == 'max' then
									warn("max can't be less then or equal to min")
								end
							end
						elseif rawequal(index,'visible') then
							data.visible = value
							Box.Visible = data.visible
						end
					end
				end)
			end;
			__index = function(Table, index)
				if data[index] ~= nil then
					return data[index]
				end
			end;
			__tostring = function(Table)
				return data.name
			end;
		})
		table.insert(self.Objects,#self.Objects+1,SelfSlider)
		return SelfSlider
	end
	-- Done
	function Window:Folder(...)
		local Args = {...}
		local data = {
			name = Args[1] or 'Folder';
			showing = false;
			visible = true
		}
		local Folder = deepcopy(Window)
		Folder.toggled = false
		
		local Title = Instance.new('ImageLabel')
		local Title_2 = Instance.new('TextLabel')
		local Toggle = Instance.new('TextButton')
		local Image = Instance.new('ImageLabel')

		Title.Parent = self.parent
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0, 20, 0, 20)
		Title.Size = UDim2.new(1, 0, 0, 30)
		Title.Image = 'rbxassetid://3570695787'
		Title.ImageColor3 = Color3.fromRGB(25,25,25)
		Title.ScaleType = Enum.ScaleType.Slice
		Title.SliceCenter = Rect.new(100, 100, 100, 100)
		Title.SliceScale = 0.040
		Title.Visible = data.visible
		
		Title_2.Parent = Title
		Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title_2.BackgroundTransparency = 1
		Title_2.Size = UDim2.new(1, 0, 1, 0)
		Title_2.Font = Enum.Font.Gotham
		Title_2.Text = data.name
		Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title_2.TextSize = 18
		Title_2.TextWrapped = true
		
		Toggle.Parent = Title
		Toggle.AnchorPoint = Vector2.new(1, 0.5)
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1
		Toggle.Position = UDim2.new(1, -5, 0.5, 0)
		Toggle.Size = UDim2.new(0, 25, 0, 25)
		Toggle.Font = Enum.Font.Gotham
		Toggle.Text = ''
		Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.TextSize = 14
		
		Image.Parent = Toggle
		Image.AnchorPoint = Vector2.new(0.5, 0.5)
		Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Image.BackgroundTransparency = 1
		Image.Position = UDim2.new(0.5, 0, 0.5, 0)
		Image.Rotation = 180
		Image.Size = UDim2.new(0.4, 0, 0.4, 0)
		Image.Image = 'rbxassetid://4918373417'
		Image.ImageColor3 = Color3.fromRGB(80, 80, 80)
		
		local FolderContainer = Instance.new('ImageLabel')
		local UIListLayout = Instance.new('UIListLayout')
		Folder.parent = FolderContainer

		FolderContainer.Parent = self.parent
		FolderContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		FolderContainer.BackgroundTransparency = 1
		FolderContainer.Size = UDim2.new(1, 0, 0, 0)
		FolderContainer.Image = 'rbxassetid://3570695787'
		FolderContainer.ImageColor3 = Color3.fromRGB(30, 30, 30)
		FolderContainer.ScaleType = Enum.ScaleType.Slice
		FolderContainer.SliceCenter = Rect.new(100, 100, 100, 100)
		FolderContainer.SliceScale = 0.040
		FolderContainer.ClipsDescendants = true
		FolderContainer.Visible = data.visible
		
		UIListLayout.Parent = FolderContainer
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		
		UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if Folder.toggled or data.showing then
				FolderContainer.Size = UDim2.new(1,0,0, UIListLayout.AbsoluteContentSize.Y)
			end
		end)
		
		local down = TweenService:Create( Image, TweenInfo.new(0.2),{ Rotation = 90 })
		local up = TweenService:Create( Image, TweenInfo.new(0.2),{ Rotation = 180 })
		Toggle.MouseButton1Click:Connect(function()
			Folder.toggled = not Folder.toggled
			FolderContainer.ClipsDescendants = true
			FolderContainer:TweenSize((Folder.toggled and UDim2.new(1,0,0, UIListLayout.AbsoluteContentSize.Y) or UDim2.new(1,0,0, 0)), nil, nil, 0.2, true)
			if Folder.toggled then
				down:Play()
			else
				up:Play()
			end
		end)
		
		function Folder:Destroy()
			Title:Destroy()
			FolderContainer:Destroy()
			down:Destroy()
			up:Destroy()
			for i,v in pairs(Folder.Objects) do
				v:Destroy()
			end
			for i,v in pairs(Folder) do
				v = nil
			end
			setmetatable(Folder,nil)
			Folder = nil
		end
		
		setmetatable(Folder, {
			__newindex = function(Table, index, value)
				if rawequal(Table, Folder) then
					if rawequal(index,'name') then
						if type(value)=='string' then
							Title.Text = value
							data.name = value
						else return end
					elseif rawequal(index,'showing') then
						if type(value)=='boolean' then
							FolderContainer.ClipsDescendants = true
							data.showing = value
							Folder.toggled = value
							if value then
								Image.Rotation = 90
								FolderContainer.Size = UDim2.new(1,0,0,UIListLayout.AbsoluteContentSize.Y)
							else
								Image.Rotation = 180
								FolderContainer.Size = UDim2.new(1,0,0,0)
							end
						else return end
					elseif rawequal(index,'visible') then
						data.visible = value
						Title.Visible = data.visible
						FolderContainer.Visible = data.visible
					else return end
				end
			end;
			__index = function(Table, index)
				if data[index] ~= nil then
					return data[index]
				end
			end;
			__tostring = function(Table)
				return data.name
			end;
		})
		table.insert(self.Objects,#self.Objects,Folder)
		return Folder
	end
	
	function Window:Destroy()
		Main:Destroy()
		down:Destroy()
		up:Destroy()
		for i,v in pairs(Window.Objects) do
			v:Destroy()
		end
		for i,v in pairs(Window) do
			v = nil
		end
		setmetatable(Window,nil)
		Window = nil
	end
	
	setmetatable(Window, {
		__newindex = function(Table, index, value)
			if rawequal(Table, Window) then
				if rawequal(index,'name') then
					if type(value)=='string' then
						Title.Text = value
						data.name = value
					else return end
				elseif rawequal(index,'showing') then
					if type(value)=='boolean' then
						Main.ClipsDescendants = true
						data.showing = value
						Window.toggled = value
						Image.Rotation =  value or 90 and 180
						Main.Size = (Window.toggled and UDim2.new(0,Main.Size.X.Offset,0, UIListLayout.AbsoluteContentSize.Y+2) or UDim2.new(0,Main.Size.X.Offset,0, 35))
					else return end
				elseif rawequal(index,'visible') then
					data.visible = value
					Main.Visible = data.visible
				end
			end
		end;
		__index = function(Table, index)
			if data[index] ~= nil then
				return data[index]
			end
		end;
		__tostring = function(Table)
			return data.name
		end;
	})
	
	table.insert(Library.Windows,#Library.Windows+1,Window)
	return Window
end
local CursorConnection = game:GetService('UserInputService').InputChanged:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		Library.MousePos = game:GetService('UserInputService'):GetMouseLocation() - Vector2.new(0, 36)
	end
end)

function Library:Destroy()
	for i,v in pairs(Library.Windows) do
		print(v)
		v:Destroy()
	end
	CursorConnection:Disconnect()
	ScreenGui:Destroy()
	Library = nil
end

return Library
