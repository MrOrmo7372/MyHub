--"{f4777064-b97f-4cd8-a069-0389ab9502be}"
--"{ab192659-5a9f-45f6-9fc5-58b5b0c57253}"
--###############################################################################################################################################################################################################################################################-Load Local Info
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = game.Players.LocalPlayer

local AA_ID = 8304191830

local Not_Target = {}

local Client_to_Server_File_Location = ReplicatedStorage:WaitForChild("endpoints"):WaitForChild("client_to_server")
   local Vote_Start = Client_to_Server_File_Location:WaitForChild("vote_start")
   local Spawn_Unit = Client_to_Server_File_Location:WaitForChild("spawn_unit")
   local upgrade_unit_ingame = Client_to_Server_File_Location:WaitForChild("upgrade_unit_ingame")
   local Set_Game_Finish_Vote = Client_to_Server_File_Location:WaitForChild("set_game_finished_vote")
   local use_active_attack = Client_to_Server_File_Location:WaitForChild("use_active_attack")

local PlayerGui = Player:WaitForChild("PlayerGui")
   local ResultsUI = PlayerGui:WaitForChild("ResultsUI")
   local MoneyChange_POPUP_UI = PlayerGui:WaitForChild("spawn_units").Lives.Frame.Resource.Money
   local MoneyPlayerText = PlayerGui:WaitForChild("spawn_units").Lives.Frame.Resource.Money.text

for _, RemoveTarget in ipairs(MoneyChange_POPUP_UI:GetChildren()) do
   table.insert(Not_Target, RemoveTarget)
end

local FileName_User = "MrHub_" .. game.Players.LocalPlayer.Name .. "_User"
local MarcoFile = FileName_User .. "/" .. "Marco"
if not isfolder(MarcoFile) then
    makefolder(MarcoFile)
end
--###############################################################################################################################################################################################################################################################-End Local Info
--###############################################################################################################################################################################################################################################################-Load Install Setting Game Player
local Auto_Start_Player = Instance.new("BoolValue")
Auto_Start_Player.Name = "Auto_Start_Player"
Auto_Start_Player.Value = false
Auto_Start_Player.Parent = Player

local Auto_Retry_Player = Instance.new("BoolValue")
Auto_Retry_Player.Name = "Auto_Retry_Player"
Auto_Retry_Player.Value = false
Auto_Retry_Player.Parent = Player

local Reload_List_Marco = Instance.new("BoolValue")
Reload_List_Marco.Name = "Reload_List_Marco"
Reload_List_Marco.Value = false
Reload_List_Marco.Parent = Player

local Clear_Name_Input = Instance.new("BoolValue")
Clear_Name_Input.Name = "Clear_Name_Input"
Clear_Name_Input.Value = false
Clear_Name_Input.Parent = Player

local Turn_Off_Save_Marco_When_On = Instance.new("BoolValue")
Turn_Off_Save_Marco_When_On.Name = "Turn_Off_Save_Marco_When_On"
Turn_Off_Save_Marco_When_On.Value = false
Turn_Off_Save_Marco_When_On.Parent = Player

local All_Erwin_Value = Instance.new("IntValue")
All_Erwin_Value.Name = "All_Erwin_Value"
All_Erwin_Value.Value = 0
All_Erwin_Value.Parent = Player

local All_Stain_Value = Instance.new("IntValue")
All_Stain_Value.Name = "All_Stain_Value"
All_Stain_Value.Value = 0
All_Stain_Value.Parent = Player

local Auto_Start_Local = Player:WaitForChild("Auto_Start_Player")
local Auto_Retry_Local = Player:WaitForChild("Auto_Retry_Player")
local Reload_List_Marco_Local = Player:WaitForChild("Reload_List_Marco")
local Clear_Name_Input_Local = Player:WaitForChild("Clear_Name_Input")
local Turn_Off_Save_Marco_When_On_Local = Player:WaitForChild("Turn_Off_Save_Marco_When_On")
--###############################################################################################################################################################################################################################################################-End Install Setting Game Player
--###############################################################################################################################################################################################################################################################-Load RayScript
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Anime Adventure Script (v0.1.5)",
   Icon = "slack", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Anime Adventure Script (v0.1.5)",
   LoadingSubtitle = "by MrHub",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = FileName_User, -- Create a custom folder for your hub/game
      FileName = "AA_Config"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
