PROJECTS = %w(brdinheiro brcep brdata brhelper brtraducao brnumeros brstring brcpfcnpj)

PROJECTS.each do |project|
  require project
end

