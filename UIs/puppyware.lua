local Library, Modules, Connection, Utilities = {}, {}, {}, {};
local fonts = {
    {"ProggyClean.ttf", "ProggyClean.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/ProggyClean.txt"},
    {"ProggyTiny.ttf", "ProggyTiny.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/ProggyTiny.txt"},
    {"Minecraftia.ttf", "Minecraftia.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/Minecraftia.txt"},
    {"SmallestPixel7.ttf", "SmallestPixel7.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/SmallestPixel7.txt"},
    {"Verdana.ttf", "Verdana.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/Verdana.txt"},
    {"VerdanaBold.ttf", "VerdanaBold.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/VerdanaBold.txt"},
    {"Tahoma.ttf", "Tahoma.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/Tahoma.txt"},
    {"TahomaBold.ttf", "TahomaBold.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/TahomaBold.txt"},
    {"CSGO.ttf", "CSGO.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/CSGO.txt"},
    {"WindowsXPTahoma.ttf", "WindowsXPTahoma.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/windows-xp-tahoma.ttf"},
    {"Stratum2.ttf", "Stratum2.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/Stratum2.txt"},
    {"Visitor.ttf", "Visitor.json", "https://raw.githubusercontent.com/suspendthread/uwu/refs/heads/main/dependencies/assets/fonts/Visitor.txt"},
}

for _, font in pairs(fonts) do
    local ttf, json, url = font[1], font[2], font[3]

    if not isfile(ttf) then
        local fontData = game:HttpGet(url)
        writefile(ttf, fontData) 
    end

    if not isfile(json) then
        local fontJson = {
            name = ttf:match("([^%.]+)"),
            faces = {
                {
                    name = "Regular",
                    weight = 200,
                    style = "normal",
                    assetId = getcustomasset(ttf)
                }
            }
        }
        writefile(json, game:GetService('HttpService'):JSONEncode(fontJson))
    end
end

local Enumed = {}
for _, font in pairs(fonts) do
    Enumed[font[1]:match("([^%.]+)")] = Font.new(getcustomasset(font[2]), Enum.FontWeight.Regular)
end

function getfontfromname(fontName) return Enumed[fontName] end

local Services = setmetatable({}, {
    __index = function(t, k)
        if k == "game" then
            return game;
        else
            return game:GetService(k);
        end
    end
})

local Players = Services.Players;
local ReplicatedStorage = Services.ReplicatedStorage;
local Workspace = Services.Workspace;
local RunService = Services.RunService;
local TweenService = Services.TweenService;
local UserInputService = Services.UserInputService;
local Lighting = Services.Lighting;
local Stats = Services.Stats;
local HttpService = Services.HttpService;
local TextService = Services.TextService;
local CoreGui = Services.CoreGui;

local Camera = Workspace.CurrentCamera;
local Client = Players.LocalPlayer;
local Mouse = UserInputService:GetMouseLocation()

Library = {
    Start = os.clock(),
    Debug = false,
    Fonts = {
        Main = '';
    },
    Images = {
        Main = '';
    },
    Colors = {
        Accent = Color3.fromRGB(165, 204, 237),
        Text = {
            Section = {
                Title = Color3.fromRGB(85, 85, 85),
                Element = Color3.fromRGB(136, 136, 136);
            } 

        },
        Selected = Color3.fromRGB(0,0,0),
        Deselected = Color3.fromRGB(0,0,0);
    },

    Active = false,
    Flags = {},
    UnnamedFlags = {},
    Fps = 0,
    Ping = 0,
    Connections = {},
    Directories = {
        'pupware',
        'pupware/configs'
    },
    Tabs = nil,
	Dragging = nil,
	Holder = nil,
    Keys = {
		[Enum.KeyCode.Space] = "space",
		[Enum.KeyCode.Return] = "return",
		[Enum.KeyCode.Escape] = "esc",
		[Enum.KeyCode.LeftShift] = "lshift",
		[Enum.KeyCode.RightShift] = "rshift",
		[Enum.KeyCode.LeftControl] = "lctrl",
		[Enum.KeyCode.RightControl] = "rctrl",
		[Enum.KeyCode.LeftAlt] = "lalt",
		[Enum.KeyCode.RightAlt] = "ralt",
		[Enum.KeyCode.CapsLock] = "caps",
		[Enum.KeyCode.Backspace] = "bksp",
		[Enum.KeyCode.One] = "1",
		[Enum.KeyCode.Two] = "2",
		[Enum.KeyCode.Three] = "3",
		[Enum.KeyCode.Four] = "4",
		[Enum.KeyCode.Five] = "5",
		[Enum.KeyCode.Six] = "6",
		[Enum.KeyCode.Seven] = "7",
		[Enum.KeyCode.Eight] = "8",
		[Enum.KeyCode.Nine] = "9",
		[Enum.KeyCode.Zero] = "0",
		[Enum.KeyCode.KeypadOne] = "num1",
		[Enum.KeyCode.KeypadTwo] = "num2",
		[Enum.KeyCode.KeypadThree] = "num3",
		[Enum.KeyCode.KeypadFour] = "num4",
		[Enum.KeyCode.KeypadFive] = "num5",
		[Enum.KeyCode.KeypadSix] = "num6",
		[Enum.KeyCode.KeypadSeven] = "num7",
		[Enum.KeyCode.KeypadEight] = "num8",
		[Enum.KeyCode.KeypadNine] = "num9",
		[Enum.KeyCode.KeypadZero] = "num0",
		[Enum.KeyCode.Minus] = "-",
		[Enum.KeyCode.Equals] = "=",
		[Enum.KeyCode.Tilde] = "~",
		[Enum.KeyCode.LeftBracket] = "[",
		[Enum.KeyCode.RightBracket] = "]",
		[Enum.KeyCode.RightParenthesis] = ")",
		[Enum.KeyCode.LeftParenthesis] = "(",
		[Enum.KeyCode.Semicolon] = ",",
		[Enum.KeyCode.Quote] = "'",
		[Enum.KeyCode.BackSlash] = "\\",
		[Enum.KeyCode.Comma] = ",",
		[Enum.KeyCode.Period] = ".",
		[Enum.KeyCode.Slash] = "/",
		[Enum.KeyCode.Asterisk] = "*",
		[Enum.KeyCode.Plus] = "+",
		[Enum.KeyCode.Backquote] = "`",
		[Enum.UserInputType.MouseButton1] = "m1",
		[Enum.UserInputType.MouseButton2] = "m2",
		[Enum.UserInputType.MouseButton3] = "m3"
	},
    Games = {
        [5034043434] = 'Placeholder'
    };
}

--
Utility = Utility or {}
local Flags = {};
--