--###############################################################################################################################################################################################################################################################-End RayScript
--###############################################################################################################################################################################################################################################################-Load Menu
local AutoFarm = Window:CreateTab("Auto Farm", "apple")
local AutoPlay = Window:CreateTab("Auto Play+", "mouse")
local Marco = Window:CreateTab("Marco", "bot")
--###############################################################################################################################################################################################################################################################-End Menu
--###############################################################################################################################################################################################################################################################-Load All Local Setting
local Auto_Start_Boolean = false
local Auto_Retry_Boolean = false
local Low_End_Android = false
--###############################################################################################################################################################################################################################################################-End All Local Setting
--###############################################################################################################################################################################################################################################################-Load All Function
function Auto_Start_Fucntion()
   if Auto_Start_Local.Value == false then
      local Auto_Start_Call = Vote_Start:InvokeServer()
      Auto_Start_Local.Value = true
   end
end

function Auto_Retry_Function()
   task.wait(2)
   local Auto_Retry_Call = Set_Game_Finish_Vote:InvokeServer("replay")
   Auto_Retry_Local.Value = true
end

-- Đặt script này trong ServerScriptService
local function optimizeEverything()
    local Map = game.Workspace:WaitForChild("_map")

    local Water_Block = game.Workspace:WaitForChild("_water_blocks")
    if Water_Block then
        Water_Block:Destroy()
    end

    -- Xử lý tất cả vật thể trong Workspace
    for _, obj in ipairs(workspace:GetDescendants()) do
        -- Xử lý vật thể cơ bản
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.Plastic
            obj.Color = Color3.new(1, 1, 1)
            obj.Reflectance = 0
            obj.Transparency = 0
            obj.CastShadow = false
            
            -- Xóa texture của MeshPart
            if obj:IsA("MeshPart") then
                obj.TextureID = ""
            end
            
            -- Xóa SurfaceAppearance
            for _, v in ipairs(obj:GetChildren()) do
                if v:IsA("SurfaceAppearance") then
                    v:Destroy()
                end
            end
        end
        
        -- Xóa decal và texture
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
        
        -- Xóa hiệu ứng particle
        if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            pcall(function()
                obj.Enabled = false
                obj:Destroy()
            end)
        end
        
        -- Xóa âm thanh
        if obj:IsA("Sound") then
            pcall(function()
                obj:Stop()
                obj:Destroy()
            end)
        end
        
        -- Xóa texture từ Mesh/SpecialMesh
        if obj:IsA("Mesh") or obj:IsA("SpecialMesh") then
            pcall(function()
                obj.TextureId = ""
            end)
        end
    end
    
    -- Xử lý Lighting
    local lighting = game:GetService("Lighting")
    
    -- Xóa tất cả hiệu ứng trong Lighting
    for _, effect in ipairs(lighting:GetChildren()) do
        effect:Destroy()
    end
    
    -- Reset cài đặt Lighting
    lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    lighting.Brightness = 1
    lighting.GlobalShadows = false
    lighting.FogEnd = 100000
    lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
    lighting.ClockTime = 12
    lighting.Technology = Enum.Technology.Compatibility
    
    -- Tối ưu Terrain
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterTransparency = 0.9
        terrain.WaterWaveSize = 0
    end

    settings().Rendering.QualityLevel = 1
    settings().Rendering.MeshCacheSize = 0
    
    -- Tắt FX
    game:GetService("Lighting").GlobalShadows = false
end

