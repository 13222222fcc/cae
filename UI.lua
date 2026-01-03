-- WANB UI FRAMEWORK - COLUMN / LIST STYLE
-- Single File | Pure English | Column-Based Layout
-- Delta Executor Compatible

local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')

local LocalPlayer = Players.LocalPlayer

local WANB = {}
WANB.__index = WANB

local ScreenGui = Instance.new('ScreenGui')
ScreenGui.Name = 'WANB_UI_Column'
pcall(function() ScreenGui.Parent = game.CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild('PlayerGui') end

-- Theme
local Theme = {
    Background = Color3.fromRGB(90,90,90),
    Element = Color3.fromRGB(255,255,255),
    Text = Color3.fromRGB(0,0,0)
}

-- Utility
local function Create(class)
    return function(props)
        local inst = Instance.new(class)
        for k,v in pairs(props) do
            if k ~= 'Children' then inst[k] = v end
        end
        if props.Children then
            for _,c in ipairs(props.Children) do c.Parent = inst end
        end
        return inst
    end
end

-- Window
function WANB:CreateWindow(cfg)
    local Window = {}
    Window.Tabs = {}

    local Main = Create('Frame'){
        Parent = ScreenGui,
        Size = UDim2.new(0,720,0,520),
        Position = UDim2.new(0.5,-360,0.5,-260),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0
    }

    local Sidebar = Create('Frame'){
        Parent = Main,
        Size = UDim2.new(0,170,1,0),
        BackgroundColor3 = Theme.Element,
        BorderSizePixel = 0
    }

    local Content = Create('Frame'){
        Parent = Main,
        Position = UDim2.new(0,170,0,0),
        Size = UDim2.new(1,-170,1,0),
        BackgroundTransparency = 1
    }

    function Window:CreateTab(name)
        local Tab = {}

        local TabButton = Create('TextButton'){
            Parent = Sidebar,
            Size = UDim2.new(1,0,0,40),
            Text = name,
            BackgroundColor3 = Theme.Element,
            TextColor3 = Theme.Text
        }

        local Page = Create('ScrollingFrame'){
            Parent = Content,
            Size = UDim2.new(1,0,1,0),
            CanvasSize = UDim2.new(0,0,0,0),
            ScrollBarImageTransparency = 0.4,
            Visible = false,
            BackgroundTransparency = 1
        }

        local Layout = Instance.new('UIListLayout')
        Layout.Padding = UDim.new(0,8)
        Layout.Parent = Page

        Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _,t in pairs(Window.Tabs) do t.Page.Visible = false end
            Page.Visible = true
        end)

        function Tab:CreateButton(cfg)
            local Btn = Create('TextButton'){
                Parent = Page,
                Size = UDim2.new(1,-20,0,40),
                Text = cfg.Name,
                BackgroundColor3 = Theme.Element,
                TextColor3 = Theme.Text
            }
            Btn.MouseButton1Click:Connect(function()
                if cfg.Callback then cfg.Callback() end
            end)
        end

        function Tab:CreateToggle(cfg)
            local state = cfg.CurrentValue or false
            local Btn = Create('TextButton'){
                Parent = Page,
                Size = UDim2.new(1,-20,0,40),
                Text = cfg.Name .. ' : ' .. tostring(state),
                BackgroundColor3 = Theme.Element,
                TextColor3 = Theme.Text
            }
            Btn.MouseButton1Click:Connect(function()
                state = not state
                Btn.Text = cfg.Name .. ' : ' .. tostring(state)
                if cfg.Callback then cfg.Callback(state) end
            end)
        end

        Tab.Page = Page
        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then Page.Visible = true end
        return Tab
    end

    return Window
end

-- COLUMN INTERNAL BLOCK 1
local _column_internal_1 = true

-- COLUMN INTERNAL BLOCK 2
local _column_internal_2 = true

-- COLUMN INTERNAL BLOCK 3
local _column_internal_3 = true

-- COLUMN INTERNAL BLOCK 4
local _column_internal_4 = true

-- COLUMN INTERNAL BLOCK 5
local _column_internal_5 = true

-- COLUMN INTERNAL BLOCK 6
local _column_internal_6 = true

-- COLUMN INTERNAL BLOCK 7
local _column_internal_7 = true

-- COLUMN INTERNAL BLOCK 8
local _column_internal_8 = true

-- COLUMN INTERNAL BLOCK 9
local _column_internal_9 = true

-- COLUMN INTERNAL BLOCK 10
local _column_internal_10 = true

-- COLUMN INTERNAL BLOCK 11
local _column_internal_11 = true

-- COLUMN INTERNAL BLOCK 12
local _column_internal_12 = true

-- COLUMN INTERNAL BLOCK 13
local _column_internal_13 = true

-- COLUMN INTERNAL BLOCK 14
local _column_internal_14 = true

-- COLUMN INTERNAL BLOCK 15
local _column_internal_15 = true

-- COLUMN INTERNAL BLOCK 16
local _column_internal_16 = true

-- COLUMN INTERNAL BLOCK 17
local _column_internal_17 = true

-- COLUMN INTERNAL BLOCK 18
local _column_internal_18 = true

-- COLUMN INTERNAL BLOCK 19
local _column_internal_19 = true

-- COLUMN INTERNAL BLOCK 20
local _column_internal_20 = true

-- COLUMN INTERNAL BLOCK 21
local _column_internal_21 = true

-- COLUMN INTERNAL BLOCK 22
local _column_internal_22 = true

-- COLUMN INTERNAL BLOCK 23
local _column_internal_23 = true

-- COLUMN INTERNAL BLOCK 24
local _column_internal_24 = true

-- COLUMN INTERNAL BLOCK 25
local _column_internal_25 = true

-- COLUMN INTERNAL BLOCK 26
local _column_internal_26 = true

-- COLUMN INTERNAL BLOCK 27
local _column_internal_27 = true

-- COLUMN INTERNAL BLOCK 28
local _column_internal_28 = true

-- COLUMN INTERNAL BLOCK 29
local _column_internal_29 = true

-- COLUMN INTERNAL BLOCK 30
local _column_internal_30 = true

-- COLUMN INTERNAL BLOCK 31
local _column_internal_31 = true

-- COLUMN INTERNAL BLOCK 32
local _column_internal_32 = true

-- COLUMN INTERNAL BLOCK 33
local _column_internal_33 = true

-- COLUMN INTERNAL BLOCK 34
local _column_internal_34 = true

-- COLUMN INTERNAL BLOCK 35
local _column_internal_35 = true

-- COLUMN INTERNAL BLOCK 36
local _column_internal_36 = true

-- COLUMN INTERNAL BLOCK 37
local _column_internal_37 = true

-- COLUMN INTERNAL BLOCK 38
local _column_internal_38 = true

-- COLUMN INTERNAL BLOCK 39
local _column_internal_39 = true

-- COLUMN INTERNAL BLOCK 40
local _column_internal_40 = true

-- COLUMN INTERNAL BLOCK 41
local _column_internal_41 = true

-- COLUMN INTERNAL BLOCK 42
local _column_internal_42 = true

-- COLUMN INTERNAL BLOCK 43
local _column_internal_43 = true

-- COLUMN INTERNAL BLOCK 44
local _column_internal_44 = true

-- COLUMN INTERNAL BLOCK 45
local _column_internal_45 = true

-- COLUMN INTERNAL BLOCK 46
local _column_internal_46 = true

-- COLUMN INTERNAL BLOCK 47
local _column_internal_47 = true

-- COLUMN INTERNAL BLOCK 48
local _column_internal_48 = true

-- COLUMN INTERNAL BLOCK 49
local _column_internal_49 = true

-- COLUMN INTERNAL BLOCK 50
local _column_internal_50 = true

-- COLUMN INTERNAL BLOCK 51
local _column_internal_51 = true

-- COLUMN INTERNAL BLOCK 52
local _column_internal_52 = true

-- COLUMN INTERNAL BLOCK 53
local _column_internal_53 = true

-- COLUMN INTERNAL BLOCK 54
local _column_internal_54 = true

-- COLUMN INTERNAL BLOCK 55
local _column_internal_55 = true

-- COLUMN INTERNAL BLOCK 56
local _column_internal_56 = true

-- COLUMN INTERNAL BLOCK 57
local _column_internal_57 = true

-- COLUMN INTERNAL BLOCK 58
local _column_internal_58 = true

-- COLUMN INTERNAL BLOCK 59
local _column_internal_59 = true

-- COLUMN INTERNAL BLOCK 60
local _column_internal_60 = true

-- COLUMN INTERNAL BLOCK 61
local _column_internal_61 = true

-- COLUMN INTERNAL BLOCK 62
local _column_internal_62 = true

-- COLUMN INTERNAL BLOCK 63
local _column_internal_63 = true

-- COLUMN INTERNAL BLOCK 64
local _column_internal_64 = true

-- COLUMN INTERNAL BLOCK 65
local _column_internal_65 = true

-- COLUMN INTERNAL BLOCK 66
local _column_internal_66 = true

-- COLUMN INTERNAL BLOCK 67
local _column_internal_67 = true

-- COLUMN INTERNAL BLOCK 68
local _column_internal_68 = true

-- COLUMN INTERNAL BLOCK 69
local _column_internal_69 = true

-- COLUMN INTERNAL BLOCK 70
local _column_internal_70 = true

-- COLUMN INTERNAL BLOCK 71
local _column_internal_71 = true

-- COLUMN INTERNAL BLOCK 72
local _column_internal_72 = true

-- COLUMN INTERNAL BLOCK 73
local _column_internal_73 = true

-- COLUMN INTERNAL BLOCK 74
local _column_internal_74 = true

-- COLUMN INTERNAL BLOCK 75
local _column_internal_75 = true