if Utility then
    Utility.new = function(Class, Props)
        local Instance = Instance.new(Class);
		if Props then
			for prop, v in pairs(Props) do
				Instance[prop] = v;
			end
		end
		return Instance;
    end;

    Utility.Connection = function(signal, callback)
        local connection = signal:Connect(callback);
        return connection;
    end

    Utility.Disconnect = function(Connection)
        Connection:Disconnect();
    end
    Utility.Connection = function(signal, callback)
        local connection = signal:Connect(callback)
        return connection
    end
    
    Utility.RenderFunctions = {}

    Utility.ManageRenderStepped = function(name, func)
        if func then
            Utility.RenderFunctions[name] = func
        else
            Utility.RenderFunctions[name] = nil 
        end
    end

    Utility.IsMouseOver = function(Obj)
        local abs_pos, abs_size = Obj.AbsolutePosition, Obj.AbsoluteSize;
        if Mouse then
            if Mouse.X >= abs_pos.X and Mouse.X <= abs_pos.X + abs_size.X and Mouse.Y >= abs_pos.Y and Mouse.Y <= abs_pos.Y + abs_size.Y then
                return true;
            end
        else
            Mouse = UserInputService:GetMouseLocation();
        end
    end

    Utility.Drag = function(Obj)
        local Drag_in, Drag_st, StartPos;

        function Update(Input)
            local Delta; Delta = Input.Position - Drag_st
            Obj.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        end

        Obj.InputBegan:Connect(function(Input)
            if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
                Library.Dragging = true
                Drag_st = Input.Position
                StartPos = Obj.Position
                Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Library.Dragging = false
                    end
                end)
            end
        end)

        Obj.InputChanged:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                Drag_in = Input
            end
        end)
    
        game:GetService('UserInputService').InputChanged:Connect(function(Input)
            if Input == Drag_in and Library.Dragging then
                Update(Input)
            end
        end)
    end;

    Utility.Round = function(Int, Float)
        return Float * math.floor(Int / Float)
    end

    Utility.AutoCenter = function(Obj)
        Obj.AnchorPoint = Vector2.new(0.5,0.5);
        Obj.Position = UDim2.new(0.5,0,0.5,0);  
    end
    Utility.Typewriter = function(Obj, Text, Speed, Rep)
        Rep = Rep or true
        Obj.Text = ''
        Speed = Speed or 0.05
    
        local function typewrite(txt)
            for i = 1, #txt do
                Obj.Text = string.sub(txt, 1, i)
                task.wait(Speed)
            end
        end
        coroutine.wrap(function()
            repeat
                if typeof(Text) == 'string' then
                    typewrite(Text)
                elseif typeof(Text) == 'table' then
                    for _, txt in ipairs(Text) do
                        typewrite(txt)
                        task.wait(1)
                    end
                end
                task.wait(1)
            until not Rep
        end)()
    end

    Utility.HandleLeftClick = function(Obj, Callback)
        Obj.InputBegan:Connect(function(InputObject)
            if InputObject.UserInputType == Enum.UserInputType.MouseButton1 then
                Callback()
            end
        end)
    end

    Utility.HandleRightClick = function(Obj, Callback)
        Obj.InputBegan:Connect(function(InputObject)
            if InputObject.UserInputType == Enum.UserInputType.MouseButton2 then
                Callback()
            end
        end)
    end

    Utility.ShowUI = function(Obj, Boolean)
        Obj.Visible = (Boolean or false)
    end
else
    Utility = {};
end

local Holder = Utility.new("ScreenGui", {
    Name = '2uhn35r23uji4n23iu423jn4i23o';
    ResetOnSpawn = false;
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    Parent = gethui and gethui() or CoreGui;
});
local RealNotificationHolder = Utility.new("ScreenGui", {
    Name = '2uhn3523423r23uji4n23iu423jn4i23o';
    ResetOnSpawn = false;
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    Parent = gethui and gethui() or CoreGui;
});
Library.Holder = Holder

