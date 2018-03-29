require 'minruby'


def evoluate(tree, env)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    env['plus_count'] += 1 unless env['plus_count'].nil?
    evoluate(tree[1], env) + evoluate(tree[2], env)
  when "-"
    evoluate(tree[1], env) - evoluate(tree[2], env)
  when "*"
    evoluate(tree[1], env) * evoluate(tree[2], env)
  when "**"
    evoluate(tree[1], env) ** evoluate(tree[2], env)
  when "/"
    evoluate(tree[1], env) / evoluate(tree[2], env)
  when "%"
    evoluate(tree[1], env) % evoluate(tree[2], env)
  when "=="
    evoluate(tree[1], env) == evoluate(tree[2], env)
  when ">"
    evoluate(tree[1], env) > evoluate(tree[2], env)
  when "<"
    evoluate(tree[1], env) < evoluate(tree[2], env)
  when "func_call"
    p(evoluate(tree[2], env))
  when "var_assign"
    env[tree[1]] = evoluate(tree[2], env)
  when "var_ref"
    env[tree[1]]
  when "stmts"
    i = 1
    while tree[i] != nil
      last = evoluate(tree[i], env)
      i += 1
    end
    last
  when "if"
    if evoluate(tree[1], env)
      evoluate(tree[2], env)
    else
      evoluate(tree[3], env)
    end
  when "while"
    while evoluate(tree[1], env)
      evoluate(tree[2], env)
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
env = {}
evoluate(tree, env)
