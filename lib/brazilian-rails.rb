PROJECTS = %w(brdinheiro brcep brdata brhelper brnumeros brstring brcpfcnpj)

PROJECTS.each do |project|
  require File.dirname(__FILE__) + "/../#{project}/lib/#{project}"
end

