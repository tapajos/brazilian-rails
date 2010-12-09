PROJECTS = %w(brnumeros brdinheiro brcep brdata brhelper brstring brcpfcnpj)

PROJECTS.each do |project|
  require "#{project}/rails/init"
end
