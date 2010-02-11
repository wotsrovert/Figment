ActionController::Routing::Routes.draw do |map|

    map.with_options( :controller => 'session' ) do |sess|
        sess.login '/login', :action => 'login', :conditions => {:method => :get }
        sess.connect '/login', :action => 'login_post', :conditions => {:method => :post }
        sess.login_as '/login_as/:id', :action => 'login_as', :id => /\d+/
        sess.logout '/logout', :action => 'logout'
    end
    map.with_options( :controller => 'account' ) do |acc|
        acc.signup '/account/new', :action => 'new'
        acc.forgot_password '/forgot_password', :action => 'forgot_password'
    end


    map.resource :account, :controller => 'account'
    map.with_options( :controller => 'projects' ) do |project|
        project.with_options( :conditions => { :method => :get } ) do |get|
            get.thank_you  '/submission/thank_you', :action => 'thank_you'
            get.connect    '/submission/:artist_id', :action => 'new'
            get.submission '/submission', :action => 'new'

        end
    end
    map.resources :artists, :shallow => true do |artist|
        artist.resources :projects, :only => [ :new, :index ]
    end
    map.resources :projects
    map.resources :curators
    

    map.root :controller => 'welcome'
end
