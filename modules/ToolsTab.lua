local ToolsTab = Window:CreateTab("Tools", 4483362458)
local toolSpawnFolder = workspace:WaitForChild("Map"):WaitForChild("ToolSpawns")
local SelectedToolName
local ToolDropdown
local function GetToolNames()
    local t = {}
    for _, item in ipairs(toolSpawnFolder:GetChildren()) do
        if item:IsA("BasePart") and item:FindFirstChild("ClickDetector") then
            t[#t+1] = item.Name
        end
    end
    table.sort(t)
    return t
end
local function CollectToolByName(name)
    local pl = game.Players.LocalPlayer
    local char = pl.Character or pl.CharacterAdded:Wait()
    if not char.PrimaryPart then char:GetPropertyChangedSignal("PrimaryPart"):Wait() end
    local orig = char.PrimaryPart.Position
    for _, item in ipairs(toolSpawnFolder:GetChildren()) do
        if item.Name == name then
            char:SetPrimaryPartCFrame(item.CFrame)
            task.wait(0.2)
            fireclickdetector(item.ClickDetector)
            char:SetPrimaryPartCFrame(CFrame.new(orig))
            Rayfield:Notify({Title="Tool Collected", Content=name.." has been collected!", Duration=3.5, Image=4483362458})
            return
        end
    end
end
ToolDropdown = ToolsTab:CreateDropdown({
    Name = "Select Tool",
    Options = GetToolNames(),
    CurrentOption = {},
    Flag = "ToolDropdown",
    Callback = function(opt)
        SelectedToolName = opt[1]
    end,
})
ToolsTab:CreateButton({
    Name = "Get Selected Tool",
    Callback = function()
        if SelectedToolName then
            CollectToolByName(SelectedToolName)
        else
            Rayfield:Notify({Title="No Tool Selected", Content="Choose a tool first!", Duration=2, Image=4483362458})
        end
    end,
})
local function UpdateDropdown()
    local names = GetToolNames()
    ToolDropdown:Refresh(names)
    if SelectedToolName and table.find(names, SelectedToolName) then
        ToolDropdown:Set({SelectedToolName})
    else
        SelectedToolName = nil
    end
end
toolSpawnFolder.ChildAdded:Connect(UpdateDropdown)
toolSpawnFolder.ChildRemoved:Connect(UpdateDropdown)
UpdateDropdown()
ToolsTab:CreateButton({
    Name = "Give All Guns",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local tp = character:WaitForChild("HumanoidRootPart")
        local originalPos = tp.Position
        local tempPos = Vector3.new(5676.88916, 7485.48877, 9096.6377, -0.0295563228, 6.80940531e-08, 0.999563098, 2.70988165e-09, 1, -6.80436827e-08, -0.999563098, 6.97576608e-10, -0.0295563228)
        tp.CFrame = CFrame.new(tempPos)
        task.wait(1)
        local tempPos = Vector3.new(3982.34351, 7485.38818, 13355.6367, 0.999932468, -6.11310327e-08, 0.0116226422, 6.10045845e-08, 1, 1.12338139e-08, -0.0116226422, -1.05240208e-08, 0.999932468)
        tp.CFrame = CFrame.new(tempPos)
        task.wait(1)
        local sheriffOffice = workspace:WaitForChild("Map"):WaitForChild("SHERIFF"):FindFirstChild("Sheriff's office")
        local givers = {
            sheriffOffice and sheriffOffice:FindFirstChild("compact revolver giver"),
            sheriffOffice and sheriffOffice:FindFirstChild("revolver giver"),
            workspace.Map.ToolSpawns:FindFirstChild("armory spawn"),
            workspace.Map:FindFirstChild("officer rifle")
        }
        for _, giver in pairs(givers) do
            if giver and giver:IsA("BasePart") and giver:FindFirstChildOfClass("ClickDetector") then
                tp.CFrame = giver.CFrame + Vector3.new(0, 3, 0)
                task.wait(0.25)
                fireclickdetector(giver:FindFirstChildOfClass("ClickDetector"))
            end
        end
        tp.CFrame = CFrame.new(originalPos)
        Rayfield:Notify({Title="Give All Guns",Content="Done!",Duration=3.5,Image=4483362458})
    end
})
ToolsTab:CreateButton({  
   Name = "Gun Shop",  
   Callback = function()  
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3504.80615, 7486.1084, 13859.3701,-0.0417456143, -1.4153354e-09, -0.999128282, 8.55658655e-09, 1, -1.77408188e-09, 0.999128282, -8.62318839e-09, -0.0417456143)
   end,  
})  
