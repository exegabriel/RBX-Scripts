local TweenService=game:GetService'TweenService';
local UI={};
UI.Create=function(Class,Properties,Radius)
    local Instance=Instance.new(Class);
    for i,Properties in next,Properties do
        if i~='Parent' then
            if typeof(Properties)=='Instance' then
                Properties.Parent=Instance;
            else
                Instance[i]=Properties;
            end;
        end;
    end;
    if Radius then
        local UICorner=Instance.new('UICorner',Instance);
        UICorner.CornerRadius=Radius;
    end;
    return Instance;
end;
UI.MakeDraggable=function(Object,Drag,Smoothness)
    local StartPosition,Dragging=nil,false;
    Drag.InputBegan:Connect(function(Input)
        if Input.UserInputType==Enum.UserInputType.MouseButton1 then
            Dragging=true;
            StartPosition=Vector2.new(Mouse.X-Object.AbsolutePosition.X,Mouse.Y-Object.AbsolutePosition.Y);
        end;
    end);
    Drag.InputEnded:Connect(function(Input)
        if Input.UserInputType==Enum.UserInputType.MouseButton1 then
            Dragging=false;
        end;
    end);
    Mouse.Move:Connect(function()
        if Dragging then
            TweenService:Create(Object,TweenInfo.new(math.clamp(Smoothness,0,1),Enum.EasingStyle.Sine),{Position=UDim2.new(0,Mouse.X-StartPosition.X,0,Mouse.Y-StartPosition.Y)}):Play();
        end;
    end);
end;
return UI;