-- COLUMN INTERNAL BLOCK 76
local _column_internal_76 = true

-- COLUMN INTERNAL BLOCK 77
local _column_internal_77 = true

-- COLUMN INTERNAL BLOCK 78
local _column_internal_78 = true

-- COLUMN INTERNAL BLOCK 79
local _column_internal_79 = true

-- COLUMN INTERNAL BLOCK 80
local _column_internal_80 = true

-- COLUMN INTERNAL BLOCK 81
local _column_internal_81 = true

-- COLUMN INTERNAL BLOCK 82
local _column_internal_82 = true

-- COLUMN INTERNAL BLOCK 83
local _column_internal_83 = true

-- COLUMN INTERNAL BLOCK 84
local _column_internal_84 = true

-- COLUMN INTERNAL BLOCK 85
local _column_internal_85 = true

-- COLUMN INTERNAL BLOCK 86
local _column_internal_86 = true

-- COLUMN INTERNAL BLOCK 87
local _column_internal_87 = true

-- COLUMN INTERNAL BLOCK 88
local _column_internal_88 = true

-- COLUMN INTERNAL BLOCK 89
local _column_internal_89 = true

-- COLUMN INTERNAL BLOCK 90
local _column_internal_90 = true

-- COLUMN INTERNAL BLOCK 91
local _column_internal_91 = true

-- COLUMN INTERNAL BLOCK 92
local _column_internal_92 = true

-- COLUMN INTERNAL BLOCK 93
local _column_internal_93 = true

-- COLUMN INTERNAL BLOCK 94
local _column_internal_94 = true

-- COLUMN INTERNAL BLOCK 95
local _column_internal_95 = true

-- COLUMN INTERNAL BLOCK 96
local _column_internal_96 = true

-- COLUMN INTERNAL BLOCK 97
local _column_internal_97 = true

-- COLUMN INTERNAL BLOCK 98
local _column_internal_98 = true

-- COLUMN INTERNAL BLOCK 99
local _column_internal_99 = true

-- COLUMN INTERNAL BLOCK 100
local _column_internal_100 = true

-- COLUMN INTERNAL BLOCK 101
local _column_internal_101 = true

-- COLUMN INTERNAL BLOCK 102
local _column_internal_102 = true

-- COLUMN INTERNAL BLOCK 103
local _column_internal_103 = true

-- COLUMN INTERNAL BLOCK 104
local _column_internal_104 = true

-- COLUMN INTERNAL BLOCK 105
local _column_internal_105 = true

-- COLUMN INTERNAL BLOCK 106
local _column_internal_106 = true

-- COLUMN INTERNAL BLOCK 107
local _column_internal_107 = true

-- COLUMN INTERNAL BLOCK 108
local _column_internal_108 = true

-- COLUMN INTERNAL BLOCK 109
local _column_internal_109 = true

-- COLUMN INTERNAL BLOCK 110
local _column_internal_110 = true

-- COLUMN INTERNAL BLOCK 111
local _column_internal_111 = true

-- COLUMN INTERNAL BLOCK 112
local _column_internal_112 = true

-- COLUMN INTERNAL BLOCK 113
local _column_internal_113 = true

-- COLUMN INTERNAL BLOCK 114
local _column_internal_114 = true

-- COLUMN INTERNAL BLOCK 115
local _column_internal_115 = true

-- COLUMN INTERNAL BLOCK 116
local _column_internal_116 = true

-- COLUMN INTERNAL BLOCK 117
local _column_internal_117 = true

-- COLUMN INTERNAL BLOCK 118
local _column_internal_118 = true

-- COLUMN INTERNAL BLOCK 119
local _column_internal_119 = true

-- COLUMN INTERNAL BLOCK 120
local _column_internal_120 = true

-- COLUMN INTERNAL BLOCK 121
local _column_internal_121 = true

-- COLUMN INTERNAL BLOCK 122
local _column_internal_122 = true

-- COLUMN INTERNAL BLOCK 123
local _column_internal_123 = true

-- COLUMN INTERNAL BLOCK 124
local _column_internal_124 = true

-- COLUMN INTERNAL BLOCK 125
local _column_internal_125 = true

-- COLUMN INTERNAL BLOCK 126
local _column_internal_126 = true

-- COLUMN INTERNAL BLOCK 127
local _column_internal_127 = true

-- COLUMN INTERNAL BLOCK 128
local _column_internal_128 = true

-- COLUMN INTERNAL BLOCK 129
local _column_internal_129 = true

-- COLUMN INTERNAL BLOCK 130
local _column_internal_130 = true

-- COLUMN INTERNAL BLOCK 131
local _column_internal_131 = true

-- COLUMN INTERNAL BLOCK 132
local _column_internal_132 = true

-- COLUMN INTERNAL BLOCK 133
local _column_internal_133 = true

-- COLUMN INTERNAL BLOCK 134
local _column_internal_134 = true

-- COLUMN INTERNAL BLOCK 135
local _column_internal_135 = true

-- COLUMN INTERNAL BLOCK 136
local _column_internal_136 = true

-- COLUMN INTERNAL BLOCK 137
local _column_internal_137 = true

-- COLUMN INTERNAL BLOCK 138
local _column_internal_138 = true

-- COLUMN INTERNAL BLOCK 139
local _column_internal_139 = true

-- COLUMN INTERNAL BLOCK 140
local _column_internal_140 = true

-- COLUMN INTERNAL BLOCK 141
local _column_internal_141 = true

-- COLUMN INTERNAL BLOCK 142
local _column_internal_142 = true

-- COLUMN INTERNAL BLOCK 143
local _column_internal_143 = true

-- COLUMN INTERNAL BLOCK 144
local _column_internal_144 = true

-- COLUMN INTERNAL BLOCK 145
local _column_internal_145 = true

-- COLUMN INTERNAL BLOCK 146
local _column_internal_146 = true

-- COLUMN INTERNAL BLOCK 147
local _column_internal_147 = true

-- COLUMN INTERNAL BLOCK 148
local _column_internal_148 = true

-- COLUMN INTERNAL BLOCK 149
local _column_internal_149 = true

-- COLUMN INTERNAL BLOCK 150
local _column_internal_150 = true

-- COLUMN INTERNAL BLOCK 151
local _column_internal_151 = true

-- COLUMN INTERNAL BLOCK 152
local _column_internal_152 = true

-- COLUMN INTERNAL BLOCK 153
local _column_internal_153 = true

-- COLUMN INTERNAL BLOCK 154
local _column_internal_154 = true

-- COLUMN INTERNAL BLOCK 155
local _column_internal_155 = true

-- COLUMN INTERNAL BLOCK 156
local _column_internal_156 = true

-- COLUMN INTERNAL BLOCK 157
local _column_internal_157 = true

-- COLUMN INTERNAL BLOCK 158
local _column_internal_158 = true

-- COLUMN INTERNAL BLOCK 159
local _column_internal_159 = true

-- COLUMN INTERNAL BLOCK 160
local _column_internal_160 = true

-- COLUMN INTERNAL BLOCK 161
local _column_internal_161 = true

-- COLUMN INTERNAL BLOCK 162
local _column_internal_162 = true

-- COLUMN INTERNAL BLOCK 163
local _column_internal_163 = true

-- COLUMN INTERNAL BLOCK 164
local _column_internal_164 = true

-- COLUMN INTERNAL BLOCK 165
local _column_internal_165 = true

-- COLUMN INTERNAL BLOCK 166
local _column_internal_166 = true

-- COLUMN INTERNAL BLOCK 167
local _column_internal_167 = true

-- COLUMN INTERNAL BLOCK 168
local _column_internal_168 = true

-- COLUMN INTERNAL BLOCK 169
local _column_internal_169 = true

-- COLUMN INTERNAL BLOCK 170
local _column_internal_170 = true

-- COLUMN INTERNAL BLOCK 171
local _column_internal_171 = true

-- COLUMN INTERNAL BLOCK 172
local _column_internal_172 = true

-- COLUMN INTERNAL BLOCK 173
local _column_internal_173 = true

-- COLUMN INTERNAL BLOCK 174
local _column_internal_174 = true

-- COLUMN INTERNAL BLOCK 175
local _column_internal_175 = true

-- COLUMN INTERNAL BLOCK 176
local _column_internal_176 = true

-- COLUMN INTERNAL BLOCK 177
local _column_internal_177 = true

-- COLUMN INTERNAL BLOCK 178
local _column_internal_178 = true

-- COLUMN INTERNAL BLOCK 179
local _column_internal_179 = true

-- COLUMN INTERNAL BLOCK 180
local _column_internal_180 = true

-- COLUMN INTERNAL BLOCK 181
local _column_internal_181 = true

-- COLUMN INTERNAL BLOCK 182
local _column_internal_182 = true

-- COLUMN INTERNAL BLOCK 183
local _column_internal_183 = true

-- COLUMN INTERNAL BLOCK 184
local _column_internal_184 = true

-- COLUMN INTERNAL BLOCK 185
local _column_internal_185 = true

-- COLUMN INTERNAL BLOCK 186
local _column_internal_186 = true

-- COLUMN INTERNAL BLOCK 187
local _column_internal_187 = true

-- COLUMN INTERNAL BLOCK 188
local _column_internal_188 = true

-- COLUMN INTERNAL BLOCK 189
local _column_internal_189 = true

-- COLUMN INTERNAL BLOCK 190
local _column_internal_190 = true

-- COLUMN INTERNAL BLOCK 191
local _column_internal_191 = true

-- COLUMN INTERNAL BLOCK 192
local _column_internal_192 = true

-- COLUMN INTERNAL BLOCK 193
local _column_internal_193 = true

