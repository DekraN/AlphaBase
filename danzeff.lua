--[[
=============================================
Danzeff.lua by Cancan

Adaption of the danzeff keyboard OSK from Danzel to LUA

Virtual keyboard functions

Email: cancangm (at) gmail (dot) com
=============================================
]]

--- Danzeff Definition

Danzeff = {
  map = {
    ",abc.def!ghi-jkl\009m n?opq(rst:uvw)xyz",
    "\0\0\0001\0\0\0002\0\0\0003\0\0\0004\009\0 5\0\0\0006\0\0\0007\0\0\0008\0\00009",
    "^ABC@DEF*GHI_JKL\009M N\"OPQ=RST;UVW/XYZ",
    "'(.)\"<'>-[_]!{?}\009\0 \0+\\=/:@;#~$`%*^|&"
  },
  pictures = {
    pic1 = Image.load("./danzeff/keys.png"),
    pic2 = Image.load("./danzeff/nums.png"),
    pic3 = Image.load("./danzeff/keys_c.png"),
    pic4 = Image.load("./danzeff/nums_c.png"),
    pic1m = Image.load("./danzeff/keys_t.png"),
    pic2m = Image.load("./danzeff/nums_t.png"),
    pic3m = Image.load("./danzeff/keys_c_t.png"),
    pic4m = Image.load("./danzeff/nums_c_t.png"),
    keyboardm = Image.createEmpty(150,150),
    keyboard = Image.createEmpty(150,150),
  },
  mode = 1,
  keyposx = 330,
  keyposy = 122,
  blockx = 2,
  blocky = 2
}

function Danzeff:New()
   c = {}
   setmetatable(c, self)
   self.__index = self
   return c
end

function Danzeff:Display()

  self.pictures.keyboard:clear()
  self.pictures.keyboardm:clear()
  if self.mode == 1 then
    self.pictures.keyboard:blit(0, 0, self.pictures.pic1)
    self.pictures.keyboardm:blit(0, 0, self.pictures.pic1m)
  elseif  self.mode == 2 then
    self.pictures.keyboard:blit(0, 0, self.pictures.pic2)
    self.pictures.keyboardm:blit(0, 0, self.pictures.pic2m)
  elseif  self.mode == 3 then
    self.pictures.keyboard:blit(0, 0, self.pictures.pic3)
    self.pictures.keyboardm:blit(0, 0, self.pictures.pic3m)
  else
    self.pictures.keyboard:blit(0, 0, self.pictures.pic4)
    self.pictures.keyboardm:blit(0, 0, self.pictures.pic4m)
  end
  self.pictures.keyboardm:fillRect((self.blockx - 1) * 50, (self.blocky - 1) * 50,  50, 50)

  --- Display the keyboard

  screen:blit(self.keyposx, self.keyposy, self.pictures.keyboard)
  screen:blit(self.keyposx, self.keyposy, self.pictures.keyboardm)

end

--[[
====================================================
Attempts to read a character from the controller
If no character is pressed then we return 0
Other special values:
1 = move left, 2 = move right, 3 = select, 4 = start
Every other value should be a standard ascii value.
====================================================
]]
function Danzeff:Input(pad)
 
  -- Special functions

  if pad:left() then
    return(1)
  end
  if pad:right() then
    return(2)
  end
  if pad:up() then
    return(8)
  end
  if pad:down() then
    return(string.byte('\n', 1))
  end

  -- Select the correct block

  local posx = 2
  local posy = 2

  if pad:analogX() < -42 then posx = 1 end
  if pad:analogX() > 42  then posx = 3 end
  if pad:analogY() < -42 then posy = 1 end
  if pad:analogY() > 42  then posy = 3 end

  if self.blocky ~= posy or self.blockx ~= posx then
    self.blocky = posy
    self.blockx = posx
  end

  -- Select between keys and num

  if self.mode > 2 then self.mode = self.mode - 2 end

  if pad:l() then
    if self.mode == 1 then
      self.mode = 2
    else
      self.mode = 1
    end
  end

  -- Is the keyboard shifted?
  
  if pad:r() then self.mode = self.mode + 2 end

  -- Standard keys

  if pad:start() then
    return(4)
  elseif pad:select() then
    return(3)
  else
    charpos = ((self.blocky - 1) * 12) + ((self.blockx - 1) * 4)
    if pad:square() then       return(string.byte(self.map[self.mode], charpos + 2))
    elseif pad:circle() then   return(string.byte(self.map[self.mode], charpos + 4))
    elseif pad:cross() then    return(string.byte(self.map[self.mode], charpos + 3))
    elseif pad:triangle() then return(string.byte(self.map[self.mode], charpos + 1))
    else
      return(0)
    end
  end
end

function Danzeff:Init(keyposx, keyposy)
    
  self.keyposx = keyposx
  self.keyposy = keyposy
  self.blockx = 2
  self.blocky = 2
  self.mode = 1

  self:Display()

end
