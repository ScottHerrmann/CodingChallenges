function love.load(dir, mode)
  require("class")
  math.randomseed(os.time())
  Class.newClass("Test", {"name", "value"}, {}, true)
  local fxn = function(self, someValue)
    local out = ""
    for k, v in pairs(self) do
      if type(v) == "string" or type(v) == "number" then
        out = out .. v
      end
    end
    return out .. ":" .. someValue
  end
  Class.newMethod("Test", "GetAllData", fxn)
  Class.newMethod("Test", "getName", function(self) return self[self.__prefix .. "name"] end)
  Test = Class.new("Test", {"TEST 123", 12345})
  Class.newClass("Test2", {"name", "value"}, {"Default Name", 12342563})
  Test2 = Class.new("Test2", {"Not Default Name"})
  print(math.random(1, 2))
  
end


function love.update(dt)
end

function love.draw()
  love.graphics.print(Test:getName(), 0, 0)
  --love.graphics.print(Test.value, 0, 20)
  love.graphics.print(Test:GetAllData(25), 0, 40)
  love.graphics.print(tostring(Test), 0, 60)
  love.graphics.print(Test2.name, 0, 80)
  love.graphics.print(Test2.value, 0, 100)
end
