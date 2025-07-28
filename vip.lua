local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local triggerPosition = Vector3.new(246.919174, 108.341454, -1441.96545)
local triggerRadius = 5

local destinationCFrame = CFrame.new(
    -3260.28662, 529.138794, -2152.99146,
    -1.1920929e-07, 0, 1.00000012,
    0, 1, 0,
    -1.00000012, 0, -1.1920929e-07
)

local function createProximityPrompt()
    local part = Instance.new("Part")
    part.Name = "CustomTriggerPart"
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Size = Vector3.new(4,4,4)
    part.CFrame = CFrame.new(triggerPosition)
    part.Parent = Workspace

    local prompt = Instance.new("ProximityPrompt")
    prompt.ActionText = "Press E"
    prompt.ObjectText = "VIP Teleporter"
    prompt.KeyboardKeyCode = Enum.KeyCode.E
    prompt.HoldDuration = 0
    prompt.Parent = part

    return prompt
end

local customPrompt = createProximityPrompt()

task.spawn(function()
    repeat task.wait() until Workspace:FindFirstChild("Prompts") and Workspace.Prompts:FindFirstChild("VipProximityPrompt")
    Workspace.Prompts.VipProximityPrompt:Destroy()
end)

task.spawn(function()
    repeat task.wait() until Workspace:FindFirstChild("VipAreaField")
    Workspace.VipAreaField:Destroy()
end)

task.spawn(function()
    repeat task.wait() until Workspace:FindFirstChild("Prompts") and Workspace.Prompts:FindFirstChild("VipPromptBack")
    Workspace.Prompts.VipPromptBack:Destroy()
end)

task.spawn(function()
    local promptBackParent = Workspace:WaitForChild("Prompts"):WaitForChild("VipPromptBack")
    local backPart = Instance.new("Part")
    backPart.Name = "CustomBackTriggerPart"
    backPart.Anchored = true
    backPart.CanCollide = false
    backPart.Transparency = 1
    backPart.Size = Vector3.new(4,4,4)
    backPart.CFrame = promptBackParent.CFrame
    backPart.Parent = Workspace

    local backPrompt = Instance.new("ProximityPrompt")
    backPrompt.ActionText = "Press E"
    backPrompt.ObjectText = "VIP Teleporter"
    backPrompt.KeyboardKeyCode = Enum.KeyCode.E
    backPrompt.HoldDuration = 0
    backPrompt.Parent = backPart

    backPrompt.Triggered:Connect(function(player)
        if player == LocalPlayer then
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(triggerPosition)
            end
        end
    end)
end)

customPrompt.Triggered:Connect(function(player)
    if player == LocalPlayer then
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = destinationCFrame
        end
    end
end)