-- COLUMN INTERNAL BLOCK 194
local _column_internal_194 = true

-- COLUMN INTERNAL BLOCK 195
local _column_internal_195 = true

-- COLUMN INTERNAL BLOCK 196
local _column_internal_196 = true

-- COLUMN INTERNAL BLOCK 197
local _column_internal_197 = true

-- COLUMN INTERNAL BLOCK 198
local _column_internal_198 = true

-- COLUMN INTERNAL BLOCK 199
local _column_internal_199 = true

-- COLUMN INTERNAL BLOCK 200
local _column_internal_200 = true

-- COLUMN INTERNAL BLOCK 201
local _column_internal_201 = true

-- COLUMN INTERNAL BLOCK 202
local _column_internal_202 = true

-- COLUMN INTERNAL BLOCK 203
local _column_internal_203 = true

-- COLUMN INTERNAL BLOCK 204
local _column_internal_204 = true

-- COLUMN INTERNAL BLOCK 205
local _column_internal_205 = true

-- COLUMN INTERNAL BLOCK 206
local _column_internal_206 = true

-- COLUMN INTERNAL BLOCK 207
local _column_internal_207 = true

-- COLUMN INTERNAL BLOCK 208
local _column_internal_208 = true

-- COLUMN INTERNAL BLOCK 209
local _column_internal_209 = true

-- COLUMN INTERNAL BLOCK 210
local _column_internal_210 = true

-- COLUMN INTERNAL BLOCK 211
local _column_internal_211 = true

-- COLUMN INTERNAL BLOCK 212
local _column_internal_212 = true

-- COLUMN INTERNAL BLOCK 213
local _column_internal_213 = true

-- COLUMN INTERNAL BLOCK 214
local _column_internal_214 = true

-- COLUMN INTERNAL BLOCK 215
local _column_internal_215 = true

-- COLUMN INTERNAL BLOCK 216
local _column_internal_216 = true

-- COLUMN INTERNAL BLOCK 217
local _column_internal_217 = true

-- COLUMN INTERNAL BLOCK 218
local _column_internal_218 = true

-- COLUMN INTERNAL BLOCK 219
local _column_internal_219 = true

-- COLUMN INTERNAL BLOCK 220
local _column_internal_220 = true

-- COLUMN INTERNAL BLOCK 221
local _column_internal_221 = true

-- COLUMN INTERNAL BLOCK 222
local _column_internal_222 = true

-- COLUMN INTERNAL BLOCK 223
local _column_internal_223 = true

-- COLUMN INTERNAL BLOCK 224
local _column_internal_224 = true

-- COLUMN INTERNAL BLOCK 225
local _column_internal_225 = true

-- COLUMN INTERNAL BLOCK 226
local _column_internal_226 = true

-- COLUMN INTERNAL BLOCK 227
local _column_internal_227 = true

-- COLUMN INTERNAL BLOCK 228
local _column_internal_228 = true

-- COLUMN INTERNAL BLOCK 229
local _column_internal_229 = true

-- COLUMN INTERNAL BLOCK 230
local _column_internal_230 = true

-- COLUMN INTERNAL BLOCK 231
local _column_internal_231 = true

-- COLUMN INTERNAL BLOCK 232
local _column_internal_232 = true

-- COLUMN INTERNAL BLOCK 233
local _column_internal_233 = true

-- COLUMN INTERNAL BLOCK 234
local _column_internal_234 = true

-- COLUMN INTERNAL BLOCK 235
local _column_internal_235 = true

-- COLUMN INTERNAL BLOCK 236
local _column_internal_236 = true

-- COLUMN INTERNAL BLOCK 237
local _column_internal_237 = true

-- COLUMN INTERNAL BLOCK 238
local _column_internal_238 = true

-- COLUMN INTERNAL BLOCK 239
local _column_internal_239 = true

-- COLUMN INTERNAL BLOCK 240
local _column_internal_240 = true

-- COLUMN INTERNAL BLOCK 241
local _column_internal_241 = true

-- COLUMN INTERNAL BLOCK 242
local _column_internal_242 = true

-- COLUMN INTERNAL BLOCK 243
local _column_internal_243 = true

-- COLUMN INTERNAL BLOCK 244
local _column_internal_244 = true

-- COLUMN INTERNAL BLOCK 245
local _column_internal_245 = true

-- COLUMN INTERNAL BLOCK 246
local _column_internal_246 = true

-- COLUMN INTERNAL BLOCK 247
local _column_internal_247 = true

-- COLUMN INTERNAL BLOCK 248
local _column_internal_248 = true

-- COLUMN INTERNAL BLOCK 249
local _column_internal_249 = true

-- COLUMN INTERNAL BLOCK 250
local _column_internal_250 = true

-- COLUMN INTERNAL BLOCK 251
local _column_internal_251 = true

-- COLUMN INTERNAL BLOCK 252
local _column_internal_252 = true

-- COLUMN INTERNAL BLOCK 253
local _column_internal_253 = true

-- COLUMN INTERNAL BLOCK 254
local _column_internal_254 = true

-- COLUMN INTERNAL BLOCK 255
local _column_internal_255 = true

-- COLUMN INTERNAL BLOCK 256
local _column_internal_256 = true

-- COLUMN INTERNAL BLOCK 257
local _column_internal_257 = true

-- COLUMN INTERNAL BLOCK 258
local _column_internal_258 = true

-- COLUMN INTERNAL BLOCK 259
local _column_internal_259 = true

-- COLUMN INTERNAL BLOCK 260
local _column_internal_260 = true

-- COLUMN INTERNAL BLOCK 261
local _column_internal_261 = true

-- COLUMN INTERNAL BLOCK 262
local _column_internal_262 = true

-- COLUMN INTERNAL BLOCK 263
local _column_internal_263 = true

-- COLUMN INTERNAL BLOCK 264
local _column_internal_264 = true

-- COLUMN INTERNAL BLOCK 265
local _column_internal_265 = true

-- COLUMN INTERNAL BLOCK 266
local _column_internal_266 = true

-- COLUMN INTERNAL BLOCK 267
local _column_internal_267 = true

-- COLUMN INTERNAL BLOCK 268
local _column_internal_268 = true

-- COLUMN INTERNAL BLOCK 269
local _column_internal_269 = true

-- COLUMN INTERNAL BLOCK 270
local _column_internal_270 = true

-- COLUMN INTERNAL BLOCK 271
local _column_internal_271 = true

-- COLUMN INTERNAL BLOCK 272
local _column_internal_272 = true

-- COLUMN INTERNAL BLOCK 273
local _column_internal_273 = true

-- COLUMN INTERNAL BLOCK 274
local _column_internal_274 = true

-- COLUMN INTERNAL BLOCK 275
local _column_internal_275 = true

-- COLUMN INTERNAL BLOCK 276
local _column_internal_276 = true

-- COLUMN INTERNAL BLOCK 277
local _column_internal_277 = true

-- COLUMN INTERNAL BLOCK 278
local _column_internal_278 = true

-- COLUMN INTERNAL BLOCK 279
local _column_internal_279 = true

-- COLUMN INTERNAL BLOCK 280
local _column_internal_280 = true

-- COLUMN INTERNAL BLOCK 281
local _column_internal_281 = true

-- COLUMN INTERNAL BLOCK 282
local _column_internal_282 = true

-- COLUMN INTERNAL BLOCK 283
local _column_internal_283 = true

-- COLUMN INTERNAL BLOCK 284
local _column_internal_284 = true

-- COLUMN INTERNAL BLOCK 285
local _column_internal_285 = true

-- COLUMN INTERNAL BLOCK 286
local _column_internal_286 = true

-- COLUMN INTERNAL BLOCK 287
local _column_internal_287 = true

-- COLUMN INTERNAL BLOCK 288
local _column_internal_288 = true

-- COLUMN INTERNAL BLOCK 289
local _column_internal_289 = true

-- COLUMN INTERNAL BLOCK 290
local _column_internal_290 = true

-- COLUMN INTERNAL BLOCK 291
local _column_internal_291 = true

-- COLUMN INTERNAL BLOCK 292
local _column_internal_292 = true

-- COLUMN INTERNAL BLOCK 293
local _column_internal_293 = true

-- COLUMN INTERNAL BLOCK 294
local _column_internal_294 = true

-- COLUMN INTERNAL BLOCK 295
local _column_internal_295 = true

-- COLUMN INTERNAL BLOCK 296
local _column_internal_296 = true

-- COLUMN INTERNAL BLOCK 297
local _column_internal_297 = true

-- COLUMN INTERNAL BLOCK 298
local _column_internal_298 = true

-- COLUMN INTERNAL BLOCK 299
local _column_internal_299 = true

-- COLUMN INTERNAL BLOCK 300
local _column_internal_300 = true

-- COLUMN INTERNAL BLOCK 301
local _column_internal_301 = true

-- COLUMN INTERNAL BLOCK 302
local _column_internal_302 = true

-- COLUMN INTERNAL BLOCK 303
local _column_internal_303 = true

-- COLUMN INTERNAL BLOCK 304
local _column_internal_304 = true

-- COLUMN INTERNAL BLOCK 305
local _column_internal_305 = true

-- COLUMN INTERNAL BLOCK 306
local _column_internal_306 = true

-- COLUMN INTERNAL BLOCK 307
local _column_internal_307 = true

-- COLUMN INTERNAL BLOCK 308
local _column_internal_308 = true

-- COLUMN INTERNAL BLOCK 309
local _column_internal_309 = true

-- COLUMN INTERNAL BLOCK 310
local _column_internal_310 = true

-- COLUMN INTERNAL BLOCK 311
local _column_internal_311 = true

-- COLUMN INTERNAL BLOCK 312
local _column_internal_312 = true

