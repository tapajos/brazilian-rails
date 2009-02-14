PROJECTS = %w(brnumeros brdinheiro brcep brdata brhelper brstring brcpfcnpj)

PROJECTS.each do |project|
  require "#{File.dirname(__FILE__)}/#{project}/rails/init"
end
