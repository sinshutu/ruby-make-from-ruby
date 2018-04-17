def fibo(x)
  if x < 2
    x
  else
    fibo(x - 1) + fibo(x - 2)
  end
end

i = 0
while i < 10
  p fibo(i)
  i = i + 1
end
