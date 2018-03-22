require 'minruby'


def evoluate(tree)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    evoluate(tree[1]) + evoluate(tree[2])
  when "-"
    evoluate(tree[1]) - evoluate(tree[2])
  when "*"
    evoluate(tree[1]) * evoluate(tree[2])
  when "**"
    evoluate(tree[1]) ** evoluate(tree[2])
  when "/"
    evoluate(tree[1]) / evoluate(tree[2])
  when "%"
    evoluate(tree[1]) % evoluate(tree[2])
  when "=="
    evoluate(tree[1]) == evoluate(tree[2])
  when ">"
    evoluate(tree[1]) > evoluate(tree[2])
  when "<"
    evoluate(tree[1]) < evoluate(tree[2])
  when "func_call"
    p(evoluate(tree[2]))
  when "stmts"
    i = 1
    while tree[i] != nil
      last = evoluate(tree[i])
      i += 1
    end
    last
  else
    "no support operand: #{tree[0]}"
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
evoluate(tree)
