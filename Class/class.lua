--No Default values / optional arguments
--No way to have multiple constructors
--Set a bool in newClass; make members private
--Destructor function?
--Deallocate memory
--Delete Classes
--Delete method(s)
--Make classes their own object constructors
Class = {}
Class.__classes = {}

local minPrefix = 3
local maxPrefix = 8

local classExists = function(name)
  return(type(Class.__classes[name]) == "table")
end

local methodExists = function(name, fxn)
  return(type(Class.__classes[name][fxn]) == "function")
end

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
  if not classExists(name) then
    local t = {}
    setmetatable(t, {__index = Class})
    t.private = bPrivate
    if bPrivate == true then
      local prefix = generatePrivatePrefix()
      for k, v in pairs(args) do
        local tmp = prefix .. v
        args[k] = tmp
      end
      t.__prefix = prefix
    end
    t.args = args
    if type(defaults) == "table" then
      t.defaultArgs = defaults
    end
    Class.__classes[name] = t
  else
    assert(false, "Class " .. name .. " is already defined.")
  end
end

--Name of the class, ARRAY of member VALUES
Class.new = function(name, args)
  if classExists(name) then
    local argCount = #Class.__classes[name].args 
    local inArgCount = #args
    local memberNames = Class.__classes[name].args
    local defaults = Class.__classes[name].defaultArgs
    local t = {}
    setmetatable(t, { 
        __index = Class.__classes[name],
        __tostring = function(t) return name end,
        __newindex = Class.__classes[name]})
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
  else
    assert(false, "Class " .. name .. " is not defined.")
  end
end

--Name of the class, name of the function, the function
Class.newMethod = function(className, methodName, method)
  if classExists(className) then
    if not methodExists(className, methodName) then
      Class.__classes[className][methodName] = method
    else
      assert(false, "Method " .. methodName .. " for class " .. className .. " already defined.")
    end
  else
    assert(false, "Class " .. name .. " not defined.")
  end
end