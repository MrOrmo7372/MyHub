print("THIS IS THE START OF THE SCRIPT")
local HttpService = game:GetService("HttpService")

local Vote_Start = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start")
local Set_Game_Finish_Vote = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("set_game_finished_vote")
local Spawn_Unit = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("spawn_unit")

local MoneyPlayerText = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("spawn_units").Lives.Frame.Resource.Money.text
local ResultsUI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ResultsUI")
local FileName_User = "MrHubConfig_" .. game.Players.LocalPlayer.Name .. "_User"

--------------------------------------------------------------------------------Info AA
--game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units /unit = [number].Main.View.WorldModel.[name_unit]
---------------------------------------------------------------------------------------

local Unit_Table = {
   luffy_christmas
}

--local UnitsEquip_Player = game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MrHub AA V0.0045 Beta",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Waiting AA Script (MrHub V0.0045)",
   LoadingSubtitle = "by MrHub",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = FileName_User, -- Create a custom folder for your hub/game
      FileName = "MrHub"
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

local AutoFarm = Window:CreateTab("Auto Farm", "apple")
local StillCheck = Window:CreateTab("Still Check", "badge-alert")
local FarmGems = Window:CreateTab("FarmGems", "book-dashed")
local MarcoZone = Window:CreateTab("Marco Zone (Alpha)", "clapperboard")

local MarcoFolder = "MrHub_Marco"

local Fullpath = FileName_User .. "/" .. MarcoFolder
if not isfolder(Fullpath) then
    makefolder(Fullpath)
    print("Created folder:", Fullpath)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------ALL VALUE LOADING WORKING
local Auto_Start_L = false
local Auto_Retry_L = false

function StartGame()
   local auto_start = Vote_Start:InvokeServer()
end

function RetryGame()
   local auto_retry = Set_Game_Finish_Vote:InvokeServer("replay")
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------AUTO FARM ZONE

local AutoStart = AutoFarm:CreateToggle({
   Name = "Auto Start",
   CurrentValue = false,
   Flag = "Auto_Start",
   Callback = function(Value)
         Auto_Start_L = Value
   end,
})

