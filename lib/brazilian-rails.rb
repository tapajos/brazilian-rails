PROJECTS = %w(brdinheiro brcep brdata brhelper brnumeros brstring brcpfcnpj)

PROJECTS.each do |project|
  require File.expand_path("../../#{project}/lib/#{project}.rb", __FILE__)
end