function MoveRoadChildren()
    local workspace = game:GetService("Workspace")
    local road = workspace:FindFirstChild("_road")

    if road then
        -- Tạo thư mục mới tên "RemoveDecteve" nếu chưa có
        local removeDetective = workspace:FindFirstChild("RemoveDecteve")
        if not removeDetective then
            removeDetective = Instance.new("Folder")
            removeDetective.Name = "RemoveDecteve"
            removeDetective.Parent = workspace
        end

        -- Di chuyển tất cả con của _road vào RemoveDecteve
        for _, child in ipairs(road:GetChildren()) do
            child.Parent = removeDetective
        end
    else
        warn("_road không tồn tại trong Workspace!")
    end
end

-- Gọi function để chạy
MoveRoadChildren()
--###############################################################################################################################################################################################################################################################-End All Function
--###############################################################################################################################################################################################################################################################-Load All Menu
local Place_Cooldown = 4
local Chose_Marco = nil
local MARCO_TABLE = {}
local REPLAY_MARCO_TABLE = {}
local Curret_Marco = {}
local Negative_Money_List = {}
local Record_Marco_BOOLEAN = false -- Giả sử biến này được điều khiển bởi GUI
local Replay_Marco_BOOLEAN = true
local Steps = 1
local Replay_Steps = 0
local Steps_Do_Replay = 1
local Break_Check = false
local Erwin_Unit = {}
local INF_BUFF_ERWIN = false

local Map_Ice = nil

if game.PlaceId ~= AA_ID then
    if workspace._map:FindFirstChild("player") then
	if workspace._map.player:FindFirstChild("Beacon") then
	    Map_Ice =  workspace._map.player.Beacon.CFrame
            workspace._map.player.Beacon:Destroy()

	    for _, child in ipairs(workspace._map:GetChildren()) do
                if child:FindFirstChild("snow") then
                    child.snow:Destroy()
                end
            end

            local area = workspace._map.player:FindFirstChild("area")
            if area then
                area.BrickColor = BrickColor.new("Lime green")
                area.Color = Color3.fromRGB(0, 255, 0)
                area.Size = Vector3.new(0.3, 15, 15)
                area.Shape = Enum.PartType.Block

                local attachment = area:FindFirstChild("Attachment")
                if attachment then
                    attachment:Destroy()
                end
            end
	end
    end
end

All_Erwin_Value.Changed:Connect(function()
    function Check_Erwin(Unit)
        for _, Unit_Table in ipairs(Erwin_Unit) do
	    if Unit_Table == Unit then
	        return false
	    end
	end
	return true
    end

    if All_Erwin_Value.Value >= 4 then
        for _, Unit in ipairs(workspace._UNITS:GetChildren()) do
	    if Unit.Name == "erwin" and Check_Erwin(Unit) then
	        table.insert(Erwin_Unit, Unit)
	    end
	end

	function Loop_Buff()
            local Erwin_Buff = 1
            while true do
                use_active_attack:InvokeServer(Erwin_Unit[Erwin_Buff])
		if Erwin_Buff >= 4 then
		    Erwin_Buff = 1
		else
		    Erwin_Buff += 1
		end
                task.wait(16.5)
	    end
	end

	task.spawn(Loop_Buff())
    end
end)

local Auto_Start_Toggle = AutoFarm:CreateToggle({
   Name = "Auto Start",
   CurrentValue = false,
   Flag = "Auto_Start", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Auto_Start_Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         Auto_Start_Boolean = Auto_Start_Value
         if Auto_Start_Boolean == true and game.PlaceId ~= AA_ID then
            Auto_Start_Fucntion()
         end
   end,
})

local Auto_Retry_Toggle = AutoFarm:CreateToggle({
   Name = "Auto Retry",
   CurrentValue = false,
   Flag = "Auto_Retry", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Auto_Retry_Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         Auto_Retry_Boolean = Auto_Retry_Value
         if Auto_Retry_Local.Value == false and ResultsUI.Enabled == true then
            Auto_Retry_Function()
         end
   end,
})

