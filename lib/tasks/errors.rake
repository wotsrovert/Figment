namespace :errors do
   desc "Generate static error pages" 
   task :generate_page do
       path = 'http://dev.figment.com/errors'
       
       `curl #{ path }/500 > public/500.html`
       `curl #{ path }/422 > public/422.html`
       `curl #{ path }/404 > public/404.html`

   end
end