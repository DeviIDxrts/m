local SelfTab = Window:CreateTab("Self", nil)
SelfTab:CreateSlider({Name="WalkSpeed",Range={16,500},Increment=1,CurrentValue=16,Flag="Walkspeed",Callback=function(v) if _G.ws then _G.ws:Disconnect() end; _G.ws=game:GetService("RunService").Heartbeat:Connect(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed=v end) end})
SelfTab:CreateSlider({ Name="JumpPower", Range={50,300}, Increment=1, CurrentValue=50, Flag="JP", Callback=function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end })
local inf = false
game:GetService("UserInputService").JumpRequest:Connect(function()
    if inf then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
SelfTab:CreateToggle({
    Name = "Inf Jump",
    CurrentValue = false,
    Flag = "IJ",
    Callback = function(v) inf = v end
})
local ncConn
SelfTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NC",
    Callback = function(v)
        local char = game.Players.LocalPlayer.Character
        if v then
            ncConn = game:GetService("RunService").Stepped:Connect(function()
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end)
        else
            if ncConn then ncConn:Disconnect() end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and not part.CanCollide then
                    part.CanCollide = true
                end
            end
        end
    end
})
local fbConn
SelfTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Flag = "FB",
    Callback = function(v)
        if v then
            fbConn = game:GetService("RunService").Heartbeat:Connect(function()
                local l = game:GetService("Lighting")
                l.Brightness = 2
                l.ClockTime = 14
                l.FogEnd = 100000
                l.GlobalShadows = false
                l.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
            end)
        else
            if fbConn then fbConn:Disconnect() end
        end
    end
})
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local mouse = Players.LocalPlayer:GetMouse()
local tpConn
SelfTab:CreateToggle({
    Name = "Click TP (ALT)",
    CurrentValue = false,
    Flag = "CtrlClickTP",
    Callback = function(on)
        if on then
            tpConn = mouse.Button1Down:Connect(function()
                if UIS:IsKeyDown(Enum.KeyCode.LeftAlt) then
                    local hitPos = mouse.Hit.p + Vector3.new(0, 2.5, 0)
                    Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hitPos)
                end
            end)
        else
            if tpConn then tpConn:Disconnect() end
        end
    end
})
SelfTab:CreateButton({
    Name = "Aimbot (Menu)",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/n7UpKBrK"))()
    end
})
SelfTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
    end
})
