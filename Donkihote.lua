print("THIS IS THE START OF THE SCRIPT")

local Vote_Start = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start")
local Set_Game_Finish_Vote = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("set_game_finished_vote")
local Spawn_Unit = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("spawn_unit")

local MoneyPlayerText = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("spawn_units").Lives.Frame.Resource.Money.text
local HealthGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Waves").HealthBar.HPDisplay --150/150 text
local VoteStartGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("VoteStart")

local textHealth = HealthGui.Text
local numberHealth = tonumber(string.match(textHealth, "(%d+)/"))

local HealthBase = Instance.new("IntValue")
HealthBase.Parent = game.Players.LocalPlayer
HealthBase.Value = numberHealth

--------------------------------------------------------------------------------Info AA
--game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units /unit = [number].Main.View.WorldModel.[name_unit]
---------------------------------------------------------------------------------------

local Unit_Table = {
   luffy_christmas
}

--local UnitsEquip_Player = game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MrHub AA V0.0031 Alpha",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Waiting AA Script (MrHub V0.0031)",
   LoadingSubtitle = "by MrHub",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
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
local FarmGems = Window:CreateTab("FarmGems(Alpha)", "book-dashed")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------ALL VALUE LOADING WORKING
local Auto_Start_L = false
local Auto_Retry_L = false

function StartGame()
   local auto_start = Vote_Start:InvokeServer()
end

function RetryGame()
   print("They Call ME!")
   print(HealthBase.Value)
   if Auto_Retry_L == true and HealthBase.Value < 1 and game.PlaceId ~= 8304191830 then
      local auto_replay = Set_Game_Finish_Vote:InvokeServer("replay")
   end
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

local Press_ToPlace = StillCheck:CreateButton({
   Name = "Place Christmas Luffy",
   Callback = function()
   -- The function that takes place when the button is pressed
         if game.PlaceId ~= 8304191830 then
            Spawn_Unit:InvokeServer("{563b4847-1e72-46f2-82e5-81a3091e6c29}", CFrame.new(-2946.20361, 91.8062057, -740.202026, 1, 0, 0, 0, 1, 0, 0, 0, 1))
         end
   end,
})

local PrintMoneyPlayer = StillCheck:CreateButton({
   Name = "Print Money Player",
   Callback = function()
   -- The function that takes place when the button is pressed
         if game.PlaceId ~= 8304191830 then
            print(MoneyPlayerText.Text)
         end
   end,
})

local PrintHealthBase = StillCheck:CreateButton({
   Name = "Print Health Base",
   Callback = function()
   -- The function that takes place when the button is pressed
         if game.PlaceId ~= 8304191830 then
            print(HealthBase.Value)
         end
   end,
})

local PrintRetryButton = StillCheck:CreateButton({
   Name = "Print Retry Button",
   Callback = function()
   -- The function that takes place when the button is pressed
         if game.PlaceId ~= 8304191830 then
            print(AutoRetry)
         end
   end,
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------------FARM GEMS ZONE

local ToggleFarmGems = FarmGems:CreateToggle({
   Name = "Auto Farm Gems",
   CurrentValue = false,
   Flag = "Auto_Farm_Gems", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         if Value == true and game.PlaceId ~= 8304191830 then
            Num_Sakura = 1
            local Sakura_Table = {
               [1] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -715.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
               [2] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -714.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)},
               [3] = {"{27b582bb-e814-4847-a519-ed1d9062c748}", CFrame.new(-2967.56396, 33.7417984, -713.313049, 1, 0, 0, 0, 1, 0, 0, 0, 1)}
            }
            local function onMoneyChanged()
               local money = tonumber(MoneyPlayerText.Text)
               if money >= 1800 and Num_Sakura <= 3 then
                  for i=1, 3 do
                     Spawn_Unit:InvokeServer(Sakura_Table[i][1], Sakura_Table[i][2])
                     Num_Sakura += 1
                     task.wait(1)
                  end
               end
            end

            MoneyPlayerText:GetPropertyChangedSignal("Text"):Connect(onMoneyChanged)
         end
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

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Rayfield:LoadConfiguration()

textHealth:GetPropertyChangedSignal("Text"):Connect(function()
    local numberHealth = tonumber(string.match(textHealth, "(%d+)/"))
    HealthBase.Value = numberHealth
end)


if Auto_Start_L == true and game.PlaceId ~= 8304191830 then
   StartGame()
end

HealthBase.Changed:Connect(RetryGame)