-- COLUMN INTERNAL BLOCK 313
local _column_internal_313 = true

-- COLUMN INTERNAL BLOCK 314
local _column_internal_314 = true

-- COLUMN INTERNAL BLOCK 315
local _column_internal_315 = true

-- COLUMN INTERNAL BLOCK 316
local _column_internal_316 = true

-- COLUMN INTERNAL BLOCK 317
local _column_internal_317 = true

-- COLUMN INTERNAL BLOCK 318
local _column_internal_318 = true

-- COLUMN INTERNAL BLOCK 319
local _column_internal_319 = true

-- COLUMN INTERNAL BLOCK 320
local _column_internal_320 = true

-- COLUMN INTERNAL BLOCK 321
local _column_internal_321 = true

-- COLUMN INTERNAL BLOCK 322
local _column_internal_322 = true

-- COLUMN INTERNAL BLOCK 323
local _column_internal_323 = true

-- COLUMN INTERNAL BLOCK 324
local _column_internal_324 = true

-- COLUMN INTERNAL BLOCK 325
local _column_internal_325 = true

-- COLUMN INTERNAL BLOCK 326
local _column_internal_326 = true

-- COLUMN INTERNAL BLOCK 327
local _column_internal_327 = true

-- COLUMN INTERNAL BLOCK 328
local _column_internal_328 = true

-- COLUMN INTERNAL BLOCK 329
local _column_internal_329 = true

-- COLUMN INTERNAL BLOCK 330
local _column_internal_330 = true

-- COLUMN INTERNAL BLOCK 331
local _column_internal_331 = true

-- COLUMN INTERNAL BLOCK 332
local _column_internal_332 = true

-- COLUMN INTERNAL BLOCK 333
local _column_internal_333 = true

-- COLUMN INTERNAL BLOCK 334
local _column_internal_334 = true

-- COLUMN INTERNAL BLOCK 335
local _column_internal_335 = true

-- COLUMN INTERNAL BLOCK 336
local _column_internal_336 = true

-- COLUMN INTERNAL BLOCK 337
local _column_internal_337 = true

-- COLUMN INTERNAL BLOCK 338
local _column_internal_338 = true

-- COLUMN INTERNAL BLOCK 339
local _column_internal_339 = true

-- COLUMN INTERNAL BLOCK 340
local _column_internal_340 = true

-- COLUMN INTERNAL BLOCK 341
local _column_internal_341 = true

-- COLUMN INTERNAL BLOCK 342
local _column_internal_342 = true

-- COLUMN INTERNAL BLOCK 343
local _column_internal_343 = true

-- COLUMN INTERNAL BLOCK 344
local _column_internal_344 = true

-- COLUMN INTERNAL BLOCK 345
local _column_internal_345 = true

-- COLUMN INTERNAL BLOCK 346
local _column_internal_346 = true

-- COLUMN INTERNAL BLOCK 347
local _column_internal_347 = true

-- COLUMN INTERNAL BLOCK 348
local _column_internal_348 = true

-- COLUMN INTERNAL BLOCK 349
local _column_internal_349 = true

-- COLUMN INTERNAL BLOCK 350
local _column_internal_350 = true

-- COLUMN INTERNAL BLOCK 351
local _column_internal_351 = true

-- COLUMN INTERNAL BLOCK 352
local _column_internal_352 = true

-- COLUMN INTERNAL BLOCK 353
local _column_internal_353 = true

-- COLUMN INTERNAL BLOCK 354
local _column_internal_354 = true

-- COLUMN INTERNAL BLOCK 355
local _column_internal_355 = true

-- COLUMN INTERNAL BLOCK 356
local _column_internal_356 = true

-- COLUMN INTERNAL BLOCK 357
local _column_internal_357 = true

-- COLUMN INTERNAL BLOCK 358
local _column_internal_358 = true

-- COLUMN INTERNAL BLOCK 359
local _column_internal_359 = true

-- COLUMN INTERNAL BLOCK 360
local _column_internal_360 = true

-- COLUMN INTERNAL BLOCK 361
local _column_internal_361 = true

-- COLUMN INTERNAL BLOCK 362
local _column_internal_362 = true

-- COLUMN INTERNAL BLOCK 363
local _column_internal_363 = true

-- COLUMN INTERNAL BLOCK 364
local _column_internal_364 = true

-- COLUMN INTERNAL BLOCK 365
local _column_internal_365 = true

-- COLUMN INTERNAL BLOCK 366
local _column_internal_366 = true

-- COLUMN INTERNAL BLOCK 367
local _column_internal_367 = true

-- COLUMN INTERNAL BLOCK 368
local _column_internal_368 = true

-- COLUMN INTERNAL BLOCK 369
local _column_internal_369 = true

-- COLUMN INTERNAL BLOCK 370
local _column_internal_370 = true

-- COLUMN INTERNAL BLOCK 371
local _column_internal_371 = true

-- COLUMN INTERNAL BLOCK 372
local _column_internal_372 = true

-- COLUMN INTERNAL BLOCK 373
local _column_internal_373 = true

-- COLUMN INTERNAL BLOCK 374
local _column_internal_374 = true

-- COLUMN INTERNAL BLOCK 375
local _column_internal_375 = true

-- COLUMN INTERNAL BLOCK 376
local _column_internal_376 = true

-- COLUMN INTERNAL BLOCK 377
local _column_internal_377 = true

-- COLUMN INTERNAL BLOCK 378
local _column_internal_378 = true

-- COLUMN INTERNAL BLOCK 379
local _column_internal_379 = true

-- COLUMN INTERNAL BLOCK 380
local _column_internal_380 = true

-- COLUMN INTERNAL BLOCK 381
local _column_internal_381 = true

-- COLUMN INTERNAL BLOCK 382
local _column_internal_382 = true

-- COLUMN INTERNAL BLOCK 383
local _column_internal_383 = true

-- COLUMN INTERNAL BLOCK 384
local _column_internal_384 = true

-- COLUMN INTERNAL BLOCK 385
local _column_internal_385 = true

-- COLUMN INTERNAL BLOCK 386
local _column_internal_386 = true

-- COLUMN INTERNAL BLOCK 387
local _column_internal_387 = true

-- COLUMN INTERNAL BLOCK 388
local _column_internal_388 = true

-- COLUMN INTERNAL BLOCK 389
local _column_internal_389 = true

-- COLUMN INTERNAL BLOCK 390
local _column_internal_390 = true

-- COLUMN INTERNAL BLOCK 391
local _column_internal_391 = true

-- COLUMN INTERNAL BLOCK 392
local _column_internal_392 = true

-- COLUMN INTERNAL BLOCK 393
local _column_internal_393 = true

-- COLUMN INTERNAL BLOCK 394
local _column_internal_394 = true

-- COLUMN INTERNAL BLOCK 395
local _column_internal_395 = true

-- COLUMN INTERNAL BLOCK 396
local _column_internal_396 = true

-- COLUMN INTERNAL BLOCK 397
local _column_internal_397 = true

-- COLUMN INTERNAL BLOCK 398
local _column_internal_398 = true

-- COLUMN INTERNAL BLOCK 399
local _column_internal_399 = true

-- COLUMN INTERNAL BLOCK 400
local _column_internal_400 = true

-- COLUMN INTERNAL BLOCK 401
local _column_internal_401 = true

-- COLUMN INTERNAL BLOCK 402
local _column_internal_402 = true

-- COLUMN INTERNAL BLOCK 403
local _column_internal_403 = true

-- COLUMN INTERNAL BLOCK 404
local _column_internal_404 = true

-- COLUMN INTERNAL BLOCK 405
local _column_internal_405 = true

-- COLUMN INTERNAL BLOCK 406
local _column_internal_406 = true

-- COLUMN INTERNAL BLOCK 407
local _column_internal_407 = true

-- COLUMN INTERNAL BLOCK 408
local _column_internal_408 = true

-- COLUMN INTERNAL BLOCK 409
local _column_internal_409 = true

-- COLUMN INTERNAL BLOCK 410
local _column_internal_410 = true

-- COLUMN INTERNAL BLOCK 411
local _column_internal_411 = true

-- COLUMN INTERNAL BLOCK 412
local _column_internal_412 = true

-- COLUMN INTERNAL BLOCK 413
local _column_internal_413 = true

-- COLUMN INTERNAL BLOCK 414
local _column_internal_414 = true

-- COLUMN INTERNAL BLOCK 415
local _column_internal_415 = true

-- COLUMN INTERNAL BLOCK 416
local _column_internal_416 = true

-- COLUMN INTERNAL BLOCK 417
local _column_internal_417 = true

-- COLUMN INTERNAL BLOCK 418
local _column_internal_418 = true

-- COLUMN INTERNAL BLOCK 419
local _column_internal_419 = true

-- COLUMN INTERNAL BLOCK 420
local _column_internal_420 = true

-- COLUMN INTERNAL BLOCK 421
local _column_internal_421 = true

-- COLUMN INTERNAL BLOCK 422
local _column_internal_422 = true

-- COLUMN INTERNAL BLOCK 423
local _column_internal_423 = true

-- COLUMN INTERNAL BLOCK 424
local _column_internal_424 = true

-- COLUMN INTERNAL BLOCK 425
local _column_internal_425 = true

-- COLUMN INTERNAL BLOCK 426
local _column_internal_426 = true

-- COLUMN INTERNAL BLOCK 427
local _column_internal_427 = true

-- COLUMN INTERNAL BLOCK 428
local _column_internal_428 = true

-- COLUMN INTERNAL BLOCK 429
local _column_internal_429 = true

-- COLUMN INTERNAL BLOCK 430
local _column_internal_430 = true

-- COLUMN INTERNAL BLOCK 431
local _column_internal_431 = true

