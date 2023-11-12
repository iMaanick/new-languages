function f(x, coef)
    local poly = 0
    for degree, coefficient in ipairs(coef) do
      poly = poly + coefficient * x ^ (degree - 1)
    end
    return poly
  end
  
  function leftRectangleIntegration(lowerLimit, upperLimit, n, coef)
    local h = (upperLimit - lowerLimit) / n
    local sum = 0
  
    for i = 0, n - 1 do
      local x = lowerLimit + i * h
      sum = sum + f(x, coef) * h
    end
  
    return sum
  end
  
  function readFile()
    io.input("data.txt")
    local coef = {}
    local lowerLimit = 0
    local upperLimit = 0
    local i = 1
    while true do
      local val = io.read("*number")
      if val == nil then break end
      if i == 1 then
        lowerLimit = val
        i = i + 1
  
      elseif i == 2 then
        upperLimit = val
        i = i + 1
  
      else 
        coef[i - 2] = val
        i = i + 1
      end
    end
    io.close()
    return lowerLimit, upperLimit, coef
  end
  
  function integration(lowerLimit, upperLimit, n, coef, targetAccuracy)
    local currentAccuracy = math.huge -- текущая точность
    local previousIntegral = 0
    local integral = leftRectangleIntegration(lowerLimit, upperLimit, n, coef)
    while currentAccuracy > targetAccuracy do
      previousIntegral = integral
      n = n * 2
      integral = leftRectangleIntegration(lowerLimit, upperLimit, n, coef)
      currentAccuracy = math.abs(integral - previousIntegral)
    end
    return integral
  end
  
  
  
  local targetAccuracy = 1e-3 
  local n = 1 
  local lowerLimit, upperLimit, coef = readFile()
  local integral = integration(lowerLimit, upperLimit, n, coef, targetAccuracy)
  
  print("Интеграл:", integral)
  print("done")
  