local INF_ERWIN_Toggle = AutoPlay:CreateToggle({
   Name = "Inf Buff Erwin",
   CurrentValue = false,
   Flag = "Inf_Buff_Erwin", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Inf_Buff_Erwin_Toggle)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         INF_BUFF_ERWIN = Inf_Buff_Erwin_Toggle
   end,
})

local Low_End_Toggle = AutoFarm:CreateToggle({
   Name = "More FPS",
   CurrentValue = false,
   Flag = "Low_End_Toggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Low_End_Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         Low_End_Android = Low_End_Value
	 if Low_End_Android == true and game.PlaceId ~= AA_ID then
	     optimizeEverything()
	 end
   end,
})

local Start_Record = Marco:CreateToggle({
   Name = "Start Record",
   CurrentValue = false,
   Flag = "Start_Record", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Start_Record)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         Record_Marco_BOOLEAN = Start_Record
   end,
})

local Start_Replay = Marco:CreateToggle({
   Name = "Start Replay",
   CurrentValue = false,
   Flag = "Start_Replay", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Start_Replay_Marco)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         Replay_Marco_BOOLEAN = Start_Replay_Marco
   end,
})

-- Liệt kê các file macro
local function listMacros()
    if isfolder(MarcoFile) then
        local files = listfiles(MarcoFile)
        local fileNames = {}
        for _, filePath in ipairs(files) do
            table.insert(fileNames, filePath:match("([^/]+)$")) -- Lấy tên file
        end
        return fileNames
    else
        print("Folder not found!")
        return {}
    end
end

local List_Marco_Config = Marco:CreateDropdown({
   Name = "List Marco Config",
   Options = listMacros(),
   CurrentOption = {""},
   MultipleOptions = false,
   Flag = "List_Marco_Config", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
   -- The function that takes place when the selected option is changed
   -- The variable (Options) is a table of strings for the current selected options
         Chose_Marco = Options
   end,
})

local Create_Config_Marco = Marco:CreateInput({
   Name = "Create File Marco",
   CurrentValue = "",
   PlaceholderText = "Enter Name",
   RemoveTextAfterFocusLost = true,
   Flag = "Create_File_Marco",
   Callback = function(Text)
   -- The function that takes place when the input is changed
   -- The variable (Text) is a string for the value in the text box
         if Text ~= nil and Text ~= "" then
            if string.sub(Text, -5) ~= ".json" then
               Text = Text .. ".json"
            end
	    local MarcoFile = FileName_User .. "/" .. "Marco"
            if not isfolder(MarcoFile) then
               makefolder(MarcoFile)
	    end
            local Target_File_Config_Create = MarcoFile .. "/" .. Text

            if isfile(Target_File_Config_Create) then
               print("File already exists, skipping save:", Text)
               return -- Thoát hàm nếu file đã tồn tại
            end
            
            if not isfile(Target_File_Config_Create) then
               writefile(Target_File_Config_Create, "{}")
            end
            Text = ""
         end
	 Clear_Name_Input.Value = true
	 Reload_List_Marco.Value = true
   end,
})

Reload_List_Marco_Local.Changed:Connect(function()
   if Reload_List_Marco.Value == true then
      List_Marco_Config:Refresh(listMacros()) -- The new list of options available.
      Reload_List_Marco.Value = false
   end
end)

Clear_Name_Input_Local.Changed:Connect(function()
   if Clear_Name_Input.Value == true then
      Create_Config_Marco:Set("") -- The new input text value
      Clear_Name_Input.Value = false
   end
end)

local Slider_Place_Cooldown = Marco:CreateSlider({
   Name = "Place Cooldown",
   Range = {0, 4},
   Increment = 1,
   Suffix = "Cooldown",
   CurrentValue = 4,
   Flag = "Place_Cooldown", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the slider changes
   -- The variable (Value) is a number which correlates to the value the slider is currently at
         Place_Cooldown = Value
   end,
})

--###############################################################################################################################################################################################################################################################-End All Menu
--###############################################################################################################################################################################################################################################################-Load MARCO ZONE


