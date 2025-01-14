print("THIS IS THE START OF THE SCRIPT")

local Vote_Start = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start")
local Set_Game_Finish_Vote = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("set_game_finished_vote")
local Spawn_Unit = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("spawn_unit")

--------------------------------------------------------------------------------Info AA
--game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units /unit = [number].Main.View.WorldModel.[name_unit]
---------------------------------------------------------------------------------------

local Unit_Table = {
   
}

local VoteTime = 0
--local UnitsEquip_Player = game.Players.LocalPlayer:WaitForChild("PlayerGui").spawn_units.lives.Frame.Units

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MrHub AA V0.0015 Alpha",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Waiting AA Script (MrHub V0.0015)",
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

local AutoStart = AutoFarm:CreateToggle({
   Name = "Auto Start",
   CurrentValue = false,
   Flag = "Auto_Start", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         if Value == true and VoteTime < 1 and game.PlaceId ~= 8304191830 then
            VoteTime += 1
            local auto_start = Vote_Start:InvokeServer()
         end
   end,
})

local AutoRetry = AutoFarm:CreateToggle({
   Name = "Auto Retry",
   CurrentValue = false,
   Flag = "Auto_Retry", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
   -- The function that takes place when the toggle is pressed
   -- The variable (Value) is a boolean on whether the toggle is true or false
         if Value == true and game.PlaceId ~= 8304191830 then
            local auto_replay = Set_Game_Finish_Vote:InvokeServer("replay")
         end
   end,
})

local PrintAllUnit_OwnerEquip = StillCheck:CreateButton({
   Name = "Print All Unit Equip",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})

Rayfield:LoadConfiguration()
