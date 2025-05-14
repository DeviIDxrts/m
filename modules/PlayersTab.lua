local PlayerTab = Window:CreateTab("Players", nil)
local bringPlayers = false
local bringLoop = nil
local bringDistance = 5 
local PlayerName1 = nil
local SelectedDisplayName = nil
local playerMap = {}
local function GetPlayers()
    local players = { "All" }
    playerMap = {}

    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        local displayName = player.DisplayName
        table.insert(players, displayName)
        playerMap[displayName] = player
    end

    return players
end
local PlayerDropdown = PlayerTab:CreateDropdown({
    Name = "Select Player",
    Options = GetPlayers(),
    CurrentOption = {},
    MultipleOptions = false,
    Flag = "PlayerDropdown",
    Callback = function(Options)
        SelectedDisplayName = Options[1]
        PlayerName1 = playerMap[SelectedDisplayName] and playerMap[SelectedDisplayName].Name or nil
    end,
})
local function UpdateDropdown()
    local players = GetPlayers()
    if SelectedDisplayName and not table.find(players, SelectedDisplayName) then
        SelectedDisplayName = nil
        PlayerName1 = nil
        PlayerDropdown:Refresh(players)
        PlayerDropdown:Set({"All"})
    else
        PlayerDropdown:Refresh(players)
        if SelectedDisplayName then
            PlayerDropdown:Set({SelectedDisplayName})
        else
            PlayerDropdown:Set({"All"})
        end
    end
end
game:GetService("Players").PlayerAdded:Connect(UpdateDropdown)
game:GetService("Players").PlayerRemoving:Connect(UpdateDropdown)
UpdateDropdown()
PlayerTab:CreateInput({
    Name = "Bring Distance",
    PlaceholderText = "Enter distance (e.g. 5)",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        local num = tonumber(input)
        if num then
            bringDistance = num
            print("Bring distance set to:", bringDistance)
        end
    end
})
local function getHRP(player)
    if not player then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then return hrp end
    local start = tick()
    while tick() - start < 5 do
        hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp end
        task.wait(0.1)
    end
end
PlayerTab:CreateToggle({
    Name = "Bring Players",
    CurrentValue = false,
    Callback = function(on)
        bringPlayers = on
        if on then
            bringLoop = task.spawn(function()
                local localPlayer = game.Players.LocalPlayer
                while bringPlayers do
                    local localHRP = getHRP(localPlayer)
                    if localHRP then
                        if SelectedDisplayName == "All" then
                            for _, pl in ipairs(game.Players:GetPlayers()) do
                                if pl ~= localPlayer then
                                    local hrp = getHRP(pl)
                                    if hrp then
                                        hrp.CFrame = localHRP.CFrame * CFrame.new(0, 0, -bringDistance)
                                    end
                                end
                            end
                        else
                            local target = playerMap[SelectedDisplayName]
                            if target then
                                local hrp = getHRP(target)
                                if hrp then
                                    hrp.CFrame = localHRP.CFrame * CFrame.new(0, 0, -bringDistance)
                                end
                            end
                        end
                    end
                    task.wait(0.2)
                end
            end)
        elseif bringLoop then
            task.cancel(bringLoop)
        end
    end
})
PlayerTab:CreateButton({
    Name = "Teleport to Selected",
    Callback = function()
        if SelectedDisplayName == "All" or not SelectedDisplayName then
            Rayfield:Notify({Title="TP Failed", Content="Select a single player!", Duration=3, Image=4483362458})
            return
        end
        local target = playerMap[SelectedDisplayName]
        local hrp = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = hrp.CFrame
            Rayfield:Notify({Title="Teleported", Content="You are now at "..SelectedDisplayName, Duration=3, Image=4483362458})
        else
            Rayfield:Notify({Title="TP Failed", Content="Can't find "..SelectedDisplayName, Duration=3, Image=4483362458})
        end
    end,
})