-- COLUMN INTERNAL BLOCK 432
local _column_internal_432 = true

-- COLUMN INTERNAL BLOCK 433
local _column_internal_433 = true

-- COLUMN INTERNAL BLOCK 434
local _column_internal_434 = true

-- COLUMN INTERNAL BLOCK 435
local _column_internal_435 = true

-- COLUMN INTERNAL BLOCK 436
local _column_internal_436 = true

-- COLUMN INTERNAL BLOCK 437
local _column_internal_437 = true

-- COLUMN INTERNAL BLOCK 438
local _column_internal_438 = true

-- COLUMN INTERNAL BLOCK 439
local _column_internal_439 = true

-- COLUMN INTERNAL BLOCK 440
local _column_internal_440 = true

-- COLUMN INTERNAL BLOCK 441
local _column_internal_441 = true

-- COLUMN INTERNAL BLOCK 442
local _column_internal_442 = true

-- COLUMN INTERNAL BLOCK 443
local _column_internal_443 = true

-- COLUMN INTERNAL BLOCK 444
local _column_internal_444 = true

-- COLUMN INTERNAL BLOCK 445
local _column_internal_445 = true

-- COLUMN INTERNAL BLOCK 446
local _column_internal_446 = true

-- COLUMN INTERNAL BLOCK 447
local _column_internal_447 = true

-- COLUMN INTERNAL BLOCK 448
local _column_internal_448 = true

-- COLUMN INTERNAL BLOCK 449
local _column_internal_449 = true

-- COLUMN INTERNAL BLOCK 450
local _column_internal_450 = true

-- COLUMN INTERNAL BLOCK 451
local _column_internal_451 = true

-- COLUMN INTERNAL BLOCK 452
local _column_internal_452 = true

-- COLUMN INTERNAL BLOCK 453
local _column_internal_453 = true

-- COLUMN INTERNAL BLOCK 454
local _column_internal_454 = true

-- COLUMN INTERNAL BLOCK 455
local _column_internal_455 = true

-- COLUMN INTERNAL BLOCK 456
local _column_internal_456 = true

-- COLUMN INTERNAL BLOCK 457
local _column_internal_457 = true

-- COLUMN INTERNAL BLOCK 458
local _column_internal_458 = true

-- COLUMN INTERNAL BLOCK 459
local _column_internal_459 = true

-- COLUMN INTERNAL BLOCK 460
local _column_internal_460 = true

-- COLUMN INTERNAL BLOCK 461
local _column_internal_461 = true

-- COLUMN INTERNAL BLOCK 462
local _column_internal_462 = true

-- COLUMN INTERNAL BLOCK 463
local _column_internal_463 = true

-- COLUMN INTERNAL BLOCK 464
local _column_internal_464 = true

-- COLUMN INTERNAL BLOCK 465
local _column_internal_465 = true

-- COLUMN INTERNAL BLOCK 466
local _column_internal_466 = true

-- COLUMN INTERNAL BLOCK 467
local _column_internal_467 = true

-- COLUMN INTERNAL BLOCK 468
local _column_internal_468 = true

-- COLUMN INTERNAL BLOCK 469
local _column_internal_469 = true

-- COLUMN INTERNAL BLOCK 470
local _column_internal_470 = true

-- COLUMN INTERNAL BLOCK 471
local _column_internal_471 = true

-- COLUMN INTERNAL BLOCK 472
local _column_internal_472 = true

-- COLUMN INTERNAL BLOCK 473
local _column_internal_473 = true

-- COLUMN INTERNAL BLOCK 474
local _column_internal_474 = true

-- COLUMN INTERNAL BLOCK 475
local _column_internal_475 = true

-- COLUMN INTERNAL BLOCK 476
local _column_internal_476 = true

-- COLUMN INTERNAL BLOCK 477
local _column_internal_477 = true

-- COLUMN INTERNAL BLOCK 478
local _column_internal_478 = true

-- COLUMN INTERNAL BLOCK 479
local _column_internal_479 = true

-- COLUMN INTERNAL BLOCK 480
local _column_internal_480 = true

-- COLUMN INTERNAL BLOCK 481
local _column_internal_481 = true

-- COLUMN INTERNAL BLOCK 482
local _column_internal_482 = true

-- COLUMN INTERNAL BLOCK 483
local _column_internal_483 = true

-- COLUMN INTERNAL BLOCK 484
local _column_internal_484 = true

-- COLUMN INTERNAL BLOCK 485
local _column_internal_485 = true

-- COLUMN INTERNAL BLOCK 486
local _column_internal_486 = true

-- COLUMN INTERNAL BLOCK 487
local _column_internal_487 = true

-- COLUMN INTERNAL BLOCK 488
local _column_internal_488 = true

-- COLUMN INTERNAL BLOCK 489
local _column_internal_489 = true

-- COLUMN INTERNAL BLOCK 490
local _column_internal_490 = true

-- COLUMN INTERNAL BLOCK 491
local _column_internal_491 = true

-- COLUMN INTERNAL BLOCK 492
local _column_internal_492 = true

-- COLUMN INTERNAL BLOCK 493
local _column_internal_493 = true

-- COLUMN INTERNAL BLOCK 494
local _column_internal_494 = true

-- COLUMN INTERNAL BLOCK 495
local _column_internal_495 = true

-- COLUMN INTERNAL BLOCK 496
local _column_internal_496 = true

-- COLUMN INTERNAL BLOCK 497
local _column_internal_497 = true

-- COLUMN INTERNAL BLOCK 498
local _column_internal_498 = true

-- COLUMN INTERNAL BLOCK 499
local _column_internal_499 = true

-- COLUMN INTERNAL BLOCK 500
local _column_internal_500 = true

-- COLUMN INTERNAL BLOCK 501
local _column_internal_501 = true

-- COLUMN INTERNAL BLOCK 502
local _column_internal_502 = true

-- COLUMN INTERNAL BLOCK 503
local _column_internal_503 = true

-- COLUMN INTERNAL BLOCK 504
local _column_internal_504 = true

-- COLUMN INTERNAL BLOCK 505
local _column_internal_505 = true

-- COLUMN INTERNAL BLOCK 506
local _column_internal_506 = true

-- COLUMN INTERNAL BLOCK 507
local _column_internal_507 = true

-- COLUMN INTERNAL BLOCK 508
local _column_internal_508 = true

-- COLUMN INTERNAL BLOCK 509
local _column_internal_509 = true

-- COLUMN INTERNAL BLOCK 510
local _column_internal_510 = true

-- COLUMN INTERNAL BLOCK 511
local _column_internal_511 = true

-- COLUMN INTERNAL BLOCK 512
local _column_internal_512 = true

-- COLUMN INTERNAL BLOCK 513
local _column_internal_513 = true

-- COLUMN INTERNAL BLOCK 514
local _column_internal_514 = true

-- COLUMN INTERNAL BLOCK 515
local _column_internal_515 = true

-- COLUMN INTERNAL BLOCK 516
local _column_internal_516 = true

-- COLUMN INTERNAL BLOCK 517
local _column_internal_517 = true

-- COLUMN INTERNAL BLOCK 518
local _column_internal_518 = true

-- COLUMN INTERNAL BLOCK 519
local _column_internal_519 = true

-- COLUMN INTERNAL BLOCK 520
local _column_internal_520 = true

-- COLUMN INTERNAL BLOCK 521
local _column_internal_521 = true

-- COLUMN INTERNAL BLOCK 522
local _column_internal_522 = true

-- COLUMN INTERNAL BLOCK 523
local _column_internal_523 = true

-- COLUMN INTERNAL BLOCK 524
local _column_internal_524 = true

-- COLUMN INTERNAL BLOCK 525
local _column_internal_525 = true

-- COLUMN INTERNAL BLOCK 526
local _column_internal_526 = true

-- COLUMN INTERNAL BLOCK 527
local _column_internal_527 = true

-- COLUMN INTERNAL BLOCK 528
local _column_internal_528 = true

-- COLUMN INTERNAL BLOCK 529
local _column_internal_529 = true

-- COLUMN INTERNAL BLOCK 530
local _column_internal_530 = true

-- COLUMN INTERNAL BLOCK 531
local _column_internal_531 = true

-- COLUMN INTERNAL BLOCK 532
local _column_internal_532 = true

-- COLUMN INTERNAL BLOCK 533
local _column_internal_533 = true

-- COLUMN INTERNAL BLOCK 534
local _column_internal_534 = true

-- COLUMN INTERNAL BLOCK 535
local _column_internal_535 = true

-- COLUMN INTERNAL BLOCK 536
local _column_internal_536 = true

-- COLUMN INTERNAL BLOCK 537
local _column_internal_537 = true

-- COLUMN INTERNAL BLOCK 538
local _column_internal_538 = true

-- COLUMN INTERNAL BLOCK 539
local _column_internal_539 = true

-- COLUMN INTERNAL BLOCK 540
local _column_internal_540 = true

-- COLUMN INTERNAL BLOCK 541
local _column_internal_541 = true

-- COLUMN INTERNAL BLOCK 542
local _column_internal_542 = true

-- COLUMN INTERNAL BLOCK 543
local _column_internal_543 = true

-- COLUMN INTERNAL BLOCK 544
local _column_internal_544 = true

-- COLUMN INTERNAL BLOCK 545
local _column_internal_545 = true

-- COLUMN INTERNAL BLOCK 546
local _column_internal_546 = true

-- COLUMN INTERNAL BLOCK 547
local _column_internal_547 = true

-- COLUMN INTERNAL BLOCK 548
local _column_internal_548 = true

-- COLUMN INTERNAL BLOCK 549
local _column_internal_549 = true

