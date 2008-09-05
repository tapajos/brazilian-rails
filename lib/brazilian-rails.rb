PROJECTS = %w(brdinheiro brcep brdata brhelper brtraducao brnumeros brstring)

PROJECTS.each do |project|
  require project
end

