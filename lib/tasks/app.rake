namespace :integration do
   desc "Generate static HTML source pages for the integration tests to run in browser"
   task :generate do
       host = 'http://localhost:3000'

       Dir.glob( 'app/views/integration/*' ).each do |f|
           filename = f.split('/').last.gsub('.html.haml', '')
           cmd      = "curl #{ host }/integration/#{ filename } > integration/#{ filename.camelcase }.html"
           puts cmd
           `#{ cmd }`
       end
   end
end