--No Default values / optional arguments
--No way to have multiple constructors
--Set a bool in newClass; make members private
--Destructor function?
--Deallocate memory
--Delete Classes
--Delete method(s)

Class = {}
Class.__classes = {}

local classExists = function(name)
  return(type(Class.__classes[name]) == "table")
end

local methodExists = function(name, fxn)
  return(type(Class.__classes[name][fxn]) == "function")
end

--Name of the class, ARRAY of member NAMES
Class.newClass = function(name, args)
  if not classExists(name) then
    local t = {}
    setmetatable(t, {__index = Class})
    t.args = args
    Class.__classes[name] = t
  else
    assert(false, "Class " .. name .. " is already defined.")
  end
end

--Name of the class, ARRAY of member VALUES
Class.new = function(name, args)
  if classExists(name) then
    local t = {}
    setmetatable(t, { 
        __index = Class.__classes[name],
        __tostring = function(t) return name end})
    for k, v in ipairs(Class.__classes[name].args) do
      t[v] = args[k]
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