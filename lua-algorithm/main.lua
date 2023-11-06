function f(x, coef)
    local f = 0
    for l, line in ipairs(coef) do
      f = f + line * x ^ (l - 1)
    end
    return f
  end
  
  -- Метод левых прямоугольников
  function leftRectangleIntegration(a, b, n, coef)
    local h = (b - a) / n
    local sum = 0
  
    for i = 0, n - 1 do
      local x = a + i * h
      sum = sum + f(x, coef) * h
    end
  
    return sum
  end
  
  function readFile()
    io.input("data.txt")
    local coef = {}
    local a = 0
    local b = 0
    local i = 1
    while true do
      local val = io.read("*number")
      if val == nil then break end
      if i == 1 then
        a = val
        i = i + 1
  
      elseif i == 2 then
        b = val
        i = i + 1
  
      else 
        coef[i - 2] = val
        i = i + 1
      end
    end
    io.close()
    return a, b, coef
  end
  
  -- Итеративное вычисление интеграла с заданной точностью
  function integration(a, b, n, coef, targetAccuracy)
    local currentAccuracy = math.huge -- текущая точность
    local previousIntegral = 0
    local integral = 0
    while currentAccuracy > targetAccuracy do
      previousIntegral = leftRectangleIntegration(a, b, n, coef)
      n = n * 2
      integral = leftRectangleIntegration(a, b, n, coef)
      currentAccuracy = math.abs(integral - previousIntegral)
    end
    return integral
  end
  
  
  
  -- Параметры интегрирования
  local targetAccuracy = 1e-3 -- заданная точность
  local n = 1 -- начальное количество интервалов
  local a, b, coef = readFile()
  -- Итеративное вычисление интеграла с заданной точностью
  local integral = integration(a, b, n, coef, targetAccuracy)
  
  print("Интеграл:", integral)
  print("done")
  