-- COLUMN INTERNAL BLOCK 550
local _column_internal_550 = true

-- COLUMN INTERNAL BLOCK 551
local _column_internal_551 = true

-- COLUMN INTERNAL BLOCK 552
local _column_internal_552 = true

-- COLUMN INTERNAL BLOCK 553
local _column_internal_553 = true

-- COLUMN INTERNAL BLOCK 554
local _column_internal_554 = true

-- COLUMN INTERNAL BLOCK 555
local _column_internal_555 = true

-- COLUMN INTERNAL BLOCK 556
local _column_internal_556 = true

-- COLUMN INTERNAL BLOCK 557
local _column_internal_557 = true

-- COLUMN INTERNAL BLOCK 558
local _column_internal_558 = true

-- COLUMN INTERNAL BLOCK 559
local _column_internal_559 = true

-- COLUMN INTERNAL BLOCK 560
local _column_internal_560 = true

-- COLUMN INTERNAL BLOCK 561
local _column_internal_561 = true

-- COLUMN INTERNAL BLOCK 562
local _column_internal_562 = true

-- COLUMN INTERNAL BLOCK 563
local _column_internal_563 = true

-- COLUMN INTERNAL BLOCK 564
local _column_internal_564 = true

-- COLUMN INTERNAL BLOCK 565
local _column_internal_565 = true

-- COLUMN INTERNAL BLOCK 566
local _column_internal_566 = true

-- COLUMN INTERNAL BLOCK 567
local _column_internal_567 = true

-- COLUMN INTERNAL BLOCK 568
local _column_internal_568 = true

-- COLUMN INTERNAL BLOCK 569
local _column_internal_569 = true

-- COLUMN INTERNAL BLOCK 570
local _column_internal_570 = true

-- COLUMN INTERNAL BLOCK 571
local _column_internal_571 = true

-- COLUMN INTERNAL BLOCK 572
local _column_internal_572 = true

-- COLUMN INTERNAL BLOCK 573
local _column_internal_573 = true

-- COLUMN INTERNAL BLOCK 574
local _column_internal_574 = true

-- COLUMN INTERNAL BLOCK 575
local _column_internal_575 = true

-- COLUMN INTERNAL BLOCK 576
local _column_internal_576 = true

-- COLUMN INTERNAL BLOCK 577
local _column_internal_577 = true

-- COLUMN INTERNAL BLOCK 578
local _column_internal_578 = true

-- COLUMN INTERNAL BLOCK 579
local _column_internal_579 = true

-- COLUMN INTERNAL BLOCK 580
local _column_internal_580 = true

-- COLUMN INTERNAL BLOCK 581
local _column_internal_581 = true

-- COLUMN INTERNAL BLOCK 582
local _column_internal_582 = true

-- COLUMN INTERNAL BLOCK 583
local _column_internal_583 = true

-- COLUMN INTERNAL BLOCK 584
local _column_internal_584 = true

-- COLUMN INTERNAL BLOCK 585
local _column_internal_585 = true

-- COLUMN INTERNAL BLOCK 586
local _column_internal_586 = true

-- COLUMN INTERNAL BLOCK 587
local _column_internal_587 = true

-- COLUMN INTERNAL BLOCK 588
local _column_internal_588 = true

-- COLUMN INTERNAL BLOCK 589
local _column_internal_589 = true

-- COLUMN INTERNAL BLOCK 590
local _column_internal_590 = true

-- COLUMN INTERNAL BLOCK 591
local _column_internal_591 = true

-- COLUMN INTERNAL BLOCK 592
local _column_internal_592 = true

-- COLUMN INTERNAL BLOCK 593
local _column_internal_593 = true

-- COLUMN INTERNAL BLOCK 594
local _column_internal_594 = true

-- COLUMN INTERNAL BLOCK 595
local _column_internal_595 = true

-- COLUMN INTERNAL BLOCK 596
local _column_internal_596 = true

-- COLUMN INTERNAL BLOCK 597
local _column_internal_597 = true

-- COLUMN INTERNAL BLOCK 598
local _column_internal_598 = true

-- COLUMN INTERNAL BLOCK 599
local _column_internal_599 = true

-- COLUMN INTERNAL BLOCK 600
local _column_internal_600 = true

-- COLUMN INTERNAL BLOCK 601
local _column_internal_601 = true

-- COLUMN INTERNAL BLOCK 602
local _column_internal_602 = true

-- COLUMN INTERNAL BLOCK 603
local _column_internal_603 = true

-- COLUMN INTERNAL BLOCK 604
local _column_internal_604 = true

-- COLUMN INTERNAL BLOCK 605
local _column_internal_605 = true

-- COLUMN INTERNAL BLOCK 606
local _column_internal_606 = true

-- COLUMN INTERNAL BLOCK 607
local _column_internal_607 = true

-- COLUMN INTERNAL BLOCK 608
local _column_internal_608 = true

-- COLUMN INTERNAL BLOCK 609
local _column_internal_609 = true

-- COLUMN INTERNAL BLOCK 610
local _column_internal_610 = true

-- COLUMN INTERNAL BLOCK 611
local _column_internal_611 = true

-- COLUMN INTERNAL BLOCK 612
local _column_internal_612 = true

-- COLUMN INTERNAL BLOCK 613
local _column_internal_613 = true

-- COLUMN INTERNAL BLOCK 614
local _column_internal_614 = true

-- COLUMN INTERNAL BLOCK 615
local _column_internal_615 = true

-- COLUMN INTERNAL BLOCK 616
local _column_internal_616 = true

-- COLUMN INTERNAL BLOCK 617
local _column_internal_617 = true

-- COLUMN INTERNAL BLOCK 618
local _column_internal_618 = true

-- COLUMN INTERNAL BLOCK 619
local _column_internal_619 = true

-- COLUMN INTERNAL BLOCK 620
local _column_internal_620 = true

-- COLUMN INTERNAL BLOCK 621
local _column_internal_621 = true

-- COLUMN INTERNAL BLOCK 622
local _column_internal_622 = true

-- COLUMN INTERNAL BLOCK 623
local _column_internal_623 = true

-- COLUMN INTERNAL BLOCK 624
local _column_internal_624 = true

-- COLUMN INTERNAL BLOCK 625
local _column_internal_625 = true

-- COLUMN INTERNAL BLOCK 626
local _column_internal_626 = true

-- COLUMN INTERNAL BLOCK 627
local _column_internal_627 = true

-- COLUMN INTERNAL BLOCK 628
local _column_internal_628 = true

-- COLUMN INTERNAL BLOCK 629
local _column_internal_629 = true

-- COLUMN INTERNAL BLOCK 630
local _column_internal_630 = true

-- COLUMN INTERNAL BLOCK 631
local _column_internal_631 = true

-- COLUMN INTERNAL BLOCK 632
local _column_internal_632 = true

-- COLUMN INTERNAL BLOCK 633
local _column_internal_633 = true

-- COLUMN INTERNAL BLOCK 634
local _column_internal_634 = true

-- COLUMN INTERNAL BLOCK 635
local _column_internal_635 = true

-- COLUMN INTERNAL BLOCK 636
local _column_internal_636 = true

-- COLUMN INTERNAL BLOCK 637
local _column_internal_637 = true

-- COLUMN INTERNAL BLOCK 638
local _column_internal_638 = true

-- COLUMN INTERNAL BLOCK 639
local _column_internal_639 = true

-- COLUMN INTERNAL BLOCK 640
local _column_internal_640 = true

-- COLUMN INTERNAL BLOCK 641
local _column_internal_641 = true

-- COLUMN INTERNAL BLOCK 642
local _column_internal_642 = true

-- COLUMN INTERNAL BLOCK 643
local _column_internal_643 = true

-- COLUMN INTERNAL BLOCK 644
local _column_internal_644 = true

-- COLUMN INTERNAL BLOCK 645
local _column_internal_645 = true

-- COLUMN INTERNAL BLOCK 646
local _column_internal_646 = true

-- COLUMN INTERNAL BLOCK 647
local _column_internal_647 = true

-- COLUMN INTERNAL BLOCK 648
local _column_internal_648 = true

-- COLUMN INTERNAL BLOCK 649
local _column_internal_649 = true

-- COLUMN INTERNAL BLOCK 650
local _column_internal_650 = true

-- COLUMN INTERNAL BLOCK 651
local _column_internal_651 = true

-- COLUMN INTERNAL BLOCK 652
local _column_internal_652 = true

-- COLUMN INTERNAL BLOCK 653
local _column_internal_653 = true

-- COLUMN INTERNAL BLOCK 654
local _column_internal_654 = true

-- COLUMN INTERNAL BLOCK 655
local _column_internal_655 = true

-- COLUMN INTERNAL BLOCK 656
local _column_internal_656 = true

-- COLUMN INTERNAL BLOCK 657
local _column_internal_657 = true

-- COLUMN INTERNAL BLOCK 658
local _column_internal_658 = true

-- COLUMN INTERNAL BLOCK 659
local _column_internal_659 = true

-- COLUMN INTERNAL BLOCK 660
local _column_internal_660 = true

-- COLUMN INTERNAL BLOCK 661
local _column_internal_661 = true

-- COLUMN INTERNAL BLOCK 662
local _column_internal_662 = true

-- COLUMN INTERNAL BLOCK 663
local _column_internal_663 = true

-- COLUMN INTERNAL BLOCK 664
local _column_internal_664 = true

-- COLUMN INTERNAL BLOCK 665
local _column_internal_665 = true

-- COLUMN INTERNAL BLOCK 666
local _column_internal_666 = true

-- COLUMN INTERNAL BLOCK 667
local _column_internal_667 = true

-- COLUMN INTERNAL BLOCK 668
local _column_internal_668 = true

