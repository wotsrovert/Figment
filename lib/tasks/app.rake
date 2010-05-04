namespace :integration do
   desc "Generate static HTML source pages for the integration tests to run in browser"
   task :generate do
       # host = 'http://dev.figment.com/'
       host = 'http://localhost:3000'

       Dir.glob( 'app/views/integration/*' ).each do |f|
           filename = f.split('/').last.gsub('.html.haml', '')
           `curl #{ host }/integration/#{ filename } > integration/#{ filename }.html`
       end
   end
end