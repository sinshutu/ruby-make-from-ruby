i = 0
while i < 100
  i = i + 1
  if i % 15 == 0
    p 'FizzBuzz'
  elsif i % 3 == 0
    p 'Fizz'
  elsif i % 5 == 0
    p 'Buzz'
  else
    p i
  end
end
