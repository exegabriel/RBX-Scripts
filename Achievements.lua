local Functions={};
Functions.HttpGet=function(Link)
    local Player=game:GetService'Players'.LocalPlayer or game:GetService'Players'.PlayerAdded:Wait();
    if Player.Parent=game:GetService'Players' then
        return loadstring(game:HttpGet(Link,true))();
    end;
end;
local Https={
    Functions=Functions.HttpGet('https://raw.githubusercontent.com/exegabriel/RBX-Scripts/main/Functions.lua');
end;
local Achievements={};
Achievements.GiveAchievement=function(Configuration)
    local TweenService=game:GetService'TweenService';
    local LocalPlayer=game:GetService'Players'.LocalPlayer or game:GetService'Players'.PlayerAdded:Wait();
    local MainUI=LocalPlayer.PlayerGui:FindFirstChild'MainUI';
    local AchievementHolder=MainUI:WaitForChild'AchievementsHolder'.Achievement;
    local AchievementTemplate=AchievementHolder:Clone();
    AchievementTemplate.Parent=AchievementHolder.Parent;
    AchievementTemplate.Name='LiveAchievement';
    local Achievement=AchievementTemplate;
    Achievement.Size=UDim2.new({0,0},{0,0});
    Achievement.Frame.Position=UDim2.new({1.1,0},{0,0});
    Achievement.Visible=true;
    local AchievementConfiguration=Configuration;
    if AchievementConfiguration.ImageID[1] then
        Achievement.Frame.ImageLabel.Image=Https.Functions.LoadCustomAsset(AchievementConfiguration.ImageID[2]);
    else
        Achievement.Frame.ImageLabel.Image='rbxassetid://10546856417';
    end;
    if AchievementConfiguration.Details[1] then
        Achievement.Frame.Details.Title.Text=AchievementConfiguration.Details.Title;
        Achievement.Frame.Details.Desc.Text=AchievementConfiguration.Details.Description;
        Achievement.Frame.Details.Reason.Text=AchievementConfiguration.Details.Reason;
    else
        Achievement.Frame.Details.Title.Text='Out Of My Way';
        Achievement.Frame.Details.Desc.Text="I'm walkin' here!";
        Achievement.Frame.Details.Reason.Text='Successfully survive Rush.';
    end;
    local TweenAnimation1=TweenService:Create(Achievement,TweenInfo.new(.8,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(1,0,.2,0)});
    TweenAnimation1:Play();
    TweenAnimation1.Completed:Wait();
    TweenService:Create(Achievement.Frame.Glow,TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{ImageTransparency=1}):Play();
    wait(8);
    local TweenAnimation2=TweenService:Create(Achievement.Frame,TweenInfo.new(.8,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(1.1,0,0,0)});
    TweenAnimation2:Play();
    TweenAnimation2.Completed:Wait();
    local TweenAnimation3=TweenService:Create(Achievement,TweenInfo.new(.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut),{Size=UDim2.new(1,0,-.1,0)});
    TweenAnimation3:Play();
    TweenAnimation3.Completed:Wait();
    Achievement:Destroy();
end;
return Achievements;
