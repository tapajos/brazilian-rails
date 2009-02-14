PROJECTS = %w(brdinheiro brcep brdata brhelper brnumeros brstring brcpfcnpj)

PROJECTS.each do |project|
  require project
end