if Library.Holder then
    --
    RunService = (RunService or game:GetService('RunService'));
    local LastTime = tick()

    local connection
    connection = Utility.Connection(RunService.RenderStepped, function()
        local Ping = Stats['Network'].ServerStatsItem['Data Ping']:GetValue()
        local CurrentTime = tick()
        
        if Ping > 0 then
            Library.Ping = Ping
        end
        
        Library.Fps = math.floor(1 / (CurrentTime - LastTime))
        LastTime = CurrentTime

        --
        for _, func in pairs(Utility.RenderFunctions) do
            func()
        end
        --
    end)
    --
    function Library.Window(Params)
        local Window, Strokes, Gradient = {}, {}, {};
        local Padding, Layout, TextLabel = {}, {}, {};

        --// Handling
        local Events, Input, State, Cache = {}, {}, {}, {};

        function Utility.Add(Type, Parent, Properties)
            local UID = Parent.Name .. "_" .. (Parent.Parent and Parent.Parent.Name or "Root")
            
            local Element = Utility.new(Type, Properties)
            Element.Parent = Parent  
        
            if Type == "UIStroke" then
                Strokes[UID] = Element
            elseif Type == "UIGradient" then
                Gradient[UID] = Element
            elseif Type == "UIListLayout" then
                Layout[UID] = Element
            elseif Type == "UIPadding" then
                Padding[UID] = Element
            end
        
            return Element
        end

        Window["1"] = Utility.new("Frame", {
            Name = "Core",
            Size = UDim2.new(0, 625, 0, 415),
            BackgroundColor3 = Color3.fromRGB(27, 27, 27),
            Parent = Library.Holder
        })
        --
            Utility.Drag(Window["1"])
            Utility.AutoCenter(Window["1"])
        --
        Utility.Add("UIStroke", Window["1"], {
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            LineJoinMode = Enum.LineJoinMode.Miter,
            Color = Color3.fromRGB(2, 2, 2);
        })

        Window["2"] = Utility.new("Frame", {
            Name = "_Inline",
            Size = UDim2.new(1, -2, 1, -2),
            BackgroundColor3 = Color3.fromRGB(27, 27, 27),
            Parent = Window["1"];
        })

        Utility.AutoCenter(Window["2"])

        Utility.Add("UIStroke", Window["2"], {
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            LineJoinMode = Enum.LineJoinMode.Miter,
            Color = Color3.fromRGB(38, 38, 38);
        })
        
        Window["3"] = Utility.new("Frame", {
            Name = "_Inline2",
            Size = UDim2.new(1, -6, 1, -6),
            BackgroundColor3 = Color3.fromRGB(17, 17, 17),
            Parent = Window["2"];
        })

        Utility.AutoCenter(Window["3"])

        Utility.Add("UIStroke", Window["3"], {
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            LineJoinMode = Enum.LineJoinMode.Miter,
            Color = Color3.fromRGB(38, 38, 38);
        })

        Window["4"] = Utility.new("Frame", {
            Name = "TopBar",
            Size = UDim2.new(0, 520, 0, 35),
            Position = UDim2.new(0, 5, 0, 5),
            BackgroundColor3 = Color3.fromRGB(21, 21, 21),
            Parent = Window["3"];
        })

        Utility.Add("UIStroke", Window["4"], {
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            LineJoinMode = Enum.LineJoinMode.Miter,
            Color = Color3.fromRGB(38, 38, 38);
        })

        Window["5"] = Utility.new("Frame", {
            Name = "TopBar_RealContainer",
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            Parent = Window["4"];
        })
        Utility.AutoCenter(Window['5'])
        Utility.Add("UIListLayout", Window["5"], {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            Padding = UDim.new(0, 4),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalFlex = Enum.UIFlexAlignment.Fill
        })
        Utility.Add("UIPadding", Window["5"], {
            PaddingLeft = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10);
        })

        Window['6'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "Outline",
            Size = UDim2.new(1, 2, 1, 2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['4']
        })

        Utility.Add("UIStroke", Window['6'], {
            Color = Color3.fromRGB(17, 17, 13),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
        
        Window['7'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "Inline",
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['4']
        })
        
        Utility.Add("UIStroke", Window['7'], {
            Color = Color3.fromRGB(17, 17, 13),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        })

        Window['8'] = Utility.new("Frame", {
            Name = "SideBar",
            Position = UDim2.new(0.008103727363049984, 0, 0.11302211135625839, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(0, 82, 0, 356),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(21, 21, 21),
            Parent = Window["3"]
        })
        
        Utility.Add("UIStroke", Window['8'], {
            Color = Color3.fromRGB(38, 38, 38),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
        
        Window['9'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "RealContainer",
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window["8"]
        })
        
        Utility.Add("UIListLayout", Window['9'], {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalFlex = Enum.UIFlexAlignment.Fill,
            Padding = UDim.new(0, -40)
        })

        Window['10'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "Outline",
            Size = UDim2.new(1, 2, 1, 2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['8']
        })

        Utility.Add("UIStroke", Window['10'], {
            Color = Color3.fromRGB(17, 17, 13),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
        
        Window['11'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "Inline",
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['8']
        })
        
        Utility.Add("UIStroke", Window['11'], {
            Color = Color3.fromRGB(17, 17, 13),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        })

        Window['12'] = Utility.new("Frame", {
            Name = "TitleHolder",
            Position = UDim2.new(0, 531, 0, 5),
            BorderColor3 = Color3.fromRGB(255,255,255),
            Size = UDim2.new(0, 81, 0, 35),
            BorderSizePixel = 0,
            BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(21, 21, 21),
            Parent = Window['3']
        })

        Utility.Add("UIStroke", Window['12'], {
            Color = Color3.fromRGB(38, 38, 38),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
        
        Window['13'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "Outline",
            Size = UDim2.new(1, 2, 1, 2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['12']
        })
        
        Utility.Add("UIStroke", Window['13'], {
            Color = Color3.fromRGB(17, 17, 13),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
        
        Window['14'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "Inline",
            Size = UDim2.new(1, -2, 1, -2),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['12']
        })
        
        Utility.Add("UIStroke", Window['14'], {
            Color = Color3.fromRGB(17, 17, 13),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })

        Window['15'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "RealContainer",
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['12']
        })

        Window['16'] = Utility.new("Frame", {
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Name = "TabHolder",
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['15']
        })
        
        TextLabel['1'] = Utility.new("TextLabel", {
            FontFace = getfontfromname('WindowsXPTahoma'),
            TextColor3 = Color3.fromRGB(165, 204, 237),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Text = Params.Name,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Name = "hj25n2j52n5j34io25n2io",
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 0,
            TextSize = 12,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['16']
        })

        Window['17'] = Utility.new("Frame", {
            Name = "Container",
            Position = UDim2.new(0.1507, 0, 0.113, 0),
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Size = UDim2.new(0, 519, 0, 356),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(21, 21, 21),
            Parent = Window["3"]
        })
        
        Utility.Add("UIStroke", Window['17'], {
            Color = Color3.fromRGB(38, 38, 38),
            LineJoinMode = Enum.LineJoinMode.Miter,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })
        local Image = Utility.new("ImageLabel", {
            ScaleType = Enum.ScaleType.Fit,
            ImageTransparency = 0.25,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Image",
            AnchorPoint = Vector2.new(1, 0),
            Image = "rbxassetid://94841178482304",
            BackgroundTransparency = 1,
            Position = UDim2.new(1.200385332107544, 0, 0, 0),
            Size = UDim2.new(0.700385332107544, 0, 1.0449438095092773, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['17']
        })
        Window['18'] = Utility.new("Frame", {
            Name = "RealContainer",
            ClipsDescendants = true,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(21, 21, 21),
            Parent = Window['17']
        })
        
        Utility.Add("UIListLayout", Window['18'], {
            Wraps = true,
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            Padding = UDim.new(0, -12),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalFlex = Enum.UIFlexAlignment.Fill
        })

        Window['19'] = Utility.new("Frame", {
            Name = "1",
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.005780346691608429, 0, 0.05056179687380791, 0),
            Size = UDim2.new(0, 100, 0, 100),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['18']
        })
        
        Utility.Add("UIListLayout", Window['19'], {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            ItemLineAlignment = Enum.ItemLineAlignment.Stretch
        })
        
        Utility.Add("UIPadding", Window['19'], {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12)
        })
        
        Window['20'] = Utility.new("Frame", {
            Name = "2",
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.005780346691608429, 0, 0.05056179687380791, 0),
            Size = UDim2.new(0, 100, 0, 100),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['18']
        })
        
        Utility.Add("UIListLayout", Window['20'], {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            ItemLineAlignment = Enum.ItemLineAlignment.Stretch
        })
        
        Utility.Add("UIPadding", Window['20'], {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12)
        })
        
        Window['21'] = Utility.new("Frame", {
            Name = "3",
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(0.005780346691608429, 0, 0.05056179687380791, 0),
            Size = UDim2.new(0, 100, 0, 100),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = Window['18']
        })
        
        Utility.Add("UIListLayout", Window['21'], {
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            ItemLineAlignment = Enum.ItemLineAlignment.Stretch
        })
        
        Utility.Add("UIPadding", Window['21'], {
            PaddingTop = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12)
        })

        function Window.Tab(Props)
            if not Props then Props = {} end
        
            if not Window.Tabs then
                Window.Tabs = {}
            end
        
            if not Window.ActiveTab then
                Window.ActiveTab = nil
            end
        
            local Tab = {
                Window = Window,
                Bar = Props.Side or Props.side or 'Top',
                Name = Props.Name or Props.name or "tab",
                Active = false,
                Properties = {},
                Sections = {},
                Default = Props.Default or false
            }
        
            local Container
            local Accent
        
            if Tab.Bar == 'Top' then
                Container = Window["5"]
            elseif Tab.Bar == 'Side' then
                Container = Window['9']
            end
        
            local TabHolder = Utility.new("Frame", {
                BackgroundTransparency = 1,
                Name = "TabHolder",
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Size = UDim2.new(0, 100, 0, 100),
                BorderSizePixel = 0,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Parent = Container
            })
        
            local Text = Utility.new("TextLabel", {
                FontFace = getfontfromname('WindowsXPTahoma'),
                TextColor3 = Library.Colors.Text.Section.Element,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Name = "Text",
                Text = Tab.Name,
                Position = UDim2.new(0.5, 0, 0.5, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Parent = TabHolder
            })
        
            Utility.AutoCenter(Text)
            Utility.Add('UIStroke', Text)
        
            if Tab.Bar == 'Top' then
                Accent = Utility.new("Frame", {
                    AnchorPoint = Vector2.new(1, 0),
                    Name = "Accent",
                    Position = UDim2.new(1, 0, 0, 1),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Library.Colors.Text.Section.Element,
                    Parent = TabHolder
                })
        
                local UIGradient = Utility.new("UIGradient", {
                    Rotation = -90,
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                    },
                    Parent = Accent
                })
            else
                Accent = nil
            end
        
            Tab.TabHolder = TabHolder
        
            Utility.HandleLeftClick(TabHolder, function()

				print("Tab clicked: " .. Tab.Name)

                if Window.ActiveTab then
                    Window.ActiveTab.Active = false
                    local OldText = Window.ActiveTab.TabHolder:FindFirstChild('Text')
                    local OldAccent = Window.ActiveTab.TabHolder:FindFirstChild('Accent')
        
                    if OldText then
                        OldText.TextColor3 = Library.Colors.Text.Section.Element
                    end
                    if OldAccent then
                        OldAccent.BackgroundColor3 = Library.Colors.Text.Section.Element
                    end
        
                    -- Hide sections of the previously active tab
					for _, Sec in ipairs(Window.ActiveTab.Sections) do
						if Sec.NotRealContainer then
							Sec.NotRealContainer.Visible = false
							print("Hiding section: " .. Sec.Name)  -- Debugging: Log section hiding
						end
					end
                end
        
                Tab.Active = true
                Window.ActiveTab = Tab
        
                local TabText = TabHolder:FindFirstChild('Text')
                local TabAccent = TabHolder:FindFirstChild('Accent')
        
                if TabText then
                    TabText.TextColor3 = Library.Colors.Accent
                end
        
                if TabAccent then
                    TabAccent.BackgroundColor3 = Library.Colors.Accent
                end
        
                for _, Sec in ipairs(Tab.Sections) do
                    if Sec.NotRealContainer then
                        Sec.NotRealContainer.Visible = true
                        print("Showing section: " .. Sec.Name)  -- Debugging: Log section showing
                    end
                end
            end)
        
            if Tab.Default then
                if Window.ActiveTab then
                    Window.ActiveTab.Active = false
                    local OldText = Window.ActiveTab.TabHolder:FindFirstChild('Text')
                    local OldAccent = Window.ActiveTab.TabHolder:FindFirstChild('Accent')
        
                    if OldText then
                        OldText.TextColor3 = Library.Colors.Text.Section.Element
                    end
                    if OldAccent then
                        OldAccent.BackgroundColor3 = Library.Colors.Text.Section.Element
                    end
                end
        
                Tab.Active = true
                Window.ActiveTab = Tab
        
                local TabText = TabHolder:FindFirstChild('Text')
                local TabAccent = TabHolder:FindFirstChild('Accent')
        
                if TabText then
                    TabText.TextColor3 = Library.Colors.Accent
                end
        
                if TabAccent then
                    TabAccent.BackgroundColor3 = Library.Colors.Accent
                end
        
                for _, Sec in ipairs(Tab.Sections) do
                    if Sec.NotRealContainer then
                        Sec.NotRealContainer.Visible = true
                        print("Showing section (default): " .. Sec.Name)  -- Debugging: Log section showing
                    end
                end
            end
        
            function Tab.Section(Props)
                if not Props then Props = {} end
        
                local Section = {
                    Tab = Tab,
                    Name = (Props.Name or Props.name) or 'Sigma',
                    Side = (Props.Side or Props.side) or 'Left',
                    Properties = {}
                }
        
                local Container
                if Section.Side == 'Left' then
                    Container = Window['19']
                elseif Section.Side == 'Center' then
                    Container = Window['20']
                elseif Section.Side == 'Right' then
                    Container = Window['21']
                end
        
                local NotRealContainer = Utility.new('Frame', {
                    Size = UDim2.new(0, 168, 0, 100),
                    Name = 'NotRealContainer',
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 0.2,
                    BackgroundColor3 = Color3.fromRGB(21, 21, 21),
					Visible = false,
                    Parent = Container
                })

                Section.NotRealContainer = NotRealContainer

                Utility.Add('UIStroke', NotRealContainer, {
                    Color = Color3.fromRGB(38, 38, 38),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
        
                local Outline = Utility.new('Frame', {
                    Size = UDim2.new(1, 2, 1, 2),
                    BackgroundTransparency = 1,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = NotRealContainer
                })
        
                Utility.Add('UIStroke', Outline, {
                    Color = Color3.fromRGB(17, 17, 13),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
        
                local Inline = Utility.new('Frame', {
                    Size = UDim2.new(1, -2, 1, -2),
                    BackgroundTransparency = 1,
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = NotRealContainer
                })
        
                Utility.Add('UIStroke', Inline, {
                    Color = Color3.fromRGB(17, 17, 13),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
        
                local ActualSection = Utility.new('Frame', {
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Name = "ActualContainer",
                    Size = UDim2.new(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Parent = NotRealContainer
                })
        
                local Padding = Utility.Add('UIPadding', ActualSection, {
                    PaddingTop = UDim.new(0, 12),
                    PaddingBottom = UDim.new(0, 12),
                    PaddingRight = UDim.new(0, 9),
                    PaddingLeft = UDim.new(0, 9)
                })
        
                local ListLayout = Utility.Add('UIListLayout', ActualSection, {
                    Padding = UDim.new(0, 9),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                local function UpdateSectionSize()
                    local contentSize = ListLayout.AbsoluteContentSize.Y
                    local paddingSize = Padding.PaddingTop.Offset + Padding.PaddingBottom.Offset
                    NotRealContainer.Size = UDim2.new(0, 168, 0, math.max(contentSize + paddingSize, 30))
                end
                
                ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSectionSize)
                UpdateSectionSize() 

                local TitleHolder = Utility.new('Frame', {
                    Size = UDim2.new(0, 67, 0, 11),
                    Name = "TitleHolder",
                    Position = UDim2.new(0, 5, 0, -7),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = Color3.fromRGB(21, 21, 21),
                    Parent = NotRealContainer
                })
        
                local Text = Utility.new('TextLabel', {
                    FontFace = getfontfromname('WindowsXPTahoma'),
                    TextColor3 = Color3.fromRGB(85, 85, 85),
                    BorderColor3 = Color3.fromRGB(0, 0, 0),
                    Text = Tab.Name,
                    Name = "Text",
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 12,
                    BackgroundColor3 = Color3.fromRGB(21, 21, 21),
                    Parent = TitleHolder
                })
        
                TitleHolder.Size = UDim2.new(0, Text.TextBounds.X + 12, 0, Text.TextBounds.Y)
        
                table.insert(Tab.Sections, Section)

                function Section.Toggle(Props)
                    if not Props then Props = {} end;
                    local Toggle = {
                        Name = Props.name or Props.Name or 'toggle',
                        Flag = Props.flag or Props.Flag or math.random(1, math.random(1, 1000)),
                        State = Props.state or Props.State or false,
                        Callback = Props.Callback or Props.callback or function() end,
                        Pickers = 0
                    }

                    local ToggleHolder = Utility.new("Frame", {
                        Name = "ToggleHolder",
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0, 8, 0, 8),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(42, 42, 42),
                        Parent = ActualSection
                    })
                    
                    Utility.Add('UIStroke', ToggleHolder, {
                        Color = Color3.fromRGB(38, 38, 38),
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    })
                    
                    local Outline = Utility.new("Frame", {
                        Name = "Outline",
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, 2, 1, 2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = ToggleHolder
                    })
                    
                    Utility.Add('UIStroke', Outline, {
                        Color = Color3.fromRGB(17, 17, 13),
                        LineJoinMode = Enum.LineJoinMode.Miter,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    })
                    
                    Utility.Add('UIGradient', ToggleHolder, {
                        Rotation = -90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                        }
                    })
                    
                    local TextLabel = Utility.new("TextLabel", {
                        Text = Toggle.Name,
                        FontFace = getfontfromname('WindowsXPTahoma'),
                        TextColor3 = Color3.fromRGB(136, 136, 136),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        AnchorPoint = Vector2.new(0, 0.5),
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Position = UDim2.new(0, 20, 0.5, -1),
                        Size = UDim2.new(1, 100, 1, 15),
                        BorderSizePixel = 0,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = ToggleHolder
                    })

                    local function UpdateToggle(state)
                        Library.Flags[Toggle.Flag] = state
                        ToggleHolder.BackgroundColor3 = state and Library.Colors.Accent or Color3.fromRGB(42, 42, 42)
                        Toggle.Callback(state)
                    end
                
                    Utility.HandleLeftClick(ToggleHolder, function()
                        UpdateToggle(not Library.Flags[Toggle.Flag])
                    end)

                    UpdateToggle(Toggle.State)

                    function Toggle.Keybind(Props)
                        if not Props then Props = {} end
                        local Keybind = {
                            Name = Props.Name or 'keybind',
                            Flag = Props.Flag or math.random(1000),
                            Mode = Props.Mode or 'Toggle',
                            ModeChangeable = Props.ModeChangeable or false,
                            Key = nil,
                            Callback = Props.Callback or function() end
                        }
                    
                        local KeybindHolder = Utility.new("Frame", {
                            Name = "KeybindHolder",
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(1, 110, 0.5, -1),
                            Size = UDim2.new(0, 20, 0, 10),
                            BorderSizePixel = 0,
                            BackgroundColor3 = Color3.fromRGB(48, 48, 48),
                            Parent = ToggleHolder
                        })
                    
                        Utility.Add('UIGradient', KeybindHolder, { Rotation = -90, Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) } })
                        Utility.Add('UIStroke', KeybindHolder, { Color = Color3.fromRGB(17, 17, 13), LineJoinMode = Enum.LineJoinMode.Miter, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
                    
                        local TextLabel = Utility.new("TextLabel", {
                            Text = ". . .",
                            FontFace = getfontfromname('WindowsXPTahoma'),
                            TextColor3 = Color3.fromRGB(136, 136, 136),
                            BorderColor3 = Color3.fromRGB(0, 0, 0),
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0.5, 0, 0.5, 0),
                            Size = UDim2.new(1, 0, 1, 0),
                            TextSize = 12,
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            Parent = KeybindHolder
                        })
                    
                        Utility.Add('UIPadding', TextLabel, { PaddingBottom = UDim.new(0, 1), PaddingLeft = UDim.new(0, 1) })

                        if Keybind.ModeChangeable then
                            local KeybindModeHolder = Utility.new("Frame", {
                                Name = "KeybindModeHolder",
                                AnchorPoint = Vector2.new(0, 0.5),
                                Position = UDim2.new(1, 135, 0.5, 12),
                                Size = UDim2.new(0, 40, 0, 36),
                                BorderSizePixel = 0,
                                BackgroundColor3 = Color3.fromRGB(48, 48, 48),
                                Visible = false,
                                Parent = ToggleHolder
                            })
                        
                            Utility.Add('UIGradient', KeybindModeHolder, { Rotation = -90, Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) } })
                            Utility.Add('UIStroke', KeybindModeHolder, { Color = Color3.fromRGB(17, 17, 13), LineJoinMode = Enum.LineJoinMode.Miter, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
                            Utility.Add("UIListLayout", KeybindModeHolder, {
                                Padding = UDim.new(0, 2),
                                FillDirection = Enum.FillDirection.Vertical,
                                SortOrder = Enum.SortOrder.LayoutOrder
                            })

                            local HoldLabel = Utility.new("TextLabel", {
                                Text = "Hold",
                                FontFace = getfontfromname('WindowsXPTahoma'),
                                TextColor3 = Color3.fromRGB(136, 136, 136),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0.5, 0, 0.5, 0),
                                Size = UDim2.new(1, 0, 0, 10),
                                TextSize = 12,
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                Parent = KeybindModeHolder
                            })

                            local ToggleLabel = Utility.new("TextLabel", {
                                Text = "Toggle",
                                FontFace = getfontfromname('WindowsXPTahoma'),
                                TextColor3 = Color3.fromRGB(136, 136, 136),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0.5, 0, 0.5, 0),
                                Size = UDim2.new(1, 0, 0, 10),
                                TextSize = 12,
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                Parent = KeybindModeHolder
                            })

                            local AlwaysLabel = Utility.new("TextLabel", {
                                Text = "Always",
                                FontFace = getfontfromname('WindowsXPTahoma'),
                                TextColor3 = Color3.fromRGB(136, 136, 136),
                                BorderColor3 = Color3.fromRGB(0, 0, 0),
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0.5, 0, 0.5, 0),
                                Size = UDim2.new(1, 0, 0, 10),
                                TextSize = 12,
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                Parent = KeybindModeHolder
                            })

                            local KeybindLabels = {
                                Toggle = ToggleLabel,
                                Hold = HoldLabel,
                                Always = AlwaysLabel
                            }

                            local function UpdateLabels()
                                for index, value in pairs(KeybindLabels) do
                                    if index == Keybind.Mode then
                                        value.TextColor3 = Library.Colors.Accent
                                    else
                                        value.TextColor3 = Color3.fromRGB(136, 136, 136)
                                    end
                                end
                            end

                            UpdateLabels()

                            Utility.HandleRightClick(KeybindHolder, function()
                                KeybindModeHolder.Visible = not KeybindModeHolder.Visible

                                if KeybindHolder.Visible then
                                    local Connection;
                                    Connection = game:GetService("UserInputService").InputBegan:Connect(function(Input, Processed)
                                        if not Processed and Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                            KeybindModeHolder.Visible = false
                                            Connection:Disconnect()
                                        end
                                    end)
                                end
                            end)

                            Utility.HandleLeftClick(HoldLabel, function()
                                Keybind.Mode = 'Hold'

                                KeybindModeHolder.Visible = false
                                UpdateLabels()
                                UpdateToggle(false)
                            end)

                            Utility.HandleLeftClick(ToggleLabel, function()
                                Keybind.Mode = 'Toggle'

                                KeybindModeHolder.Visible = false
                                UpdateLabels()
                                UpdateToggle(false)
                            end)

                            Utility.HandleLeftClick(AlwaysLabel, function()
                                Keybind.Mode = 'Always'

                                KeybindModeHolder.Visible = false
                                UpdateLabels()
                                UpdateToggle(true)
                            end)
                        end

                        Utility.HandleLeftClick(KeybindHolder, function()
                            TextLabel.Text = "..."
                            local Connection;
                            Connection = game:GetService("UserInputService").InputBegan:Connect(function(Input, Processed)
                                if not Processed and Input.UserInputType == Enum.UserInputType.Keyboard then
                                    Keybind.Key = Input.KeyCode
                                    TextLabel.Text = Keybind.Key.Name
                                    Connection:Disconnect()
                                end
                            end)
                        end)
                
                        game:GetService("UserInputService").InputBegan:Connect(function(Input, Processed)
                            if not Processed and Input.KeyCode == Keybind.Key then
                                if Keybind.Mode == 'Toggle' then
                                    UpdateToggle(not Library.Flags[Toggle.Flag])
                                elseif Keybind.Mode == 'Hold' then
                                    UpdateToggle(true)
                                end
                            end
                        end)

                        game:GetService("UserInputService").InputEnded:Connect(function(Input, Processed)
                            if not Processed and Input.KeyCode == Keybind.Key then
                                if Keybind.Mode == 'Hold' then
                                    UpdateToggle(false)
                                end
                            end
                        end)

                        return Keybind
                    end

                    return Toggle
                end
                function Section.Slider(Props)
                    if not Props then Props = {} end;
                    local Slider = {
						Name = Props.name or Props.Name or 'slider',
						Min = Props.min or Props.Min or 1,
						Max = Props.max or Props.Max or 10,
						Decimals = Props.Decimals or Props.decimals or 1,
						Suffix = Props.suffix or Props.Suffix or '',
						State = Props.default or Props.Default or 5,
						Flag = Props.Flag or Props.flag or math.random(1,math.random(1,1000)),
						Callback = Props.callback or Props.Callback or function() end 
					}

                    local SliderHolder = Utility.new("Frame", {
                        Name = "SliderHolder",
                        BackgroundTransparency = 1,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0, 139, 0, 24),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = ActualSection
                    })
                    
                    local SliderCore = Utility.new("Frame", {
                        Active = true,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        AnchorPoint = Vector2.new(0, 1),
                        Name = "SliderCore",
                        Position = UDim2.new(0, 0, 1, 0),
                        Size = UDim2.new(1, -1, -0.5, 18),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                        Parent = SliderHolder
                    })
                    
                    Utility.Add("UIGradient", SliderCore, {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(185, 185, 185)),
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(185, 185, 185))
                        }
                    })
                    
                    Utility.Add("UIStroke", SliderCore, {
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter
                    })
                    
                    local SliderFill = Utility.new("Frame", {
                        AnchorPoint = Vector2.new(0, 0.5),
                        Name = "SliderFill",
                        Position = UDim2.new(0, 0, 0.5, 0),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(1, -50, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(165, 204, 237),
                        Parent = SliderCore
                    })
                    
                    Utility.Add("UIGradient", SliderFill, {
                        Rotation = -90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(54, 54, 54)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                        }
                    })
                    
                    local Dragger = Utility.new("Frame", {
                        AnchorPoint = Vector2.new(0, 0.5),
                        Name = "Dragger",
                        Position = UDim2.new(1, -2, 0.5, 0),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Size = UDim2.new(0, 2, 0, 6),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(165, 204, 237),
                        Parent = SliderFill
                    })
                    
                    Utility.Add("UIGradient", Dragger, {
                        Rotation = -90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(54, 54, 54)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                        }
                    })
                    
                    local Text = Utility.new("TextLabel", {
                        FontFace = getfontfromname'WindowsXPTahoma',
                        TextColor3 = Color3.fromRGB(136, 136, 136),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = "Text",
                        Text = Slider.Name .. ": " .. Slider.State .. "%",
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Size = UDim2.new(0, 139, 0, 17),
                        BorderSizePixel = 0,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = SliderHolder
                    })
                    
                    Utility.Add("UIPadding", Text, {
                        PaddingLeft = UDim.new(0, 1)
                    })

                    local Sliding = false
					local Val = Slider.State

					local function Set(value)
						value = math.clamp(math.round(value, Slider.Decimals), Slider.Min, Slider.Max)

						SliderFill.Size = UDim2.new(((value - Slider.Min) / (Slider.Max - Slider.Min)), 0, 1, 0)
						Text.Text = Slider.Name .. ": " .. string.format("%.14g", value) .. Slider.Suffix
                        -- Text.Text should be Slider.Name .. ": " .. Slider.State .. "%",
						Val = value

						Library.Flags[Slider.Flag] = value
						Slider.Callback(value)
					end				
					--
					local function ISlide(input)
						local sizeX = (input.Position.X - SliderCore.AbsolutePosition.X) / SliderCore.AbsoluteSize.X
						local value = ((Slider.Max - Slider.Min) * sizeX) + Slider.Min
						Set(value)
					end

					Dragger.InputBegan:Connect(function(inp)
						if inp.UserInputType == Enum.UserInputType.MouseButton1 then
							Sliding = true 
							Library.Dragging = nil
							ISlide(inp)
						end
					end)

					Dragger.InputEnded:Connect(function(inp)
						if inp.UserInputType == Enum.UserInputType.MouseButton1 then
							Sliding = false 
						end
					end)

					SliderCore.InputBegan:Connect(function(inp)
						if inp.UserInputType == Enum.UserInputType.MouseButton1 then
							Sliding = true 
							Library.Dragging = nil
							ISlide(inp)
						end
					end)

					SliderCore.InputEnded:Connect(function(inp)
						if inp.UserInputType == Enum.UserInputType.MouseButton1 then
							Sliding = false 
						end
					end)

					game:GetService('UserInputService').InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							if Sliding then
								Library.Dragging = nil
								ISlide(input)
							end
						end
					end)

					function Slider:Set(value)
						Set(value)
					end

					Flags[Slider.Flag] = Set
					Library.Flags[Slider.Flag] = Slider.State
					Set(Slider.State)

                    return Slider
                end
                function Section.Dropdown(Props)
                    if not Props then Props = {} end;

                    local Dropdown = {
                        Name = Props.Name or 'New Dropdown',
                        Options = Props.Options or {"option 1","option 2","option 3"},
                        Flag = Props.Flag or Library:NextFlag(),
                        Callback = Props.Callback or function() end,
                        Max = Props.Max or nil,
                        State = Props.Default or nil,
    
                        OptionInsts = {}
                    }

                    local DropdownHolder = Utility.new("Frame", {
                        Name = "DropdownHolder",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 139, 0, 37),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        ZIndex = 2,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = ActualSection
                    })
                    
                    local DropdownCore = Utility.new("Frame", {
                        Active = true,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        AnchorPoint = Vector2.new(0, 1),
                        Name = "DropdownCore",
                        Position = UDim2.new(0, 0, 1, 0),
                        Size = UDim2.new(1, 0, 0, 18),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                        Parent = DropdownHolder
                    })
                    
                    Utility.Add("UIStroke", DropdownCore, {
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter
                    })
                    
                    Utility.Add("UIGradient", DropdownCore, {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(185, 185, 185)),
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(185, 185, 185))
                        }
                    })
                    
                    local Contents = Utility.new("TextLabel", {
                        TextColor3 = Color3.fromRGB(136, 136, 136),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Text = "",
                        Name = "Contents",
                        Size = UDim2.new(1, 0, 1, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BorderSizePixel = 0,
                        FontFace = getfontfromname'WindowsXPTahoma',
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = DropdownCore
                    })
                    
                    Utility.Add("UIPadding", Contents, {
                        PaddingBottom = UDim.new(0, 2),
                        PaddingLeft = UDim.new(0, 6),
                        PaddingRight = UDim.new(0, 6)
                    })
                    
                    local DropdownIcon = Utility.new("Frame", {
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.5, 61, 0.5, 0),
                        Name = "DropdownIcon",
                        Size = UDim2.new(0, 16, 0, 16),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = DropdownCore
                    })
                    
                    local Icon = Utility.new("ImageLabel", {
                        ImageColor3 = Color3.fromRGB(165, 204, 237),
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = "Icon",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Image = "rbxassetid://87770593342567",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(1, -8, 1, -8),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = DropdownIcon
                    })

                    Section.Dropdowns = Section.Dropdowns or {}

                    local Dropdown_Contents = Utility.new("ScrollingFrame", {
                        Visible = false,
                        BorderMode = Enum.BorderMode.Inset,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, 139, 0, 82),
                        ScrollBarImageColor3 = Color3.fromRGB(165, 204, 237),
                        MidImage = "http://www.roblox.com/asset/?id=17256458146",
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        CanvasPosition = Vector2.new(0, 9),
                        Name = "Dropdown_Contents",
                        TopImage = "http://www.roblox.com/asset/?id=17256458146",
                        Position = UDim2.new(0, 0, 1, 0),
                        Active = true,
                        BottomImage = "http://www.roblox.com/asset/?id=17256458146",
                        ScrollBarThickness = 2,
                        BackgroundColor3 = Color3.fromRGB(29, 29, 29),
                        Parent = DropdownCore
                    })
                    
                    Utility.Add("UIStroke", Dropdown_Contents, {
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter
                    })

                    table.insert(Section.Dropdowns, Dropdown_Contents)

                    local z = 10 + #Section.Dropdowns
                    DropdownHolder.ZIndex = z
                    DropdownCore.ZIndex = z + 1
                    Dropdown_Contents.ZIndex = z + 2

                    local Text = Utility.new("TextLabel", {
                        FontFace = getfontfromname'WindowsXPTahoma',
                        TextColor3 = Color3.fromRGB(136, 136, 136),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Name = "Text",
                        Text = Dropdown.Name,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Size = UDim2.new(0, 139, 0, 17),
                        BorderSizePixel = 0,
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = DropdownHolder
                    })
                    
                    Utility.Add("UIPadding", Text, {
                        PaddingLeft = UDim.new(0, 1)
                    })
                    
                    --
                    Utility.HandleLeftClick(DropdownCore, function()
                        Dropdown_Contents.Visible = not Dropdown_Contents.Visible
                    end)
                    --
                    local function Update()
                        local SelectedText = ""
                        
                        if #Dropdown.State > 0 then
                            SelectedText = table.concat(Dropdown.State, ", ")
                            Contents.Text = SelectedText
                            
                            while Contents.TextBounds.X > (Contents.AbsoluteSize.X - DropdownIcon.AbsoluteSize.X - 12) and #SelectedText > 3 do
                                SelectedText = SelectedText:sub(1, #SelectedText - 4) .. "..."
                                Contents.Text = SelectedText
                                task.wait()
                            end
                        else
                            Contents.Text = ""
                        end
                    
                        Contents.ClipsDescendants = true
                    
                        if #Dropdown.State > 0 then
                            Contents.TextColor3 = Library.Colors.Accent
                        else
                            Contents.TextColor3 = Color3.fromRGB(136, 136, 136)
                        end
                    end
                
                    for _, option in pairs(Dropdown.Options) do
                        local OptionLabel = Utility.new("TextLabel", {
                            Text = option,
                            Size = UDim2.new(1, 0, 0, 20),
                            BackgroundTransparency = 1,
                            TextColor3 = Color3.fromRGB(85, 85, 85),
                            TextSize = 12,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = Dropdown_Contents,
                            FontFace = getfontfromname'WindowsXPTahoma';
                        })
                    
                        Utility.Add("UIPadding", OptionLabel, {
                            PaddingLeft = UDim.new(0, 6),
                            PaddingRight = UDim.new(0, 6)
                        })
                        
                        Utility.HandleLeftClick(OptionLabel, function()
                            local isSelected = table.find(Dropdown.State, option)
                            
                            if isSelected then
                                table.remove(Dropdown.State, table.find(Dropdown.State, option))
                                OptionLabel.TextColor3 = Color3.fromRGB(85, 85, 85)
                            else
                                table.insert(Dropdown.State, option)
                                OptionLabel.TextColor3 = Library.Colors.Accent 
                            end
                            
                            Update()
                    
                            Dropdown.Callback(Dropdown.State)
                        end)
                    end

                    Utility.Add("UIListLayout", Dropdown_Contents, {
                        Padding = UDim.new(0, 1),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalFlex = Enum.UIFlexAlignment.Fill
                    })
                    --
                    return Dropdown
                end

                function Section.Button(Props)
                    if not Props then Props = {} end;

                    local Button = {
                        Name = Props.Name or 'New Button',
                        Callback = Props.Callback or function() end
                    }
                    
                    local ButtonHolder = Utility.new("Frame", {
                        Active = true,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        AnchorPoint = Vector2.new(0, 1),
                        Name = "DropdownCore",
                        Position = UDim2.new(0, 0, 1, 0),
                        Size = UDim2.new(0, 139, 0, 18),
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                        Parent = ActualSection
                    })
                    
                    Utility.Add("UIStroke", ButtonHolder, {
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        LineJoinMode = Enum.LineJoinMode.Miter
                    })
                    
                    Utility.Add("UIGradient", ButtonHolder, {
                        Rotation = 90,
                        Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(185, 185, 185)),
                            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(185, 185, 185))
                        }
                    })
                    
                    local TextLabel = Utility.new("TextLabel", {
                        TextColor3 = Color3.fromRGB(136, 136, 136),
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Text = Button.Name,
                        Name = "Text",
                        Size = UDim2.new(1, 0, 1, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        FontFace = getfontfromname'WindowsXPTahoma',
                        TextSize = 12,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        Parent = ButtonHolder
                    })
                    
                    Utility.Add("UIPadding", TextLabel, {
                        PaddingBottom = UDim.new(0, 2),
                        PaddingLeft = UDim.new(0, 6),
                        PaddingRight = UDim.new(0, 6)
                    })
                    
                    Utility.HandleLeftClick(ButtonHolder, function()
                        Button.Callback()
                    end)
                    
                    return Button
                end

                return Section
            end
        
            table.insert(Window.Tabs, Tab)
            return Tab
        end                

        return Window;
    end;
    --
    local NotificationQueue = {};
    --
    Library.Notify = function(params)

		local Offset = 80 + (#NotificationQueue * 40)

		local NotificaionHolder
		local UIStroke
		local Inline
		local UIStrokeInline
		local Inline_2
		local UIStrokeInline_2
		local AccentTweenThis
		local UIGradient
		local Text
		local UIPadding

		NotificaionHolder = Utility.new("Frame", {
			Name = "NotificaionHolder",
			Position = UDim2.new(0, 10, 0, Offset),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			Size = UDim2.new(0, 160, 0, 30),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(27, 27, 27),
			Parent = RealNotificationHolder
		})

		UIStroke = Utility.new("UIStroke", {
			Color = Color3.fromRGB(2, 2, 2),
			LineJoinMode = Enum.LineJoinMode.Miter,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Parent = NotificaionHolder
		})

		Inline = Utility.new("Frame", {
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Name = "Inline",
			Size = UDim2.new(1, -2, 1, -2),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Parent = NotificaionHolder
		})

		UIStrokeInline = Utility.new("UIStroke", {
			Color = Color3.fromRGB(38, 38, 38),
			LineJoinMode = Enum.LineJoinMode.Miter,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Parent = Inline
		})

		Inline_2 = Utility.new("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Name = "Inline_2",
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			Size = UDim2.new(1, -6, 1, -6),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(17, 17, 17),
			Parent = Inline
		})

		UIStrokeInline_2 = Utility.new("UIStroke", {
			Color = Color3.fromRGB(38, 38, 38),
			LineJoinMode = Enum.LineJoinMode.Miter,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Parent = Inline_2
		})

		AccentTweenThis = Utility.new("Frame", {
			AnchorPoint = Vector2.new(0, 1),
			Name = "AccentTweenThis",
			Position = UDim2.new(0, 0, 1, 0),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			Size = UDim2.new(0, 1, 0, 2),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(165, 204, 237),
			Parent = Inline_2
		})

		UIGradient = Utility.new("UIGradient", {
			Rotation = -90,
			Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, (params.Color or Color3.fromRGB(50, 50, 50))),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
			},
			Parent = AccentTweenThis
		})

		game:GetService("TweenService"):Create(
			AccentTweenThis, 
			TweenInfo.new(params.Duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{Size = UDim2.new(1, 0, 0, 2)}
		):Play()

		Text = Utility.new("TextLabel", {
			FontFace = getfontfromname('WindowsXPTahoma'),
			TextColor3 = params.Color or Color3.fromRGB(165, 204, 237),
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			Text = params.Name or "this is a notification...",
			Name = "Text",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BorderSizePixel = 0,
			TextSize = 12,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Parent = Inline_2
		})

		UIPadding = Utility.new("UIPadding", {
			PaddingBottom = UDim.new(0, 1),
			PaddingLeft = UDim.new(0, 7),
			PaddingRight = UDim.new(0, 7),
			Parent = Text
		})

        NotificaionHolder.Size = UDim2.new(0, Text.TextBounds.X + 20, 0, 30)
        --
        table.insert(NotificationQueue, NotificaionHolder)
        --
        Offset = Offset + 40

        for i, notification in ipairs(NotificationQueue) do
            if notification:IsA("Frame") then
                local NewPosition = UDim2.new(0, notification.Position.X.Offset, 0, notification.Position.Y.Offset - 40)
                game:GetService("TweenService"):Create(
                    notification,
                    TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    {Position = NewPosition}
                ):Play()
            end
        end

        task.delay(params.Duration or 2, function()
            for i, notification in ipairs(NotificationQueue) do
                if notification == NotificaionHolder then
                    table.remove(NotificationQueue, i)
                    break
                end
            end
    
            NotificaionHolder:Destroy()

            for i, notification in ipairs(NotificationQueue) do
                local NewPosition = UDim2.new(0, notification.Position.X.Offset, 0, notification.Position.Y.Offset - 40)
                game:GetService("TweenService"):Create(
                    notification,
                    TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    {Position = NewPosition}
                ):Play()
            end
        end)
	end
    --

    -- Watermark
    Library.Watermark = function()
        local WatermarkHolder;
        local Image;
        local Text;
        local Title = Library.Games[game.PlaceId] or "universal";
    
        WatermarkHolder = Utility.new("Frame", {
            Name = 'WatermarkHolder';
            Size = UDim2.new(0, 200, 0, 200);
            Position = UDim2.new(0.02, 0, 0.77, 0);
            BackgroundColor3 = Color3.fromRGB(27, 27, 27);
            BackgroundTransparency = 1.000;
            Parent = Library.Holder;
        })

        Image = Utility.new("ImageLabel", {
            ScaleType = Enum.ScaleType.Fit,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Name = "Image",
            AnchorPoint = Vector2.new(1, 0),
            Image = "rbxassetid://94841178482304",
            BackgroundTransparency = 1,
            Position = UDim2.new(0.62, 0, 0, 0),
            Size = UDim2.new(0.700385332107544, 0, 1.0449438095092773, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            Parent = WatermarkHolder
        })

        Title = Utility.new("TextLabel", {
            Name = "Text";
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(0.5, 0, 0, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            BackgroundTransparency = 1;
            Text = "pupware - " .. Title;
            FontFace = getfontfromname('WindowsXPTahoma'),
            TextSize = 12;
            TextColor3 = Color3.fromRGB(165, 204, 237);
            TextXAlignment = Enum.TextXAlignment.Center;
            BorderSizePixel = 0;
            Parent = WatermarkHolder;
        })
    
        Utility.new("UIStroke", {
            Parent = Title;
        })

        Text = Utility.new("TextLabel", {
            Name = "Text";
            Size = UDim2.new(1, 0, 1, 0);
            Position = UDim2.new(1.05, 0, 0.25, 0);
            AnchorPoint = Vector2.new(0.5, 0.5);
            BackgroundTransparency = 1;
            Text = "pupware";
            FontFace = getfontfromname('WindowsXPTahoma'),
            TextSize = 12;
            TextColor3 = Color3.fromRGB(165, 204, 237);
            TextXAlignment = Enum.TextXAlignment.Left;
            BorderSizePixel = 0;
            Parent = WatermarkHolder;
        })
    
        Utility.new("UIStroke", {
            Parent = Text;
        })

        Utility.ManageRenderStepped("Watermark", function()
            Text.Text = string.format(
                "> Latency: %dms\n> Frames: %d\n> UID: %d\n> User: %s\n> Velocity: %d\n\ndiscord.gg/pupware", 
                Library.Ping, Library.Fps, Client.UserId, Client.DisplayName, Client.Character.HumanoidRootPart.Velocity.Magnitude
            )
        end)

        return WatermarkHolder
    end    
end

local Window = Library.Window({Name = 'pupware'})
local Combat = Window.Tab({ Name = "Combat", Default = true })
local Test = Combat.Section({
    Name = "Test",
    Side = "Left"
})
Test.Dropdown({
    Name = "Select Options",
    Options = {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6"},
    Flag = "DropdownFlag",
    Default = {"Option 1"},
    Callback = function(selectedOptions)
        print("Selected Options: " .. table.concat(selectedOptions, ", "))
    end,
    Max = 3
})
Test.Slider({
    Name = "Volume",
    Min = 0,
    Max = 100,
    Default = 50,
    Decimals = 1,
    Suffix = "%",
    Flag = "VolumeFlag",
    Callback = function(value)
        print("Current Volume: " .. value .. "%")
    end
})
Test.Toggle({
    Name = "Enable",
    Flag = "Enabled",
    State = false,
    Callback = function(state)
        print("Toggle Status: " .. tostring(state))
    end
}).Keybind({
    Name = "Toggle Action",
    Flag = "toggleActionFlag",
    Mode = 'Toggle',
    ModeChangeable = true
})

local Visuals = Window.Tab({ Name = "Visuals", Default = false }) 
local Misc = Window.Tab({ Name = "Misc", Default = false }) 
local Movement = Window.Tab({ Name = "Movement", Default = false }) 
local Players = Window.Tab({ Name = "Players", Default = false }) 
local Config = Window.Tab({ Name = "Config", Default = false }) 
local Settings = Window.Tab({ Name = "Settings", Default = false })
local UISettings = Settings.Section({
    Name = "Settings",
    Side = "Left"
})
 
local Watermark = Library.Watermark()
local Load = (os.clock() - Library.Start)
Library.Notify({Name = "Script Took -> " .. Load .. " secs", Duration = 5, Color = Library.Colors.Accent})

UISettings.Toggle({
    Name = "Show UI",
    Flag = "show ui",
    State = true,
    Callback = function(state)
        Window["1"].Visible = state
    end
}).Keybind({
    Name = "Toggle Action",
    Flag = "toggleActionFlag",
    Mode = 'Toggle',
    ModeChangeable = false
})
UISettings.Toggle({
    Name = "Watermark",
    Flag = "watermark",
    State = true,
    Callback = function(state)
        Watermark.Visible = state
    end
})

UISettings.Slider({
    Name = "X Position",
    Min = 0,
    Max = 2500,
    Default = 0,
    Decimals = 1,
    Suffix = "px",
    Flag = "watermark x position",
    Callback = function(value)
        Watermark.Position = UDim2.new(0.02, value, 0.77, Watermark.Position.Y.Offset);
    end
})

UISettings.Slider({
    Name = "Y Position",
    Min = 0,
    Max = 2500,
    Default = 0,
    Decimals = 1,
    Suffix = "px",
    Flag = "watermark y position",
    Callback = function(value)
        Watermark.Position = UDim2.new(0.02, Watermark.Position.X.Offset, 0.77, -value);
    end
})

UISettings.Button({
    Name = "Unload",
    Callback = function()
        Library.Holder:Destroy()
        RealNotificationHolder:Destroy()
    end
})
