local Vote_Start = game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start")

local VoteTime = 0

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Tạo giao diện chính
local Window = OrionLib:MakeWindow({
    Name = "MrHub", 
    HidePremium = false, 
    SaveConfig = true, -- Bật lưu config
    ConfigFolder = "MrHubConfig" -- Tên thư mục lưu config
})

-- Tạo tab
local Tab = Window:MakeTab({
    Name = "Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false,
})

-- Thêm Toggle có lưu cấu hình
Tab:AddToggle({
    Name = "Auto Start", -- Tên toggle
    Default = false, -- Giá trị mặc định nếu không có file config
    Save = true, -- Lưu giá trị vào config
    Flag = "AutoStartGame_Toggle", -- Tên flag để lưu
    Callback = function(Value)
        print("Auto Start:", Value) -- In ra giá trị hiện tại
        if Value and VoteTime < 1 then
            VoteTime += 1
            -- Gọi hàm từ server
            local result = Vote_Start:InvokeServer()
        end
    end
})

-- Hiển thị GUI
OrionLib:Init()

-- Lấy giá trị sau khi giao diện được khởi tạo
local AutoStartGameCF = OrionLib.Flags["AutoStartGame_Toggle"].Value
print("AutoStartGameCF:", AutoStartGameCF)

if AutoStartGameCF then
    print("Auto Start đã bật từ file config!")
end
