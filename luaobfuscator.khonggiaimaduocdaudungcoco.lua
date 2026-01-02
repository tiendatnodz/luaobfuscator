local Players=game:GetService("Players")
local lp=Players.LocalPlayer

local gui=Instance.new("ScreenGui")
gui.Name="NexusChangeSkin"
gui.ResetOnSpawn=false
gui.Parent=lp:WaitForChild("PlayerGui")

local main=Instance.new("Frame",gui)
main.Size=UDim2.new(0,300,0,190)
main.Position=UDim2.new(0.5,-150,0.5,-95)
main.BackgroundColor3=Color3.fromRGB(20,20,28)
main.BackgroundTransparency=0.15
main.Active=true
main.Draggable=true
Instance.new("UICorner",main).CornerRadius=UDim.new(0,16)

local stroke=Instance.new("UIStroke",main)
stroke.Color=Color3.fromRGB(120,140,255)
stroke.Thickness=1
stroke.Transparency=0.6

local gradient=Instance.new("UIGradient",main)
gradient.Color=ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(35,35,55)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(18,18,26))
}
gradient.Rotation=90

local title=Instance.new("TextLabel",main)
title.Size=UDim2.new(1,0,0,38)
title.BackgroundTransparency=1
title.Text="NEXUS • CHANGE SKIN"
title.TextColor3=Color3.fromRGB(210,220,255)
title.Font=Enum.Font.GothamBold
title.TextSize=15

local line=Instance.new("Frame",main)
line.Size=UDim2.new(1,-30,0,1)
line.Position=UDim2.new(0,15,0,38)
line.BackgroundColor3=Color3.fromRGB(120,140,255)
line.BackgroundTransparency=0.7

local box=Instance.new("TextBox",main)
box.PlaceholderText="Nhập tên người chơi..."
box.Size=UDim2.new(1,-40,0,36)
box.Position=UDim2.new(0,20,0,55)
box.BackgroundColor3=Color3.fromRGB(30,30,40)
box.BackgroundTransparency=0.1
box.TextColor3=Color3.new(1,1,1)
box.PlaceholderColor3=Color3.fromRGB(170,180,210)
box.Font=Enum.Font.Gotham
box.TextSize=13
box.ClearTextOnFocus=false
Instance.new("UICorner",box).CornerRadius=UDim.new(0,12)

local btn=Instance.new("TextButton",main)
btn.Text="CHANGE SKIN"
btn.Size=UDim2.new(1,-40,0,38)
btn.Position=UDim2.new(0,20,0,100)
btn.BackgroundColor3=Color3.fromRGB(90,110,255)
btn.BackgroundTransparency=0.05
btn.TextColor3=Color3.new(1,1,1)
btn.Font=Enum.Font.GothamBold
btn.TextSize=14
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,14)

local btnGrad=Instance.new("UIGradient",btn)
btnGrad.Color=ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(120,150,255)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(70,90,220))
}
btnGrad.Rotation=90

local status=Instance.new("TextLabel",main)
status.Size=UDim2.new(1,-40,0,26)
status.Position=UDim2.new(0,20,0,145)
status.BackgroundTransparency=1
status.Text=""
status.TextColor3=Color3.fromRGB(220,230,255)
status.Font=Enum.Font.Gotham
status.TextSize=12

local function n(m)status.Text=m end

local function a(u)
 local ok,id=pcall(function()return Players:GetUserIdFromNameAsync(u)end)
 if not ok then n("Không tìm thấy người chơi!")return end
 n("Đang tải skin...")
 local ok2,ap=pcall(function()return Players:GetCharacterAppearanceAsync(id)end)
 if not ok2 or not ap then n("Không tải được skin!")return end
 local c=lp.Character
 if not c or not c:FindFirstChild("Humanoid")then n("Không tìm thấy nhân vật!")return end
 for _,v in pairs(c:GetChildren())do
  if v:IsA("Accessory")or v:IsA("Shirt")or v:IsA("Pants")or v:IsA("CharacterMesh")then v:Destroy()end
 end
 for _,v in pairs(ap:GetChildren())do
  if v:IsA("Accessory")or v:IsA("Shirt")or v:IsA("Pants")or v:IsA("CharacterMesh")then
   v:Clone().Parent=c
  elseif v:IsA("BodyColors")then
   local o=c:FindFirstChildOfClass("BodyColors")
   if o then o:Destroy()end
   v:Clone().Parent=c
  end
 end
 local d
 local ok3,dd=pcall(function()return Players:GetHumanoidDescriptionFromUserId(id)end)
 if ok3 and dd then d=dd end
 if d then
  local h=c:FindFirstChildOfClass("Humanoid")
  if h then pcall(function()h:ApplyDescriptionClientServer(d)end)end
 end
 n("Đã áp dụng skin!")
end

btn.MouseButton1Click:Connect(function()
 local u=box.Text
 if u==""then n("Hãy nhập tên!")else a(u)end
end)