--###############################################################################################################################################################################################################################################################-Load PLAY RECORD ZONE
function Read_Json_Marco(File_Json)
   if isfile(MarcoFile .. "/" .. File_Json) then
        local jsonData = readfile(MarcoFile .. "/" .. File_Json)
        return HttpService:JSONDecode(jsonData)
    else
        print("File not found:", fileName)
        return nil
    end
end

function Return_Origin_CFrame(Text_CFrame)
   local data = Text_CFrame
   local values = {}

   for num in data:gmatch("[^, ]+") do
      --print("Return Origin: ", tonumber(num))
      table.insert(values, tonumber(num))
   end

   local cf = CFrame.new(values[1], values[2], values[3])  -- Chỉ dùng X, Y, Z
   --print("cf: ", cf)  -- Kết quả: CFrame.new(-3007.05859, 33.7417984, -719.764465)
   return cf
end

local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Include  -- Chỉ lấy phần tử trong danh sách
overlapParams.FilterDescendantsInstances = {game.Workspace._UNITS}  -- Chỉ lấy phần trong MyModel

function Get_TARGET_UPGRADE(cframe)
   local Close_Target = nil
   local Range_Find = math.huge
   local regionSize = Vector3.new(20, 20, 20) -- Mặc định kích thước nhỏ nếu không có giá trị
   local workspace = game.Workspace
   local targetCFrame = nil

   if not Map_Ice then
      targetCFrame = Return_Origin_CFrame(cframe)
   elseif Map_Ice then
      local Map_Ice_Position = Map_Ice.Position
      targetCFrame = Return_Origin_CFrame(cframe) + Map_Ice_Position
   end

   -- Dùng FindPartsInBox thay vì Region3
   local parts = workspace:GetPartBoundsInBox(targetCFrame, regionSize, overlapParams)

   for _, part in pairs(parts) do
      if part.Name == "HumanoidRootPart" and part.Parent:FindFirstChild("_hitbox") then
	 local Hitbox = part.Parent:FindFirstChild("_hitbox")
	 --print((targetCFrame.Position - Hitbox.Position).magnitude)	
	if (targetCFrame.Position - Hitbox.Position).magnitude < Range_Find then
	   Range_Find = (targetCFrame.Position - Hitbox.Position).magnitude
	   Close_Target = part.Parent
	end
      end
   end

   if Close_Target then
      upgrade_unit_ingame:InvokeServer(Close_Target)
      --print("Invoke Upgrade")
   end
end

local Place_Now = true
local BREAK_PLACE = false

function Play_Marco()
   repeat task.wait() until workspace._waves_started.Value == true
   task.wait(1.7)
   while Replay_Marco_BOOLEAN and not BREAK_PLACE do
      if Place_Now then
         if not Chose_Marco then break end
         local Replay_Table = Read_Json_Marco(Chose_Marco[1])
         for index, value in pairs(Replay_Table) do
            if Break_Check then
               break
            end
            Replay_Steps += 1
            --print("How Many Step Now: ", Replay_Steps)
         end
         Break_Check = true
         if Steps_Do_Replay <= Replay_Steps then
            Key = tostring(Steps_Do_Replay)
            if Replay_Table[Key].Money_Cost ~= nil then
	        if not Map_Ice then
                    if Replay_Table[Key].Money_Cost <= tonumber(MoneyPlayerText.Text) and Replay_Table[Key].Event_Type == "spawn_unit" then
	                task.wait()
                        Spawn_Unit:InvokeServer(Replay_Table[Key].Unit_Type, Return_Origin_CFrame(Replay_Table[Key].Cframe))
			if Replay_Table[Key].Unit_Type == "{f4777064-b97f-4cd8-a069-0389ab9502be}" and INF_BUFF_ERWIN == true then
			    All_Erwin_Value.Value += 1
			end
                        Steps_Do_Replay += 1
                    elseif Replay_Table[Key].Money_Cost <= tonumber(MoneyPlayerText.Text) and Replay_Table[Key].Event_Type == "upgrade_unit_ingame" then
		        task.wait()
                        Get_TARGET_UPGRADE(Replay_Table[Key].Cframe)
                        Steps_Do_Replay += 1
                    end
		elseif Map_Ice then
		    local Map_Ice_Position = Map_Ice.Position
		    if Replay_Table[Key].Money_Cost <= tonumber(MoneyPlayerText.Text) and Replay_Table[Key].Event_Type == "spawn_unit" then
	                task.wait()
                        Spawn_Unit:InvokeServer(Replay_Table[Key].Unit_Type, Return_Origin_CFrame(Replay_Table[Key].Cframe) + Map_Ice_Position)
			if Replay_Table[Key].Unit_Type == "{f4777064-b97f-4cd8-a069-0389ab9502be}" and INF_BUFF_ERWIN == true then
			    All_Erwin_Value.Value += 1
			end
                        Steps_Do_Replay += 1
                    elseif Replay_Table[Key].Money_Cost <= tonumber(MoneyPlayerText.Text) and Replay_Table[Key].Event_Type == "upgrade_unit_ingame" then
		        task.wait()
                        Get_TARGET_UPGRADE(Replay_Table[Key].Cframe)
                        Steps_Do_Replay += 1
                    end			
		end
            end
            Place_Now = false
            task.wait(Place_Cooldown)
            Place_Now = true
         else
            BREAK_PLACE = true
         end
      end
   end
