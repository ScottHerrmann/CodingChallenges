--No Default values / optional arguments
--No way to have multiple constructors
--Set a bool in newClass; make members private
--Destructor function?
--Deallocate memory
--Delete Classes
--Delete method(s)
--Make classes their own object constructors
Class = {}

local minPrefix = 3
local maxPrefix = 8

local generatePrivatePrefix = function()
  local ranLen = math.floor(math.random(minPrefix, maxPrefix))
  local out = ""
  local validChars = {
    {65, 90}, --Captial letters
    {97, 122}, --lowercase letters
    {48, 57} -- numbers
  }
  local first = math.floor(math.random(1, 2))
  out = out .. string.char(math.floor(math.random(validChars[first][1], validChars[first][2])))
  for i = 2, ranLen do
    local setIndex = math.floor(math.random(1, 3))
    out = out .. string.char(math.floor(math.random(validChars[setIndex][1], validChars[setIndex][2])))
  end
  return out
end


--Name of the class, ARRAY of member NAMES
Class.newClass = function(name, args, defaults, bPrivate)
  local t = {}
  setmetatable(t, {__index = Class,
      __tostring = function(t) return name end})
  t.__private = bPrivate
  t.__name = name
  if bPrivate == true then
    local prefix = generatePrivatePrefix()
    for k, v in pairs(args) do
      args[k] = prefix .. v
    end
    t.__prefix = prefix
  end
  t.args = args
  if type(defaults) == "table" then
    t.defaultArgs = defaults
  end
  return t
end

Class.isA = function(parent, childName, args, defaults, bPrivate)
  local t = {}
  setmetatable(t, {__index = parent,
      __tostring = function(t) return t.__name end})
  t.__private = bPrivate
  t.__name = childName
  local argOffset = #parent.args
  local newArgList = {}
  for k, v in ipairs(parent.args) do
    newArgList[k] = v
  end
  if args then
    for k, v in ipairs(args) do
      newArgList[k+argOffset] = v
    end
  end
  t.args = newArgList
  if type(defaults) == "table" then
    t.defaultArgs = defaults
  end
  return t
end


--Name of the class, ARRAY of member VALUES
Class.new = function(self, args)
  local argCount = #self.args 
  local inArgCount = #args
  local memberNames = self.args
  local defaults = self.defaultArgs
  local t = {}
  setmetatable(t, { 
      __index = self,
      __tostring = function(t) return t.__name end})
  for i = 1, argCount do
    if defaults ~= nil and (args[i] == nil or args[i] == "") then
      if defaults[i] then
        t[memberNames[i]] = defaults[i]
      else
        assert(false, "Attempted to index default value for " .. memberNames[i] .. ". No default set.")
      end
    elseif defaults == nil and (args[i] == nil or args[i] == "") then
      assert(false, "Attempted to index default value for " .. memberNames[i] .. ". No default set.")
    else
      t[memberNames[i]] = args[i]
    end
  end
  if type(t.init) == "function" then
    t.init()
  end
  return t
end