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
  when "func_call"
    p(evoluate(tree[2], genv, lenv))
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
tree = minruby_parse(minruby_load())
p tree
genv = {}
lenv = {}
evoluate(tree, genv, lenv)
