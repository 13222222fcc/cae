    local library = loadstring(game:HttpGet(('https://github.com/DevSloPo/Auto/raw/main/Ware-obfuscated.lua')))()

    local window = library:new("XV名字")
    local XVHub = window:Tab("关于", "7733774602")
    local XV = XVHub:section("示例", true)
    
    XV:Label("文本标签")
    
    XV:Button(
        "点击",
        function()
            
        end)
    
    XV:Toggle("开关", "", false, function(V)

    end)
    
    XV:Slider("滑块", "", 16, 0, 100, false, function(v)

    end)
    
    XV:Dropdown("Dropdown", "", { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }, function(s)
	print(s)
    end)

    XV:Textbox("输入文本", "", "输入", function(s)
	
    end)    
    
    local XKHub = window:Tab("其他", "78892482588180")
    local XV = XKHub:section("内容", true)
    
    XV:Label("文本标签")
    
    XV:Button(
        "点击",
        function()
            
        end)
    
    XV:Toggle("开关", "", false, function(state)

    end)
    
    XV:Slider("滑块", "", 16, 0, 100, false, function(v)

    end)
    
    XB:Dropdown("Dropdown", "", { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }, function(s)
	print(s)
    end)

    XV:Textbox("输入文本", "", "输入", function(s)
	
    end)
