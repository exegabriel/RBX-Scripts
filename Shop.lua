local Functions={};
Functions.HttpGet=function(_,Link)
    local _=nil;
    return loadstring(game:HttpGet(Link,true))(_);
end;
local Https={
    Functions=Functions.HttpGet('https://raw.githubusercontent.com/exegabriel/RBX-Scripts/main/Functions.lua');
end;
local Shop={};
Shop.CreateItem=function(Configuration)
    local TweenService=game:GetService'TweenService';
    local ReplicatedStorage=game:GetService'ReplicatedStorage';
    local LocalPlayer=game:GetService'Players'.LocalPlayer or game:GetService'Players'.PlayerAdded:Wait();
    local MainUI=LocalPlayer.PlayerGui:FindFirstChild'MainUI';
    local BlacklistedNames={};
    local Shopping={
        Selected={};
    };
    local ItemsList=MainUI.ItemShop.Items;
    if ItemsList.ClassName~='ScrollingFrame' then
        local ScrollingFrame=Instance.new'ScrollingFrame';
        ScrollingFrame.Name='Items';
        ScrollingFrame.Active=true;
        ScrollingFrame.AnchorPoint=Vector2.new(.5,0);
        ScrollingFrame.BackgroundTransparency=1;
        ScrollingFrame.BorderSizePixel=0;
        ScrollingFrame.CanvasSize=UDim2.new(0,0,0,0);
        ScrollingFrame.Position=UDim2.new(.5,0,.18,0);
        ScrollingFrame.Size=UDim2.new(1,0,.6,0);
        ScrollingFrame.ZIndex=5;
        ScrollingFrame.HorizontalScrollBarInset=Enum.ScrollBarInset.Always;
        ScrollingFrame.ScrollBarThickness=0;
        local UIGridLayout=Instance.new'UIGridLayout';
        UIGridLayout.Parent=ScrollingFrame;
        UIGridLayout.SortOrder=Enum.SortOrder.LayoutOrder;
        UIGridLayout.CellPadding=UDim2.new(0,15,0,15);
        local UIPadding=Instance.new'UIPadding';
        UIPadding.Parent=ScrollingFrame;
        UIPadding.PaddingBottom=UDim.new(0,4);
        UIPadding.PaddingLeft=UDim.new(0,4);
        UIPadding.PaddingRight=UDim.new(0,4);
        UIPadding.PaddingTop=UDim.new(0,4);
        for _,Items in next,MainUI.ItemShop.Items:GetChildren() do
            if Items.ClassName=='TextButton' then
                Items.Parent=ScrollingFrame;
            end;
        end;
        MainUI.ItemShop.Items:Destroy();
        ScrollingFrame.Parent=MainUI.ItemShop;
        ScrollingFrame.UIGridLayout.CellSize=UDim2.new(.5,-8,0,ScrollingFrame.AbsoluteSize.Y/1*.31-4);
        spawn(function()
            local RawItemName=string.gsub(Configuration.ItemName,' ','');
            Configuration.ItemName=RawItemName;
            if ScrollingFrame:FindFirstChild('CustomItem_'..Configuration.ItemName) then
                ScrollingFrame['CustomItem_'..Configuration.ItemName]:Destroy();
            end;
            if ReplicatedStorage.ItemShop:FindFirstChild(Configuration.ItemName) then
                ReplicatedStorage.ItemShop[Configuration.ItemName]:Destroy();
            end;
            local Item=Https.Functions.LoadCustomInstance(Configuration.ItemID);
            local Configuration=Configuration;
            local TextButton=ScrollingFrame:FindFirstChildWhichIsA'TextButton':Clone();
            local Selected=TextButton:SetAttribute('Selected',false);
            local Connections={};
            TextButton.Visible=true;
            TextButton.Name='CustomItem_'..Configuration.ItemName;
            TextButton.Title.Text=Configuration.ItemName;
            TextButton.Desc.Text=Configuration.ItemDescription;
            TextButton.ImageLabel.Image=Https.Functions.LoadCustomAsset(Configuration.ImageID);
            if Configuration.Price[1] then
                TextButton.Price.Text=Configuration.Price[2];
            else
                TextButton.Price.Text='';
            end;
            if not Configuration.Stack[1] or Configuration.Stack[2]<=1 then
                TextButton.Stack.Visible=false;
            else
                TextButton.Stack.Visible=true;
                TextButton.Stack.Text='x'..Configuration.Stack[2];
            end;
            TextButton.Parent=ScrollingFrame;
            local Folder=Instance.new'Folder';
            Folder.Name=Configuration.ItemName;
            Folder.Parent=ReplicatedStorage.ItemShop;
            Folder:SetAttribute('Price',Configuration.Price);
            Connections.Select=TextButton.MouseButton1Down:Connect(function()
                Selected=not Selected;
                TextButton.BackgroundTransparency=Selected and .5 or .9;
                MainUI.Initiator.Main_Game.PreRun[Selected and 'Press' or 'PressDown']:Play();
                local Function=debug.getupvalues(getconnections(ScrollingFrame:FindFirstChildWhichIsA'TextButton'.MouseButton1Down)[1].Function);
                local SelectedItems=Function[1];
                if Selected then
                    SelectedItems[#SelectedItems+1]=Configuration.ItemName;
                    Shopping.Selected[#Shopping.Selected+1]=Item;
                else
                    table.remove(SelectedItems,table.find(SelectedItems,Configuration.ItemName));
                    table.remove(Shopping.Selected,table.find(Shopping.Selected,Item));
                end;
                Function[4]();
            end);
            local ButtonsCount=0;
            for _,Children in next,ScrollingFrame:GetChildren() do
                if Children.ClassName=='TextButton' and Children.Visible then
                    ButtonsCount+=1;
                end;
            end;
            local RowCount=math.round(ButtonsCount/2);
            local RowHeight=8+RowCount*(ScrollingFrame.AbsoluteSize.Y/1*.31-4)+(RowCount-1)*15;
            ScrollingFrame.CanvasSize=UDim2.new(0,0,0,RowHeight);
            spawn(function()
                local ncall;ncall=hookmetamethod(game,'__namecall',newcclosure(function(self,...)
                    local Args={
                        ...
                    };
                    if not checkcaller() and getnamecallmethod()=='FireServer' and tostring(self)=='PreRunShop' then
                        for i,Arguments in next,Args[1] do
                            if table.find(BlacklistedNames,Arguments) then
                                table.remove(Args[1],i);
                            end;
                        end;
                    end;
                    return ncall(self,unpack(Args));
                end));
                local ConfirmConnection;ConfirmConnection=MainUI.ItemShop.Confirm.MouseButton1Down:Connect(function()
                    ConfirmConnection:Disconnect();
                    for _,Selections in next,Shopping.Selected do
                        if typeof(Selections.Item)=='Instance' and Selections.Item.ClassName=='Tool' then
                            Selections.Item.Parent=LocalPlayer.Backpack;
                        end;
                    end;
                end);
            end);
        end);
    end;
end;
return Shop;