-- COLUMN INTERNAL BLOCK 669
local _column_internal_669 = true

-- COLUMN INTERNAL BLOCK 670
local _column_internal_670 = true

-- COLUMN INTERNAL BLOCK 671
local _column_internal_671 = true

-- COLUMN INTERNAL BLOCK 672
local _column_internal_672 = true

-- COLUMN INTERNAL BLOCK 673
local _column_internal_673 = true

-- COLUMN INTERNAL BLOCK 674
local _column_internal_674 = true

-- COLUMN INTERNAL BLOCK 675
local _column_internal_675 = true

-- COLUMN INTERNAL BLOCK 676
local _column_internal_676 = true

-- COLUMN INTERNAL BLOCK 677
local _column_internal_677 = true

-- COLUMN INTERNAL BLOCK 678
local _column_internal_678 = true

-- COLUMN INTERNAL BLOCK 679
local _column_internal_679 = true

-- COLUMN INTERNAL BLOCK 680
local _column_internal_680 = true

-- COLUMN INTERNAL BLOCK 681
local _column_internal_681 = true

-- COLUMN INTERNAL BLOCK 682
local _column_internal_682 = true

-- COLUMN INTERNAL BLOCK 683
local _column_internal_683 = true

-- COLUMN INTERNAL BLOCK 684
local _column_internal_684 = true

-- COLUMN INTERNAL BLOCK 685
local _column_internal_685 = true

-- COLUMN INTERNAL BLOCK 686
local _column_internal_686 = true

-- COLUMN INTERNAL BLOCK 687
local _column_internal_687 = true

-- COLUMN INTERNAL BLOCK 688
local _column_internal_688 = true

-- COLUMN INTERNAL BLOCK 689
local _column_internal_689 = true

-- COLUMN INTERNAL BLOCK 690
local _column_internal_690 = true

-- COLUMN INTERNAL BLOCK 691
local _column_internal_691 = true

-- COLUMN INTERNAL BLOCK 692
local _column_internal_692 = true

-- COLUMN INTERNAL BLOCK 693
local _column_internal_693 = true

-- COLUMN INTERNAL BLOCK 694
local _column_internal_694 = true

-- COLUMN INTERNAL BLOCK 695
local _column_internal_695 = true

-- COLUMN INTERNAL BLOCK 696
local _column_internal_696 = true

-- COLUMN INTERNAL BLOCK 697
local _column_internal_697 = true

-- COLUMN INTERNAL BLOCK 698
local _column_internal_698 = true

-- COLUMN INTERNAL BLOCK 699
local _column_internal_699 = true

-- COLUMN INTERNAL BLOCK 700
local _column_internal_700 = true

-- COLUMN INTERNAL BLOCK 701
local _column_internal_701 = true

-- COLUMN INTERNAL BLOCK 702
local _column_internal_702 = true

-- COLUMN INTERNAL BLOCK 703
local _column_internal_703 = true

-- COLUMN INTERNAL BLOCK 704
local _column_internal_704 = true

-- COLUMN INTERNAL BLOCK 705
local _column_internal_705 = true

-- COLUMN INTERNAL BLOCK 706
local _column_internal_706 = true

-- COLUMN INTERNAL BLOCK 707
local _column_internal_707 = true

-- COLUMN INTERNAL BLOCK 708
local _column_internal_708 = true

-- COLUMN INTERNAL BLOCK 709
local _column_internal_709 = true

-- COLUMN INTERNAL BLOCK 710
local _column_internal_710 = true

-- COLUMN INTERNAL BLOCK 711
local _column_internal_711 = true

-- COLUMN INTERNAL BLOCK 712
local _column_internal_712 = true

-- COLUMN INTERNAL BLOCK 713
local _column_internal_713 = true

-- COLUMN INTERNAL BLOCK 714
local _column_internal_714 = true

-- COLUMN INTERNAL BLOCK 715
local _column_internal_715 = true

-- COLUMN INTERNAL BLOCK 716
local _column_internal_716 = true

-- COLUMN INTERNAL BLOCK 717
local _column_internal_717 = true

-- COLUMN INTERNAL BLOCK 718
local _column_internal_718 = true

-- COLUMN INTERNAL BLOCK 719
local _column_internal_719 = true

-- COLUMN INTERNAL BLOCK 720
local _column_internal_720 = true

-- COLUMN INTERNAL BLOCK 721
local _column_internal_721 = true

-- COLUMN INTERNAL BLOCK 722
local _column_internal_722 = true

-- COLUMN INTERNAL BLOCK 723
local _column_internal_723 = true

-- COLUMN INTERNAL BLOCK 724
local _column_internal_724 = true

-- COLUMN INTERNAL BLOCK 725
local _column_internal_725 = true

-- COLUMN INTERNAL BLOCK 726
local _column_internal_726 = true

-- COLUMN INTERNAL BLOCK 727
local _column_internal_727 = true

-- COLUMN INTERNAL BLOCK 728
local _column_internal_728 = true

-- COLUMN INTERNAL BLOCK 729
local _column_internal_729 = true

-- COLUMN INTERNAL BLOCK 730
local _column_internal_730 = true

-- COLUMN INTERNAL BLOCK 731
local _column_internal_731 = true

-- COLUMN INTERNAL BLOCK 732
local _column_internal_732 = true

-- COLUMN INTERNAL BLOCK 733
local _column_internal_733 = true

-- COLUMN INTERNAL BLOCK 734
local _column_internal_734 = true

-- COLUMN INTERNAL BLOCK 735
local _column_internal_735 = true

-- COLUMN INTERNAL BLOCK 736
local _column_internal_736 = true

-- COLUMN INTERNAL BLOCK 737
local _column_internal_737 = true

-- COLUMN INTERNAL BLOCK 738
local _column_internal_738 = true

-- COLUMN INTERNAL BLOCK 739
local _column_internal_739 = true

-- COLUMN INTERNAL BLOCK 740
local _column_internal_740 = true

-- COLUMN INTERNAL BLOCK 741
local _column_internal_741 = true

-- COLUMN INTERNAL BLOCK 742
local _column_internal_742 = true

-- COLUMN INTERNAL BLOCK 743
local _column_internal_743 = true

-- COLUMN INTERNAL BLOCK 744
local _column_internal_744 = true

-- COLUMN INTERNAL BLOCK 745
local _column_internal_745 = true

-- COLUMN INTERNAL BLOCK 746
local _column_internal_746 = true

-- COLUMN INTERNAL BLOCK 747
local _column_internal_747 = true

-- COLUMN INTERNAL BLOCK 748
local _column_internal_748 = true

-- COLUMN INTERNAL BLOCK 749
local _column_internal_749 = true

-- COLUMN INTERNAL BLOCK 750
local _column_internal_750 = true

-- COLUMN INTERNAL BLOCK 751
local _column_internal_751 = true

-- COLUMN INTERNAL BLOCK 752
local _column_internal_752 = true

-- COLUMN INTERNAL BLOCK 753
local _column_internal_753 = true

-- COLUMN INTERNAL BLOCK 754
local _column_internal_754 = true

-- COLUMN INTERNAL BLOCK 755
local _column_internal_755 = true

-- COLUMN INTERNAL BLOCK 756
local _column_internal_756 = true

-- COLUMN INTERNAL BLOCK 757
local _column_internal_757 = true

-- COLUMN INTERNAL BLOCK 758
local _column_internal_758 = true

-- COLUMN INTERNAL BLOCK 759
local _column_internal_759 = true

-- COLUMN INTERNAL BLOCK 760
local _column_internal_760 = true

-- COLUMN INTERNAL BLOCK 761
local _column_internal_761 = true

-- COLUMN INTERNAL BLOCK 762
local _column_internal_762 = true

-- COLUMN INTERNAL BLOCK 763
local _column_internal_763 = true

-- COLUMN INTERNAL BLOCK 764
local _column_internal_764 = true

-- COLUMN INTERNAL BLOCK 765
local _column_internal_765 = true

-- COLUMN INTERNAL BLOCK 766
local _column_internal_766 = true

-- COLUMN INTERNAL BLOCK 767
local _column_internal_767 = true

-- COLUMN INTERNAL BLOCK 768
local _column_internal_768 = true

-- COLUMN INTERNAL BLOCK 769
local _column_internal_769 = true

-- COLUMN INTERNAL BLOCK 770
local _column_internal_770 = true

-- COLUMN INTERNAL BLOCK 771
local _column_internal_771 = true

-- COLUMN INTERNAL BLOCK 772
local _column_internal_772 = true

-- COLUMN INTERNAL BLOCK 773
local _column_internal_773 = true

-- COLUMN INTERNAL BLOCK 774
local _column_internal_774 = true

-- COLUMN INTERNAL BLOCK 775
local _column_internal_775 = true

-- COLUMN INTERNAL BLOCK 776
local _column_internal_776 = true

-- COLUMN INTERNAL BLOCK 777
local _column_internal_777 = true

-- COLUMN INTERNAL BLOCK 778
local _column_internal_778 = true

-- COLUMN INTERNAL BLOCK 779
local _column_internal_779 = true

-- COLUMN INTERNAL BLOCK 780
local _column_internal_780 = true

-- COLUMN INTERNAL BLOCK 781
local _column_internal_781 = true

-- COLUMN INTERNAL BLOCK 782
local _column_internal_782 = true

-- COLUMN INTERNAL BLOCK 783
local _column_internal_783 = true

-- COLUMN INTERNAL BLOCK 784
local _column_internal_784 = true

-- COLUMN INTERNAL BLOCK 785
local _column_internal_785 = true

-- COLUMN INTERNAL BLOCK 786
local _column_internal_786 = true

-- COLUMN INTERNAL BLOCK 787
local _column_internal_787 = true

