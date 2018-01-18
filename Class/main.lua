function love.load(dir, mode)
  require("class")
  math.randomseed(os.time())
  local Test = Class.newClass("Test", {"name", "value"}, {}, true)
  Test.getAllData = function(self, someValue)
    local out = ""
    for k, v in pairs(self) do
      if type(v) == "string" or type(v) == "number" then
        out = out .. v
      end
    end
    return out .. ":" .. someValue
  end
  Test.getName = function(self) return self[self.__prefix .. "name"] end
  test = Test:new({"TEST 123", 12345})
  
  Test2 = Test:isA("Test2", {"newValue"}, {"Test2", 345, 456}, true)
  test2 = Test2:new({})
end


function love.update(dt)
end

function love.draw()
  love.graphics.print(test:getName(), 0, 0)
  love.graphics.print(test:getAllData(25), 0, 20)
  love.graphics.print(tostring(test), 0, 40)
  love.graphics.print(test2:getName(), 0, 60)
  love.graphics.print(test2:getAllData(35), 0, 80)
  love.graphics.print(tostring(test2), 0, 100)
end
