local RootGroup = models.model.main
local anims = require("libs.JimmyAnims")
anims(animations.model)

local SwingingPhysics = require("libs.swinging_physics")
local swingOnHead = SwingingPhysics.swingOnHead
local swingOnBody = SwingingPhysics.swingOnBody

require("libs.GSAnimBlend")

config:setName("nplusplus_color_config") -- rename config file to appropriate name

if config:load("firstRun") ~= 1 then -- if firstRun is found to have nothing
  config:save("firstRun",1) -- then set it to one
  config:save("Hcolor", vec(255,0,59,255)) -- and the default is saved, to prevent crashes on startup.
  config:save("Bcolor", vec(255,255,255,255)) -- same thing.
  config:save("fastScrollKey", "key.keyboard.left.shift") -- oh yeah, default key for color scrolling.
end

--hides vanilla model
vanilla_model.PLAYER:setVisible(false)

--hides vanilla armor model
vanilla_model.ARMOR:setVisible(false)

--re-enables the helmet item
vanilla_model.HELMET_ITEM:setVisible(true)

--hides vanilla cape model
vanilla_model.CAPE:setVisible(false)

--hides vanilla elytra model
vanilla_model.ELYTRA:setVisible(false)



--COLOR.LUA section start
presets = { -- Freely editable area start
  ["default"] = {
    ["headband"] = vec(255,0,59,255), -- 255 red, 0 green, 59 blue. Starts at the back of your head.
    ["body"] = vec(255,255,255,255), -- same here, just now all over your body.
    ["action"] = {"Default","bone",vec(1,0,0.23)} -- 1 is 100%, 0.5 is half.
  },
  ["plus"] = {
    ["headband"] = vec(255,11,14,255),
    ["body"] = vec(15,15,15,255),
    ["action"] = {"Plus","gilded_blackstone",vec(1,1,1)}
  },
  ["midnight"] = {
    ["headband"] = vec(174,13,187,255),
    ["body"] = vec(133,0,58,255),
    ["action"] = {"Midnight","crimson_stem",vec(1,1,1)}
  },
  ["midas"] = {
    ["headband"] = vec(255,255,255,255),
    ["body"] = vec(237,220,84,255),
    ["action"] = {"Midas","gold_block" --[[ i had to]],vec(0.87,0.6,0.26)}
  }
} -- Freely editable area end

function pings.colorMade()
  local Body_Tex = textures["model.ninja"]
  local HB_Tex = textures["model.headband"]

  Body_Tex:fill(0,0,2,2,(config:load("Bcolor") / 255))
    :update()

  HB_Tex:fill(0,0,2,2,(config:load("Hcolor") / 255))
    :update()
end

local mainPage = action_wheel:newPage("Settings")
local colorPage = action_wheel:newPage("Body Colors")
local HB_colorPage = action_wheel:newPage("Headband Colors")
local presetPage = action_wheel:newPage("Color Presets") -- I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT I HATE THIS PLACEMENT 

for key,value in pairs(presets) do --taking info from presets["preset"].action and making shit
  presetPage:newAction()
    :setTitle(value["action"][1])
    :setItem(value["action"][2])
    :setHoverColor(value["action"][3])
    :onLeftClick(function() 
      config:save("Hcolor", presets[key]["headband"])
      config:save("Bcolor", presets[key]["body"])
      pings.colorMade() 
      action_wheel:setPage(mainPage)
      end)
end

-- Functions
local fastScroll = keybinds:newKeybind("Faster Scroll (Action Wheel)", config:load("fastScrollKey"), true)

local function Bscroll(dir) -- modifies current body color via scroll wheel.
  log(dir)

  local Title = action_wheel:getSelectedAction():getTitle()
  print(Title)
  
  local pastColor = config:load("Bcolor")

  local ScrollPass

  if fastScroll:isPressed() then
    ScrollPass = 4
  else
    ScrollPass = 1
  end

  if Title == "Red" then
    pastColor.x = pastColor.x + (dir * ScrollPass) -- Direction multiplies with fastScroll
    if pastColor.x > 255 then pastColor.x = 255 end
    if pastColor.x < 0 then pastColor.x = 0 end
  elseif Title == "Green" then
    pastColor.y = pastColor.y + (dir * ScrollPass)
    if pastColor.y > 255 then pastColor.y = 255 end
    if pastColor.y < 0 then pastColor.y = 0 end
  elseif Title == "Blue" then
    pastColor.z = pastColor.z + (dir * ScrollPass)
    if pastColor.z > 255 then pastColor.z = 255 end
    if pastColor.z < 0 then pastColor.z = 0 end
  else
    return nil
  end
  print(pastColor)

  config:save("Bcolor", pastColor)
  pings.colorMade() 