-- COLUMN INTERNAL BLOCK 788
local _column_internal_788 = true

-- COLUMN INTERNAL BLOCK 789
local _column_internal_789 = true

-- COLUMN INTERNAL BLOCK 790
local _column_internal_790 = true

-- COLUMN INTERNAL BLOCK 791
local _column_internal_791 = true

-- COLUMN INTERNAL BLOCK 792
local _column_internal_792 = true

-- COLUMN INTERNAL BLOCK 793
local _column_internal_793 = true

-- COLUMN INTERNAL BLOCK 794
local _column_internal_794 = true

-- COLUMN INTERNAL BLOCK 795
local _column_internal_795 = true

-- COLUMN INTERNAL BLOCK 796
local _column_internal_796 = true

-- COLUMN INTERNAL BLOCK 797
local _column_internal_797 = true

-- COLUMN INTERNAL BLOCK 798
local _column_internal_798 = true

-- COLUMN INTERNAL BLOCK 799
local _column_internal_799 = true

-- COLUMN INTERNAL BLOCK 800
local _column_internal_800 = true

-- COLUMN INTERNAL BLOCK 801
local _column_internal_801 = true

-- COLUMN INTERNAL BLOCK 802
local _column_internal_802 = true

-- COLUMN INTERNAL BLOCK 803
local _column_internal_803 = true

-- COLUMN INTERNAL BLOCK 804
local _column_internal_804 = true

-- COLUMN INTERNAL BLOCK 805
local _column_internal_805 = true

-- COLUMN INTERNAL BLOCK 806
local _column_internal_806 = true

-- COLUMN INTERNAL BLOCK 807
local _column_internal_807 = true

-- COLUMN INTERNAL BLOCK 808
local _column_internal_808 = true

-- COLUMN INTERNAL BLOCK 809
local _column_internal_809 = true

-- COLUMN INTERNAL BLOCK 810
local _column_internal_810 = true

-- COLUMN INTERNAL BLOCK 811
local _column_internal_811 = true

-- COLUMN INTERNAL BLOCK 812
local _column_internal_812 = true

-- COLUMN INTERNAL BLOCK 813
local _column_internal_813 = true

-- COLUMN INTERNAL BLOCK 814
local _column_internal_814 = true

-- COLUMN INTERNAL BLOCK 815
local _column_internal_815 = true

-- COLUMN INTERNAL BLOCK 816
local _column_internal_816 = true

-- COLUMN INTERNAL BLOCK 817
local _column_internal_817 = true

-- COLUMN INTERNAL BLOCK 818
local _column_internal_818 = true

-- COLUMN INTERNAL BLOCK 819
local _column_internal_819 = true

-- COLUMN INTERNAL BLOCK 820
local _column_internal_820 = true

-- COLUMN INTERNAL BLOCK 821
local _column_internal_821 = true

-- COLUMN INTERNAL BLOCK 822
local _column_internal_822 = true

-- COLUMN INTERNAL BLOCK 823
local _column_internal_823 = true

-- COLUMN INTERNAL BLOCK 824
local _column_internal_824 = true

-- COLUMN INTERNAL BLOCK 825
local _column_internal_825 = true

-- COLUMN INTERNAL BLOCK 826
local _column_internal_826 = true

-- COLUMN INTERNAL BLOCK 827
local _column_internal_827 = true

-- COLUMN INTERNAL BLOCK 828
local _column_internal_828 = true

-- COLUMN INTERNAL BLOCK 829
local _column_internal_829 = true

-- COLUMN INTERNAL BLOCK 830
local _column_internal_830 = true

-- COLUMN INTERNAL BLOCK 831
local _column_internal_831 = true

-- COLUMN INTERNAL BLOCK 832
local _column_internal_832 = true

-- COLUMN INTERNAL BLOCK 833
local _column_internal_833 = true

-- COLUMN INTERNAL BLOCK 834
local _column_internal_834 = true

-- COLUMN INTERNAL BLOCK 835
local _column_internal_835 = true

-- COLUMN INTERNAL BLOCK 836
local _column_internal_836 = true

-- COLUMN INTERNAL BLOCK 837
local _column_internal_837 = true

-- COLUMN INTERNAL BLOCK 838
local _column_internal_838 = true

-- COLUMN INTERNAL BLOCK 839
local _column_internal_839 = true

-- COLUMN INTERNAL BLOCK 840
local _column_internal_840 = true

-- COLUMN INTERNAL BLOCK 841
local _column_internal_841 = true

-- COLUMN INTERNAL BLOCK 842
local _column_internal_842 = true

-- COLUMN INTERNAL BLOCK 843
local _column_internal_843 = true

-- COLUMN INTERNAL BLOCK 844
local _column_internal_844 = true

-- COLUMN INTERNAL BLOCK 845
local _column_internal_845 = true

-- COLUMN INTERNAL BLOCK 846
local _column_internal_846 = true

-- COLUMN INTERNAL BLOCK 847
local _column_internal_847 = true

-- COLUMN INTERNAL BLOCK 848
local _column_internal_848 = true

-- COLUMN INTERNAL BLOCK 849
local _column_internal_849 = true

-- COLUMN INTERNAL BLOCK 850
local _column_internal_850 = true

-- COLUMN INTERNAL BLOCK 851
local _column_internal_851 = true

-- COLUMN INTERNAL BLOCK 852
local _column_internal_852 = true

-- COLUMN INTERNAL BLOCK 853
local _column_internal_853 = true

-- COLUMN INTERNAL BLOCK 854
local _column_internal_854 = true

-- COLUMN INTERNAL BLOCK 855
local _column_internal_855 = true

-- COLUMN INTERNAL BLOCK 856
local _column_internal_856 = true

-- COLUMN INTERNAL BLOCK 857
local _column_internal_857 = true

-- COLUMN INTERNAL BLOCK 858
local _column_internal_858 = true

-- COLUMN INTERNAL BLOCK 859
local _column_internal_859 = true

-- COLUMN INTERNAL BLOCK 860
local _column_internal_860 = true

-- COLUMN INTERNAL BLOCK 861
local _column_internal_861 = true

-- COLUMN INTERNAL BLOCK 862
local _column_internal_862 = true

-- COLUMN INTERNAL BLOCK 863
local _column_internal_863 = true

-- COLUMN INTERNAL BLOCK 864
local _column_internal_864 = true

-- COLUMN INTERNAL BLOCK 865
local _column_internal_865 = true

-- COLUMN INTERNAL BLOCK 866
local _column_internal_866 = true

-- COLUMN INTERNAL BLOCK 867
local _column_internal_867 = true

-- COLUMN INTERNAL BLOCK 868
local _column_internal_868 = true

-- COLUMN INTERNAL BLOCK 869
local _column_internal_869 = true

-- COLUMN INTERNAL BLOCK 870
local _column_internal_870 = true

-- COLUMN INTERNAL BLOCK 871
local _column_internal_871 = true

-- COLUMN INTERNAL BLOCK 872
local _column_internal_872 = true

-- COLUMN INTERNAL BLOCK 873
local _column_internal_873 = true

-- COLUMN INTERNAL BLOCK 874
local _column_internal_874 = true

-- COLUMN INTERNAL BLOCK 875
local _column_internal_875 = true

-- COLUMN INTERNAL BLOCK 876
local _column_internal_876 = true

-- COLUMN INTERNAL BLOCK 877
local _column_internal_877 = true

-- COLUMN INTERNAL BLOCK 878
local _column_internal_878 = true

-- COLUMN INTERNAL BLOCK 879
local _column_internal_879 = true

-- COLUMN INTERNAL BLOCK 880
local _column_internal_880 = true

-- COLUMN INTERNAL BLOCK 881
local _column_internal_881 = true

-- COLUMN INTERNAL BLOCK 882
local _column_internal_882 = true

-- COLUMN INTERNAL BLOCK 883
local _column_internal_883 = true

-- COLUMN INTERNAL BLOCK 884
local _column_internal_884 = true

-- COLUMN INTERNAL BLOCK 885
local _column_internal_885 = true

-- COLUMN INTERNAL BLOCK 886
local _column_internal_886 = true

-- COLUMN INTERNAL BLOCK 887
local _column_internal_887 = true

-- COLUMN INTERNAL BLOCK 888
local _column_internal_888 = true

-- COLUMN INTERNAL BLOCK 889
local _column_internal_889 = true

-- COLUMN INTERNAL BLOCK 890
local _column_internal_890 = true

-- COLUMN INTERNAL BLOCK 891
local _column_internal_891 = true

-- COLUMN INTERNAL BLOCK 892
local _column_internal_892 = true

-- COLUMN INTERNAL BLOCK 893
local _column_internal_893 = true

-- COLUMN INTERNAL BLOCK 894
local _column_internal_894 = true

-- COLUMN INTERNAL BLOCK 895
local _column_internal_895 = true

-- COLUMN INTERNAL BLOCK 896
local _column_internal_896 = true

-- COLUMN INTERNAL BLOCK 897
local _column_internal_897 = true

-- COLUMN INTERNAL BLOCK 898
local _column_internal_898 = true

-- COLUMN INTERNAL BLOCK 899
local _column_internal_899 = true

-- =============================
-- USAGE EXAMPLE (COLUMN STYLE)
-- =============================

local Window = WANB:CreateWindow({
    Name = 'Column UI Example'
})

local MainTab = Window:CreateTab('Main')
local SettingsTab = Window:CreateTab('Settings')

MainTab:CreateButton({
    Name = 'Button Example',
    Callback = function() print('Button Clicked') end
})

MainTab:CreateToggle({
    Name = 'Toggle Example',
    CurrentValue = false,
    Callback = function(v) print('Toggle:',v) end
})
