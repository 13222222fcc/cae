local library = loadstring(game:HttpGet("https://pastebin.com/raw/3vQbADjh", true))()

if not success then
print("w脚本")  
    return
end

local window = library:new("挽脚本")

local wasu = window:Tab("关于作者",'84830962019412')

local wn =wasu:section("乱",true)

wn:Button("复制群号", function(j)
    
end)

    bin:Label("作者wnq")

wn:Toggle("开关", "FengYu", false, function(a)
    
end)

wn:Slider('滑块', 'FengYu', 0, 0, 9999,false, function(b)
    
end)

wn:Textbox("输入", "FengYu", "输入", function(c)
  
end)

wn:Dropdown("下拉式", "FengYu", {
    "额"
}, function(d)
    
end)

local credits = creds:section("Ul设置", true)

credits:Toggle("移除UI辉光", "", false, function(state)
        if state then
            game:GetService("CoreGui")["frosty is cute"].Main.DropShadowHolder.Visible = false
        else
            game:GetService("CoreGui")["frosty is cute"].Main.DropShadowHolder.Visible = true
        end
    end)

    credits:Toggle("彩虹UI", "", false, function(state)
        if state then
            game:GetService("CoreGui")["frosty is cute"].Main.Style = "DropShadow"
        else
            game:GetService("CoreGui")["frosty is cute"].Main.Style = "Custom"
        end
    end)
credits:Toggle("脚本框架变小一点", "", false, function(state)
        if state then
        game:GetService("CoreGui")["frosty"].Main.Style = "DropShadow"
        else
            game:GetService("CoreGui")["frosty"].Main.Style = "Custom"
        end
    end)
    
        credits:Button("摧毁GUI",function()
            game:GetService("CoreGui")["frosty is cute"]:Destroy()
        end)


local wasu = window:Tab("甬用",'84830962019412')

local wn =wasu:section("通用",true)

wn:Toggle("某个东西", "FengYu", false, function(a)

