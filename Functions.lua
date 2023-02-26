local Players=game:GetService'Players';
local LocalPlayer=Players.LocalPlayer or Players.PlayerAdded:Wait();
local ModuleScripts={};
local Functions={
    IsClosure=is_synapse_function or iskrnlclosure or isexecutorclosure;
    SetIdentity=(syn and syn.set_thread_identity) or set_thread_identity or setthreadidentity or setthreadcontext;
    GetIdentity=(syn and syn.get_thread_identity) or get_thread_identity or getthreadidentity or getthreadcontext;
    Request=(syn and syn.request) or http_request or request;
    QueueOnTeleport=(syn and syn.queue_on_teleport) or queue_on_teleport;
    GetAsset=getsynasset or getcustomasset;
};
Functions.ConvertToAsset=function(String)
    if isfile(String) then
        return Functions.GetAsset(String);
    elseif String:find('rbxassetid') or tonumber(String) then
        local NumberID=String:gsub('%D','');
        return 'rbxassetid://'..NumberID;
    elseif String:find('http') then
        local Request=Functions.Request({Url=String,Method='GET'});
        if Request.Success then
            local Name='CustomObject_'..tick()..'.txt';
            writefile(Name,Request.Body);
            return Functions.GetAsset(Name);
        end;
    end;
    return String;
end;
Functions.GetPlayerByName=function(Name)
    for _,Player in next,Players:GetPlayers() do
        if Player.Name:lower():find(Name) or Player.DisplayName:lower():find(Name) then
            return Player;
        end;
    end;
end;
Functions.LoadModule=function(Name)
    for _,ModuleScript in next,ModuleScripts do
        if ModuleScript.Name==Name then
            return require(ModuleScript);
        end;
    end;
end;
Functions.LoadCustomAsset=function(String)
    if String=='' then
        return ''
    elseif String:Find'rbxassetid://' or String:Find'roblox.com' or tonumber(String) then
        local NumberID=String:gsub('%D','');
        return 'rbxassetid://'..NumberID;
    else
        if isfile(String) then
            return Functions.GetAsset(String);
        else
            local FileName='CustomObject_'..tick()..'.txt';
            writefile(FileName,Functions.Request({Url=String,Method='GET'}).Body);
            return Functions.GetAsset(FileName);
        end;
    end;
end;
Functions.LoadCustomInstance=function(String)
    if String~='' then
        if String:find'rbxassetid://' or String:find'roblox.com' or tonumber(String) then
            local NumberID=String:gsub('%D','');
            return game:GetObjects('rbxassetid://'..NumberID)[1];
        else
            if isfile(String) then
                return game:GetObjects(Functions.GetAsset(String))[1];
            else
                local FileName='CustomObject_'..tick()..'.txt';
                writefile(FileName,Functions.Request({Url=String,Method='Get'}).Body);
                return game:GetObjects(Functions.GetAsset(FileName))[1];
            end;
        end;
    end;
end;
for _,Descendants in next,game:GetDescendants() do
    if Descendants.ClassName=='ModuleScript' then
        table.insert(ModuleScripts,Descendants);
    end;
end;
for Name,Function in next,Functions do
    if typeof(Function)=='Function' then
        getgenv()[Name]=Function;
    end;
end;
game.DescendantAdded:Connect(function(Descendant)
    if Descendant.ClassName=='ModuleScript' then
        table.insert(ModuleScripts,Descendant)
    end;
end);
Players.PlayerRemoving:Connect(function(Player)
    if Player==LocalPlayer then
        for _,Files in next,listfiles'' do
            if Files:find'CustomObject' then
                delfile(Files);
            end;
        end;
    end;
end);
return Functions;
