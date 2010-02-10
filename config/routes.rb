ActionController::Routing::Routes.draw do |map|

    map.with_options( :controller => 'account' ) do |acc|
        acc.signup '/account/new', :action => 'new'
        acc.forgot_password '/forgot_password', :action => 'forgot_password'
    end
    map.resource :account, :controller => 'account'

    map.resources :artists
    map.resources :curators
    
    map.with_options( :controller => 'session' ) do |sess|
        sess.login '/login', :action => 'login', :conditions => {:method => :get }
        sess.connect '/login', :action => 'login_post', :conditions => {:method => :post }
        sess.login_as '/login_as/:id', :action => 'login_as', :id => /\d+/
        sess.logout '/logout', :action => 'logout'
    end
    
    map.with_options( :controller => 'projects' ) do |project|
        project.submission '/submission', :action => 'new', :conditions => { :method => :get }
        project.thank_you '/submission/thank_you', :action => 'thank_you', :conditions => { :method => :get }
    end
    map.resources :projects

    map.root :controller => 'welcome'
end
