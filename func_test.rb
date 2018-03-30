def foo(x, y)
  x + y * 2
end

foo = foo(1, 1)
foo = foo(foo, foo(1, 1))
p foo
