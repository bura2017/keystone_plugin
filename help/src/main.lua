local function main(...)
      
  local f1 = {a = 1, b = 2}  -- Представляет деление a/b.
  local f2 = {a = 2, b = 3}
  
  -- Вот так не получиться:
  -- s = f1 + f2
  
  local metafraction = {}
  function metafraction.__add(f1, f2)
    local sum = {}
    sum.b = f1.b * f2.b
    sum.a = f1.a * f2.b + f2.a * f1.b
    setmetatable(sum, metafraction)
    return sum
  end
  
  setmetatable(f1, metafraction)
  setmetatable(f2, metafraction)
  
  local s = f1 + f2  -- вызывает __add(f1, f2) в метатаблице f1
  print (s)
  local t = s + s
  print (t.a .. ' ' .. t.b)
  
  local a = 2 / 0
  print(a)
  local a = 2 / a
  print('\a')
  
  local a, b, c = ...
  local table = {} table.a = 2
  c(table)
  print('c({a = 2})', table.a)
  
  
  for _, val in ipairs({...}) do
    print(val)
  end

end

main(1, 'a', function (a) a.a = a.a * 2 end, nil)
