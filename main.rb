require 'minruby'


def evoluate(tree, genv, lenv)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    env['plus_count'] += 1 unless lenv['plus_count'].nil?
    evoluate(tree[1], genv, lenv) + evoluate(tree[2], genv, lenv)
  when "-"
    evoluate(tree[1], genv, lenv) - evoluate(tree[2], genv, lenv)
  when "*"
    evoluate(tree[1], genv, lenv) * evoluate(tree[2], genv, lenv)
  when "**"
    evoluate(tree[1], genv, lenv) ** evoluate(tree[2], genv, lenv)
  when "/"
    evoluate(tree[1], genv, lenv) / evoluate(tree[2], genv, lenv)
  when "%"
    evoluate(tree[1], genv, lenv) % evoluate(tree[2], genv, lenv)
  when "=="
    evoluate(tree[1], genv, lenv) == evoluate(tree[2], genv, lenv)
  when ">"
    evoluate(tree[1], genv, lenv) > evoluate(tree[2], genv, lenv)
  when "<"
    evoluate(tree[1], genv, lenv) < evoluate(tree[2], genv, lenv)
  when "func_def"
    genv[tree[1]] = ['user_defined', tree[2], tree[3]]
  when "func_call"
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evoluate(tree[i + 2], genv, lenv)
      i += 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == 'builtin'
      minruby_call(mhd[1], args)
    else
      new_lenv = {}
      mhd[1].each_with_index do |param, index|
        new_lenv[param] = args[index]
      end
      evoluate(mhd[2], genv, new_lenv)
    end
  when "var_assign"
    lenv[tree[1]] = evoluate(tree[2], genv, lenv)
  when "var_ref"
    lenv[tree[1]]
  when "stmts"
    i = 1
    while tree[i] != nil
      last = evoluate(tree[i], genv, lenv)
      i += 1
    end
    last
  when "if"
    if evoluate(tree[1], genv, lenv)
      evoluate(tree[2], genv, lenv)
    else
      evoluate(tree[3], genv, lenv)
    end
  when "while"
    while evoluate(tree[1], genv, lenv)
      evoluate(tree[2], genv, lenv)
    end
  when "ary_new"
    ary = []
    i = 0
    while tree[i + 1]
      ary[i] = evoluate(tree[i + 1], genv, lenv)
      i = i + 1
    end
    ary
  when "ary_ref"
    var = evoluate(tree[1], genv, lenv)
    index = evoluate(tree[2], genv, lenv)
    var[index]
  else
    "no support operand: #{tree[0]}"
  end
end

def plus_count(tree)
  case tree[0]
  when "lit"
    tree[1]
  else
    if max(tree[1]) < max(tree[2])
      max(tree[2])
    else
      max(tree[1])
    end
  end
end

def max(tree)
  case tree[0]
  when "lit"
    tree[1]
  else
    if max(tree[1]) < max(tree[2])
      max(tree[2])
    else
      max(tree[1])
    end
  end
end

def add(x, y)
  x + y
end

def fizzbuzz(limit)
  i = 0
  while 0 < limit
    limit = limit - 1
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
end

tree = minruby_parse(minruby_load())
p tree
genv = {
  'p' => ['builtin', 'p'],
  'add' => ['builtin', 'add'],
  'fizzbuzz' => ['builtin', 'fizzbuzz'],
}
lenv = {}
evoluate(tree, genv, lenv)
