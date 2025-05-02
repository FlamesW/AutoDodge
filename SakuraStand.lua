-- // Sakura Stand Auto Dodge V2 \\ --
-- shared.AutoDodge = true;
-- shared.Distance = 21;

-- // Made by @Flames9925 (Discord) \\ --
local CoreGui = game:GetService("StarterGui");

if shared.AutoDodge == true then
    CoreGui:SetCore("SendNotification",{Title = "@Flames9925",Text = "Auto Dodge Activated!~",Duration = 3.15});
else
    CoreGui:SetCore("SendNotification",{Title = "@Flames9925",Text = "Auto Dodge Deactivated!~",Duration = 3.15});
end

local RS = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LPlayer = Players.LocalPlayer;

local Hitbox = RS.GlobalUsedRemotes.ShowHitbox;

local UltraInstinct = function(Cframe)
    local PornHub = workspace.Living[LPlayer.Name].CDValues;
    local PlrPos = LPlayer.Character.HumanoidRootPart.Position;
    local Mag = (PlrPos - Cframe.Position).Magnitude;

    local NearestPos,NearestDis = nil,math.huge;

    if shared.AutoDodge == false or PornHub:FindFirstChild("OnCooldown") then
        return;
    end

    if Mag <= shared.Distance then
        NearestDis = Mag;NearestPos = Cframe.Position;
    end

    if NearestPos then
        local Direction = (PlrPos - NearestPos).Unit;
        local Ddetector = (math.random(0,1) == 0 and 1 or -1);
        local LeftAndRight = Direction:Cross(Vector3.new(0,1,0)).Unit * Ddetector;
        local Offset = LeftAndRight * 11.75;

        Offset = Vector3.new(Offset.X,0,Offset.Z);
        LPlayer.Character:MoveTo(PlrPos + Offset);

        CoreGui:SetCore("SendNotification",{Title = "@Flames9925",Text = "Attempted "..(Ddetector == 1 and "Right Dodge" or "Left Dodge").." [ "..math.floor(Mag).." studs away]",Duration = 1.15});
    end
end

if not shared.Loaded then shared.Loaded = true;
    Hitbox.OnClientEvent:Connect(UltraInstinct);
end
