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
Auto_Retry_Player.Name = "Reload_List_Marco"
Auto_Retry_Player.Value = false
Auto_Retry_Player.Parent = Player

local Clear_Name_Input = Instance.new("BoolValue")
Auto_Retry_Player.Name = "Clear_Name_Input"
Auto_Retry_Player.Value = false
Auto_Retry_Player.Parent = Player

local Auto_Start_Local = Player:WaitForChild("Auto_Start_Player")
local Auto_Retry_Local = Player:WaitForChild("Auto_Retry_Player")
local Reload_List_Marco_Local = Player:WaitForChild("Reload_List_Marco")
local Clear_Name_Input_Local = Player:WaitForChild("Clear_Name_Input")
--###############################################################################################################################################################################################################################################################-End Install Setting Game Player
--###############################################################################################################################################################################################################################################################-Load RayScript
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Anime Adventure Script (v0.1.1)",
   Icon = "slack", -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Anime Adventure Script (v0.1.1)",
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
local StillCheck = Window:CreateTab("Still Check", "badge-alert")
local Marco = Window:CreateTab("Marco", "bot")
--###############################################################################################################################################################################################################################################################-End Menu
--###############################################################################################################################################################################################################################################################-Load All Local Setting
local Auto_Start_Boolean = false
local Auto_Retry_Boolean = false
--###############################################################################################################################################################################################################################################################-End All Local Setting
--###############################################################################################################################################################################################################################################################-Load All Function
function Auto_Start_Fucntion()
   if Auto_Start_Local.Value == false then
      local Auto_Start_Call = Vote_Start:InvokeServer()
      Auto_Start_Local.Value = true
   end
end

function Auto_Retry_Function()
   local Auto_Retry_Call = Set_Game_Finish_Vote:InvokeServer("replay")
   Auto_Retry_Local = true
end
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
         if Auto_Retry_Local == false and ResultsUI.Visible == true then
            Auto_Retry_Function()
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
         print(Options)
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
      table.insert(values, tonumber(num))
   end

   local cf = CFrame.new(values[1], values[2], values[3])  -- Chỉ dùng X, Y, Z
   print(cf)  -- Kết quả: CFrame.new(-3007.05859, 33.7417984, -719.764465)
   return cf
end

function Get_TARGET_UPGRADE(cframe)
   local regionSize = Vector3.new(0.01, 0.01, 0.01) -- Mặc định kích thước nhỏ nếu không có giá trị
   local workspace = game.Workspace

   local targetCFrame = Return_Origin_CFrame(cframe)

   -- Dùng FindPartsInBox thay vì Region3
   local parts = workspace:GetPartBoundsInBox(targetCFrame, regionSize, nil)

   for _, part in pairs(parts) do
      if part.Name == "HumanoidRootPart" then
         local Unit = part.Parent
         local Unit_Parent = game.Workspace._UNITS:FindFirstChild(Unit)
         upgrade_unit_ingame:InvokeServer(Unit_Parent)
	 break
      end
   end
end

local Place_Now = true
local BREAK_PLACE = false

function Play_Marco()
   while Replay_Marco_BOOLEAN and not BREAK_PLACE do
      if Place_Now then
         if not Chose_Marco then break end
         local Replay_Table = Read_Json_Marco(Chose_Marco[1])
         for index, value in pairs(Replay_Table) do
            if Break_Check then
               break
            end
            Replay_Steps += 1
            print("How Many Step Now: ", Replay_Steps)
         end
         Break_Check = true
         if Steps_Do_Replay <= Replay_Steps then
            Key = tostring(Steps_Do_Replay)
            if Replay_Table[Key].Money_Cost ~= nil then
               if Replay_Table[Key].Money_Cost <= tonumber(MoneyPlayerText.Text) and Replay_Table[Key].Event_Type == "spawn_unit" then
                  Spawn_Unit:InvokeServer(Replay_Table[Key].Unit_Type, Return_Origin_CFrame(Replay_Table[Key].Cframe))
                  Steps_Do_Replay += 1
               elseif Replay_Table[Key].Money_Cost <= tonumber(MoneyPlayerText.Text) and Replay_Table[Key].Event_Type == "upgrade_unit_ingame" then
                  Get_TARGET_UPGRADE(Replay_Table[Key].Cframe)
                  Steps_Do_Replay += 1
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

    if table.find(TargetEventNames, remoteName) and (method == "FireServer" or method == "InvokeServer") and Record_Marco_BOOLEAN == true then
        local success, result = pcall(oldNamecall, self, ...)
        
        -- Chỉ ghi lại khi request thành công và có đủ tiền
        if success then
            if method == "InvokeServer" and remoteName == "spawn_unit" then
                if result == true then -- Giả định server trả về true khi thành công
                    MARCO_TABLE[NumberString(Steps)] = {
                        Event_Type = remoteName,
                        Money_Cost = 0,
                        Unit_Type = args[1],
                        Cframe = tostring(args[2]),
                    }
                    print("Remote Name Is: ", MARCO_TABLE[NumberString(Steps)].Event_Type)
                    print("Unit Type Is: ", MARCO_TABLE[NumberString(Steps)].Unit_Type)
                    print("CFrame Is: ", MARCO_TABLE[NumberString(Steps)].Cframe)
                    print("How Many Table Now: ", #MARCO_TABLE)
                    Steps += 1
                end
            elseif method == "InvokeServer" and remoteName == "upgrade_unit_ingame" then
               if result == true then -- Giả định server trả về true khi thành công
                   MARCO_TABLE[NumberString(Steps)] = {
                       Event_Type = remoteName,
                       Money_Cost = 0,
                       Cframe = tostring(args[1].HumanoidRootPart.CFrame),
                   }
                   print("Remote Name Is: ", MARCO_TABLE[NumberString(Steps)].Event_Type)
                   print("CFrame Is: ", MARCO_TABLE[NumberString(Steps)].Cframe)
                   Steps += 1
               end
            end
        end

        return result
    end

    return oldNamecall(self, ...)
end

setreadonly(mt, true)

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
   saveMacroData()
      
   if Auto_Retry_Boolean == true and Auto_Retry_Local == false and game.PlaceId ~= AA_ID then
      Auto_Retry_Function()
   end
end)
--###############################################################################################################################################################################################################################################################-End All Condition

