local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/hun/main/jmlibrary1.lua"))();

local window = library:new("脚本")

local 通用 = window:Tab("通用",'图片ID')

local Wan =通用:section("通用",true) 

通用:Button("按钮", function()
    
end)

通用:Toggle("开关", "Wan", false, function(a)
    
end)

通用:Slider('滑块', 'Wan', 0, 0, 9999,false, function(b)
    
end)

通用:Textbox("输入", "Wan", "输入", function(c)
  
end)

通用:Dropdown("下拉式", "Wan", {
    "额"
}, function(d)
    
end)