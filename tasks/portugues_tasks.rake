desc "Generate documentation for Brazilian Rails plugins"
namespace :gerar_doc do
  namespace :plugins do
    plugin = 'brazilian-rails'
    task(plugin => :environment) do
      plugin_base   = "vendor/plugins/#{plugin}"
      options       = []
      files         = Rake::FileList.new
      options << "-o #{plugin_base}/doc/api"
      options << "--title '#{plugin.titlecase} Plugin Documentation'"
      options << '--line-numbers' << '--inline-source'
      options << '-T html'
      options << '--charset UTF8'
      options << '--all'
      options << '-U'
  
      files.include("#{plugin_base}/lib/**/*.rb")
      if File.exists?("#{plugin_base}/README")
        files.include("#{plugin_base}/README")    
        options << "--main '#{plugin_base}/README'"
      end
      files.include("#{plugin_base}/CHANGELOG") if File.exists?("#{plugin_base}/CHANGELOG")
  
      options << files.to_s
  
      sh %(rdoc #{options * ' '})
    end
  end
end