end

local function Hscroll(dir) -- modifies current headband color via scroll wheel.
  local Title = action_wheel:getSelectedAction():getTitle()
  
  local pastColor = config:load("Hcolor")

  local ScrollPass

  if fastScroll:isPressed() then
    ScrollPass = 4
  else
    ScrollPass = 1
  end

  if Title == "Red" then
    pastColor.x = pastColor.x + (dir * ScrollPass) -- Direction multiplies with fastScroll
    if pastColor.x > 255 then pastColor.x = 255 end
    if pastColor.x < 0 then pastColor.x = 0 end
  elseif Title == "Green" then
    pastColor.y = pastColor.y + (dir * ScrollPass)
    if pastColor.y > 255 then pastColor.y = 255 end
    if pastColor.y < 0 then pastColor.y = 0 end
  elseif Title == "Blue" then
    pastColor.z = pastColor.z + (dir * ScrollPass)
    if pastColor.z > 255 then pastColor.z = 255 end
    if pastColor.z < 0 then pastColor.z = 0 end
  else
    return nil
  end

  config:save("Hcolor", pastColor)
  pings.colorMade() 
end
--WE REACHED PEAK CODING HYPE, LET'S FUCKING GOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO!!!

colorCopy = {
  ["body"] = {
    {
      ["input"] = config:load("Bcolor").x__, --red value
      ["action"] = {"Red","red_dye",vec(1, 0.2, 0)},
      ["mode"] = "red"
    },
    {
      ["input"] = config:load("Bcolor")._y_, --green value
      ["action"] = {"Green","green_dye",vec(0.3, 1, 0)},
      ["mode"] = "green"
    },
    {
      ["input"] = config:load("Bcolor").__z, --blue value
      ["action"] = {"Blue","blue_dye",vec(0, 0.5, 1)},
      ["mode"] = "blue"
    }
  },
  ["headband"] = {
    {
      ["input"] = config:load("Hcolor").x___, --red value
      ["action"] = {"Red","red_dye",vec(1, 0.2, 0)},
      ["mode"] = "red"
    },
    {
      ["input"] = config:load("Hcolor")._y__, --green value
      ["action"] = {"Green","green_dye",vec(0.3, 1, 0)},
      ["mode"] = "green"
    },
    {
      ["input"] = config:load("Hcolor").__z_, --blue value
      ["action"] = {"Blue","blue_dye",vec(0, 0.5, 1)},
      ["mode"] = "blue"
    }
  } --what am i doing anymore.
} 

for key,value in pairs(colorCopy.body) do
  colorPage:newAction()
    :setTitle(value["action"][1])
    :setItem(value["action"][2])
    :setHoverColor(value["action"][3])
    :onScroll(Bscroll)
end

for key,value in pairs(colorCopy.body) do
  HB_colorPage:newAction()
    :setTitle(value["action"][1])
    :setItem(value["action"][2])
    :setHoverColor(value["action"][3])
    :onScroll(Hscroll)
end

function pings.headband_toggle(state)
  RootGroup.Head.headband1:setVisible(not state)
end

-- Pages

action_wheel:setPage(mainPage) --setting the pages ready

local ColorButton = mainPage:newAction() --create Colors submenu button
  :title("Adjust Colors")
  :item("minecraft:repeater")
  :hoverColor(0, (164/255), (182/255))
  :onLeftClick(function()
      action_wheel:setPage(colorPage)
  end)

local HB_toggle = mainPage:newAction() --create Headband toggle
  :title("Turn Headband Off")
  :toggleTitle("Turn Headband On")
  :item("minecraft:string")
  :hoverColor(1, 0, 0.23)
  :setOnToggle(pings.headband_toggle)

local ThemeButton = mainPage:newAction() -- presets button
  :title("Select Preset")
  :item("minecraft:potion")
  :hoverColor(0, (164/255), (182/255))
  :onLeftClick(function()
      action_wheel:setPage(presetPage)
  end)