local AutoRetry = AutoFarm:CreateToggle({
   Name = "Auto Retry",
   CurrentValue = false,
   Flag = "Auto_Retry",
   Callback = function(Value)
         Auto_Retry_L = Value
   end,
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------STILL CHECK ZONE

local PrintMoneyPlayer = StillCheck:CreateButton({
   Name = "Print Money Player",
   Callback = function()
   -- The function that takes place when the button is pressed
         if game.PlaceId ~= 8304191830 then
            print(MoneyPlayerText.Text)
         end
   end,
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------FARM GEMS ZONE
local Sakura_FarmGems = false
local Allow_Place = true
local Sakura_Unit = 1

local Sakura_Table = {
   [1] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -715.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
   [2] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -712.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
   [3] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -709.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)}
}

function Sakura_Farm()
   Allow_Place = false
   local Money = tonumber(MoneyPlayerText.Text)
   if Money >= 600 and Sakura_Unit < 4 then
      Spawn_Unit:InvokeServer(Sakura_Table[Sakura_Unit][1], Sakura_Table[Sakura_Unit][2])
      local Money = tonumber(MoneyPlayerText.Text)
      Sakura_Unit += 1
      task.wait(0.5)
      if Money >= 600 and Sakura_Unit < 4 then
         Spawn_Unit:InvokeServer(Sakura_Table[Sakura_Unit][1], Sakura_Table[Sakura_Unit][2])
         local Money = tonumber(MoneyPlayerText.Text)
         Sakura_Unit += 1
         task.wait(0.5)
         if Money >= 600 and Sakura_Unit < 4 then
            Spawn_Unit:InvokeServer(Sakura_Table[Sakura_Unit][1], Sakura_Table[Sakura_Unit][2])
            local Money = tonumber(MoneyPlayerText.Text)
            Sakura_Unit += 1
            task.wait(0.5)
         else
            Allow_Place = true
         end
      else
         Allow_Place = true
      end
   else
      Allow_Place = true
   end
end

local ToggleFarmGems = FarmGems:CreateToggle({
   Name = "Auto Farm Gems",
   CurrentValue = false,
   Flag = "Auto_Farm_Gems",
   Callback = function(Value)
         Sakura_FarmGems = Value
   end,
})

local Info_AutoFarmGems = FarmGems:CreateParagraph({
      Title = "How To Use This AutoFarm Gems", 
      Content = "Equip Sakura and Join INF Attack On Titan, Turn On AutoRetry And AutoStart, Enjoy!"
})

local DangerInfo_AutoFarmGems = FarmGems:CreateParagraph({
      Title = "ONLY TURN ON AUTOSTART, AUTORETRY AND AUTOFARMGEMS", 
      Content = ""
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------MARCO ZONE
local Cooldown = 4
local Choose_TableMarco = nil
local Choose_MarcoOrigin = LoadChoose_RecordFile

local Record_Marco_BOOLEAN = false
local Replay_Marco_BOOLEAN = false

local function listMacros()
    if isfolder(Fullpath) then
        local files = listfiles(Fullpath)
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

local function isNumeric(text)
    return string.match(text, "^%d+$") ~= nil
end

local MarcoList = MarcoZone:CreateDropdown({
   Name = "Marco List",
   Options = listMacros(),
   CurrentOption = {"nil"},
   MultipleOptions = false,
   Flag = "Marco_List", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Options)
   -- The function that takes place when the selected option is changed
   -- The variable (Options) is a table of strings for the current selected options
         Choose_TableMarco = Options
   end,
})

local RecordMarco = MarcoZone:CreateToggle({
   Name = "Record Marco",
   CurrentValue = false,
   Flag = "Record_Marco",
   Callback = function(Value)
         Record_Marco_BOOLEAN = Value
   end,
})

local ReplayMarco = AutoFarm:CreateToggle({
   Name = "Replay Marco",
   CurrentValue = false,
   Flag = "Replay_Marco",
   Callback = function(Value)
         Replay_Marco_BOOLEAN = Value
   end,
})

local Cooldown_PlaceUnit = MarcoZone:CreateInput({
   Name = "Cooldown",
   CurrentValue = "",
   PlaceholderText = "Cooldown",
   RemoveTextAfterFocusLost = false,
   Flag = "Cooldown_Unit",
   Callback = function(Text)
   -- The function that takes place when the input is changed
   -- The variable (Text) is a string for the value in the text box
         local CheckNumber = isNumeric(Text)
         if CheckNumber == true then
            Cooldown = tonumber(Text)
         else
            Cooldown = 4
         end
   end,
})

local CreateMarco = MarcoZone:CreateInput({
   Name = "Create Marco",
   CurrentValue = "",
   PlaceholderText = "Name Marco",
   RemoveTextAfterFocusLost = false,
   Flag = "Create_Marco",
   Callback = function(Text)
   -- The function that takes place when the input is changed
   -- The variable (Text) is a string for the value in the text box
      local function saveMarco(fileName, data)
         if not fileName:match("%.json$") then
            fileName = fileName .. ".json"
         end
            
         local jsonData = HttpService:JSONEncode(data)
         writefile(Fullpath .. "/" .. fileName, jsonData)
         print("Macro saved:", fileName)
      end

      if Text ~= "" then
         saveMarco(Text, {"Units:[]"})
         MarcoList:Refresh(listMacros()) -- The new list of options available.
      end
   end,
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------CHECK EVENT
Step_Record = 1

local TABLE_RECORD = {
   Type_Event = nil,
   Unit_Id = nil,
   Position = nil
}

local Online_RecordTable = {}

-- Danh sách tên event cần theo dõi (bạn có thể thêm vào nếu cần)
function CHECK_EVENT_SERVER()
   local TargetEventNames = {
    "spawn_unit", 
    "upgrade_unit_ingame"
}

-- Lấy metatable của game
   local mt = getrawmetatable(game)
   setreadonly(mt, false) -- Cho phép chỉnh sửa metatable

   local oldNamecall = mt.__namecall -- Lưu hàm gốc

   -- Hàm kiểm tra xem event có trong danh sách không
   local function isTargetEvent(remote)
       return table.find(TargetEventNames, remote.Name) ~= nil
   end

   -- Hook hàm __namecall để ghi nhận mọi dữ liệu gửi lên
   mt.__namecall = function(self, ...)
       local method = getnamecallmethod() -- Lấy tên phương thức (FireServer, InvokeServer, etc.)
       local args = {...} -- Lấy tất cả dữ liệu gửi vào

       -- Nếu là RemoteEvent hoặc RemoteFunction và có trong danh sách
       if isTargetEvent(self) and (method == "FireServer" or method == "InvokeServer") then
           --print("Event Triggered: ", self.Name)
           --print("Number of Arguments Sent: ", #args)

           -- Nếu cần gán tất cả dữ liệu vào biến, bạn có thể làm như sau:
           local arguments = args -- Gán toàn bộ dữ liệu vào bảng
           -- Sử dụng arguments[i] để truy cập dữ liệu cụ thể

           if #args > 1 and self.Name == "spawn_unit" then
              TABLE_RECORD.Type_Event = self.Name
              TABLE_RECORD.Unit_Id = arguments[1]
              TABLE_RECORD.Position = arguments[2]
           end

           if #args > 1 and TABLE_RECORD.Type_Event ~= nil and TABLE_RECORD.Unit_Id ~= nil and TABLE_RECORD.Position ~= nil then
              table.insert(Online_RecordTable, Step_Record, TABLE_RECORD)
              Step_Record += 1
           end

           print(Online_RecordTable)

           -- Duyệt qua từng argument và in ra thông tin
           --for i, arg in ipairs(args) do
               --print(string.format("Argument %d: %s", i, tostring(arg)))
           --end
       end

       return oldNamecall(self, ...) -- Gọi lại hàm gốc
   end

   -- Bật lại chế độ chỉ đọc sau khi chỉnh sửa xong
   setreadonly(mt, true)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Rayfield:LoadConfiguration()

LoadChoose_RecordFile = Choose_TableMarco[1]

if Auto_Start_L == true and game.PlaceId ~= 8304191830 then
   StartGame()
end

ResultsUI:GetPropertyChangedSignal("Enabled"):Connect(function()
   if Auto_Retry_L == true then
      RetryGame()
   end
end)

if Record_Marco_BOOLEAN == true game.PlaceId ~= 8304191830 then
      print("Check Call")
      CHECK_EVENT_SERVER()
end

MoneyPlayerText:GetPropertyChangedSignal("Text"):Connect(function()
   if Sakura_FarmGems == true and Allow_Place == true and Sakura_Unit < 4 and game.PlaceId ~= 8304191830 then
      Sakura_Farm()
   end
end)
