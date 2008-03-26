puts File.expand_path(File.dirname(__FILE__))

task :generate_doc do
  plugin_path = File.expand_path(File.dirname(__FILE__) + "/..")
  bin_path = "#{plugin_path}/bin"
  doc_path = "#{plugin_path}/doc"
  sh "chmod +x #{bin_path}/bluecloth"
  sh "#{bin_path}/bluecloth #{doc_path}/index.text > #{doc_path}/index.html"
  
  index = File.read("#{doc_path}/index.html")
  index.gsub!(/<html>/, 
    %{<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
      <html xmlns="http://www.w3.org/1999/xhtml">
    })

  index.gsub!(/<head>(.*?)<\/head>/, 
    %{<head>
        <title>Brazilian Rails</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="stylesheet" href="stylesheets/screen.css" type="text/css" media="screen" />
      </head>
    })
  
  index.gsub!(/<\/body>/, 
      %{
        <script type="text/javascript">
        var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
        document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
        </script>
        <script type="text/javascript">
        var pageTracker = _gat._getTracker("UA-3959259-1");
        pageTracker._initData();
        pageTracker._trackPageview();
        </script>
        </body>
        })
  
  File.open("#{doc_path}/index.html", 'w+') do |index_file|
    index_file << index
  end
end
