require 'minruby'


def evoluate(tree, genv, lenv)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
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
  when "!="
    evoluate(tree[1], genv, lenv) != evoluate(tree[2], genv, lenv)
  when ">"
    evoluate(tree[1], genv, lenv) > evoluate(tree[2], genv, lenv)
  when ">="
    evoluate(tree[1], genv, lenv) >= evoluate(tree[2], genv, lenv)
  when "<"
    evoluate(tree[1], genv, lenv) < evoluate(tree[2], genv, lenv)
  when "<="
    evoluate(tree[1], genv, lenv) <= evoluate(tree[2], genv, lenv)
  when "func_def"
    genv[tree[1]] = ['user_defined', tree[2], tree[3]]
  when "func_call"
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evoluate(tree[i + 2], genv, lenv)
      i = i + 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == 'builtin'
      minruby_call(mhd[1], args)
    else
      new_lenv = {}
      params = mhd[1]
      i = 0
      while params[i]
        new_lenv[params[i]] = args[i]
        i = i + 1
      end
      evoluate(mhd[2], genv, new_lenv)
    end
  when "var_assign"
    lenv[tree[1]] = evoluate(tree[2], genv, lenv)
  when "var_ref"
    lenv[tree[1]]
  when "stmts"
    i = 1
    last = nil
    while tree[i] != nil
      last = evoluate(tree[i], genv, lenv)
      i = i + 1
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
  when "ary_assign"
    var = evoluate(tree[1], genv, lenv)
    index = evoluate(tree[2], genv, lenv)
    var[index] = evoluate(tree[3], genv, lenv)
  when "hash_new"
    hsh = {}
    i = 0
    while tree[i + 1]
      key = evoluate(tree[i + 1], genv, lenv)
      value = evoluate(tree[i + 2], genv, lenv)
      hsh[key] = value
      i = i + 2
    end
    hsh
  when "hash_ref"
    var = evoluate(tree[1], genv, lenv)
    key = evoluate(tree[2], genv, lenv)
    var[key]
  else
    "no support operand: #{tree[0]}"
  end
end

tree = minruby_parse(minruby_load())
genv = {
  'p' => ['builtin', 'p'],
  'require' => ['builtin', 'require'],
  'minruby_parse' => ['builtin', 'minruby_parse'],
  'minruby_call' => ['builtin', 'minruby_call'],
  'minruby_load' => ['builtin', 'minruby_load'],
}
lenv = {}
evoluate(tree, genv, lenv)
