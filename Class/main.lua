function love.load()
  require("class")
  Class.newClass("Test", {"name", "value"})
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
  Test = Class.new("Test", {"Hello World", 12345})
end


function love.update(dt)
end

function love.draw()
  love.graphics.print(Test.name, 0, 0)
  love.graphics.print(Test.value, 0, 20)
  love.graphics.print(Test:GetAllData(25), 0, 40)
  love.graphics.print(tostring(Test), 0, 60)
end