end
--###############################################################################################################################################################################################################################################################-End PLAY RECORD ZONE
local TargetEventNames = {"spawn_unit", "upgrade_unit_ingame"}

function Get_Value()
   for index, Money in ipairs(Negative_Money_List) do
      local Key = tostring(index)
      
      MARCO_TABLE[Key].Money_Cost = Negative_Money_List[index]
   end
end

-- Hàm lưu dữ liệu với kiểm tra trùng lặp
local function saveMacroData()
    Get_Value()

    if next(MARCO_TABLE) == nil then
	return
    end
    
    local jsonData = HttpService:JSONEncode(MARCO_TABLE)
    local TARGET = MarcoFile .. "/" .. Chose_Marco[1]
    writefile(TARGET, jsonData)
end

function NumberString(Step)
    return tostring(Step)
end

local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNamecall = mt.__namecall

mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    local remoteName = self.Name

    if table.find(TargetEventNames, remoteName) and (method == "FireServer" or method == "InvokeServer") then
        local success, result = pcall(oldNamecall, self, ...)
        
        -- Chỉ ghi lại khi request thành công và có đủ tiền
        if success then
	    if Record_Marco_BOOLEAN == true then
                if method == "InvokeServer" and remoteName == "spawn_unit" then
                    if result == true then -- Giả định server trả về true khi thành công
                        MARCO_TABLE[NumberString(Steps)] = {
                            Event_Type = remoteName,
                            Money_Cost = 0,
                            Unit_Type = args[1],
                            Cframe = tostring(args[2]),
                        }
                        --print("Remote Name Is: ", MARCO_TABLE[NumberString(Steps)].Event_Type)
                        --print("Unit Type Is: ", MARCO_TABLE[NumberString(Steps)].Unit_Type)
                        --print("CFrame Is: ", MARCO_TABLE[NumberString(Steps)].Cframe)
                        --print("How Many Table Now: ", #MARCO_TABLE)

		        --if MARCO_TABLE[NumberString(Steps)].Unit_Type == "{f4777064-b97f-4cd8-a069-0389ab9502be}" and INF_BUFF_ERWIN == true then
		            --All_Erwin_Value.Value += 1
		        --end

		        if Map_Ice ~= nil then
			    local Map_Ice_Position = Map_Ice.Position
		            local Adapt_CFrame = (Return_Origin_CFrame(MARCO_TABLE[NumberString(Steps)].Cframe) - Map_Ice_Position)
			    MARCO_TABLE[NumberString(Steps)].Cframe = tostring(Adapt_CFrame)
		        end
                        Steps += 1
                    end
                elseif method == "InvokeServer" and remoteName == "upgrade_unit_ingame" then
                    if result == true then -- Giả định server trả về true khi thành công
                        MARCO_TABLE[NumberString(Steps)] = {
                            Event_Type = remoteName,
                            Money_Cost = 0,
                            Cframe = tostring(args[1].HumanoidRootPart.CFrame),
                        }
                        --print("Remote Name Is: ", MARCO_TABLE[NumberString(Steps)].Event_Type)
                        --print("CFrame Is: ", MARCO_TABLE[NumberString(Steps)].Cframe)

		        if Map_Ice ~= nil then
		           local Map_Ice_Position = Map_Ice.Position
		           local Adapt_CFrame = (Return_Origin_CFrame(MARCO_TABLE[NumberString(Steps)].Cframe) - Map_Ice_Position)
		           MARCO_TABLE[NumberString(Steps)].Cframe = tostring(Adapt_CFrame)
		        end
                        Steps += 1
                    end
                end
	    end
	    if method == "InvokeServer" and remoteName == "spawn_unit" and args[1] == "{f4777064-b97f-4cd8-a069-0389ab9502be}" and INF_BUFF_ERWIN == true then
	        All_Erwin_Value.Value += 1
	    end
        end

        return result
    end

    return oldNamecall(self, ...)
end

setreadonly(mt, true)

local Save_Record = AutoFarm:CreateToggle({
   Name = "Save Record",
   CurrentValue = false,
   Flag = "Save_Record", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Save_Record_Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
        if Save_Record_Value == true then
	    Turn_Off_Save_Marco_When_On_Local.Value = true
	    if next(MARCO_TABLE) ~= nil then
                Start_Record:Set(false)
                saveMacroData()
                MARCO_TABLE = {}
            else
                Start_Record:Set(false)
            end
        end
   end,
})

Turn_Off_Save_Marco_When_On_Local.Changed:Connect(function()
    if Turn_Off_Save_Marco_When_On_Local.Value == true then
	Save_Record:Set(false)
        Turn_Off_Save_Marco_When_On_Local.Value = false
    end
end)

-- Ví dụ sử dụng:
-- saveMacroData() -- Gọi khi cần lưu dữ liệu
--###############################################################################################################################################################################################################################################################-End MARCO ZONE


Rayfield:LoadConfiguration()


--###############################################################################################################################################################################################################################################################-Load All Condition
if Auto_Start_Boolean == true and game.PlaceId ~= AA_ID then
   Auto_Start_Fucntion()
end

function Check_Target(Target_Check)
   for _, Target in ipairs(Not_Target) do
      if Target == Target_Check then
         return true
      end
   end
   return false
end

function Check_Negative_Money(Target_Check)
   for _, Target in ipairs(Negative_Money_List) do
      if Target == Target_Check then
         return true
      end
   end
   return false
end

Create_Config_Marco:Set("")

if Replay_Marco_BOOLEAN == true and game.PlaceId ~= AA_ID then
   Play_Marco()
end

MoneyChange_POPUP_UI.ChildAdded:Connect(function(Target)
   task.wait(0.1)
   if Target:IsA("Frame") and Target:FindFirstChild("text") and Target.Visible == true and tonumber(Target.text.Text) < 0 and not Check_Target(Target) and not Check_Negative_Money(Target) then
      table.insert(Negative_Money_List, math.abs(tonumber(Target.text.Text)))
      print("Money Save: ", math.abs(tonumber(Target.text.Text)))
   end
end)

ResultsUI:GetPropertyChangedSignal("Enabled"):Connect(function()
   if next(MARCO_TABLE) ~= nil then
      Start_Record:Set(false)
      saveMacroData()
      MARCO_TABLE = {}
   else
      Start_Record:Set(false)
   end
      
   if Auto_Retry_Boolean == true and Auto_Retry_Local.Value == false and game.PlaceId ~= AA_ID then
      Auto_Retry_Function()
   end
end)
--###############################################################################################################################################################################################################################################################-End All Condition