local Color_back = colorPage:newAction() -- back button for body color menu
  :title("Back")
  :item("minecraft:tnt")
  :hoverColor(1, 1, 0)
  :onLeftClick(function() action_wheel:setPage(mainPage) end)

local Color_HB_next = colorPage:newAction() --the start of the headband stuff
  :title("Headband Colors")
  :item("minecraft:string")
  :hoverColor(1, 0, 23)
  :onLeftClick(function() action_wheel:setPage(HB_colorPage) end)

local HB_Color_fuck = HB_colorPage:newAction() -- back to main button for headband color menu
  :title("Back to Main")
  :item("minecraft:observer")
  :hoverColor(1, 1, 0)
  :onLeftClick(function() action_wheel:setPage(mainPage) end)

local HB_Color_back = HB_colorPage:newAction()
  :title("Back to Body Colors")
  :item("minecraft:tnt")
  :hoverColor(1, 1, 0)
  :onLeftClick(function() action_wheel:setPage(colorPage) end)

--END OF COLOR.LUA REMAINS


--"used for when the avatar entity is loaded for the first time" okay baussss
function events.entity_init()
  Headband_trail = {
    RootGroup.Head.headband1,
    RootGroup.Head.headband1.headband2,
    RootGroup.Head.headband1.headband2.headband3,
    RootGroup.Head.headband1.headband2.headband3.headband4,
    RootGroup.Head.headband1.headband2.headband3.headband4.headband5,
    RootGroup.Head.headband1.headband2.headband3.headband4.headband5.headband6,
    RootGroup.Head.headband1.headband2.headband3.headband4.headband5.headband6.headband7,
    RootGroup.Head.headband1.headband2.headband3.headband4.headband5.headband6.headband7.headband8
  }

  BoneHB_List = {
    BoneHeadband1 = nil,
    BoneHeadband2 = nil,
    BoneHeadband3 = nil,
    BoneHeadband4 = nil,
    BoneHeadband5 = nil,
    BoneHeadband6 = nil,
    BoneHeadband7 = nil,
    BoneHeadband8 = nil,
    BoneHeadband9 = nil,
    BoneHeadband10 = nil,
    BoneHeadband11 = nil,
    BoneHeadband12 = nil,
    BoneHeadband13 = nil,
    BoneHeadband14 = nil,
    BoneHeadband15 = nil,
    BoneHeadband16 = nil,
  }

  swingOnHead(Headband_trail[1], 270, nil)

  for i=1,#Headband_trail do
    local bandLimits = {(-90 + ((i - 1) * 13)),(90 - ((i - 1) * 15)),0,0,0,0}

    if not (i >= #Headband_trail) then
      swingOnBody(Headband_trail[i+1], (i / 4), bandLimits, Headband_trail[i], (i/2))
    end
  end

  animations.model.idle:setBlendTime(0)
  animations.model.walk:setBlendTime(0)
  animations.model.crouch:setBlendTime(0)
  animations.model.crouchwalk:setBlendTime(0)
  animations.model.jumpup:setBlendTime(0.1,6)
  animations.model.jumpdown:setBlendTime(6,0.1)
  animations.model.sprintjumpup:setBlendTime(0.1,6)
  animations.model.sprintjumpdown:setBlendTime(6,0.1)
  animations.model.mineL:setBlendTime(0)
  animations.model.mineR:setBlendTime(0)
  animations.model.attackL:setBlendTime(0)
  animations.model.attackR:setBlendTime(0)

  pings.colorMade()
  
  --print(colorPage:getActions()[1]:getTitle())

  -- print("psssst.. try holding down the action wheel key... \nYou can find that out in Figura's settings, or in Minecraft's keymaps.")
end

function events.render(delta, context)
  --code goes here

  if not player:isCrouching() then
    animations.model.walk:setSpeed((player:getVelocity().xz:length() * 9))
  else
    animations.model.walk:setSpeed(0)
  end

  AnimTest()
end

--ctrl c, ctrl v.
function AnimTest()
  if player:isVisuallySwimming() then
    --what are the blocks on/below me?
    local onMe = world.getBlockState(player:getPos())
    local belowMe = world.getBlockState(player:getPos() - vec(0,1,0))

    if onMe:getID() ~= "minecraft:water" and belowMe:getID() ~= "minecraft:water" then
      RootGroup.Head:setRot(45, 0,0) --death
    end
  else
      RootGroup.Head:setRot(0,0,0)
  end

end
