ActionController::Routing::Routes.draw do |map|

    map.with_options( :controller => 'session' ) do |sess|
        sess.login      '/login', :action => 'login', :conditions => {:method => :get }
        sess.connect    '/login', :action => 'login_post', :conditions => {:method => :post }
        sess.login_as   '/login_as/:id', :action => 'login_as', :id => /\d+/
        sess.logout     '/logout', :action => 'logout'
    end

    # ===========
    # = account =
    # ===========
    map.with_options( :controller => 'account' ) do |acc|
        acc.signup '/account/new', :action => 'new'
    end
    map.resource :account, :controller => 'account'

    # =============
    # = passwords =
    # =============
    map.resource :password, :controller => 'password'
    map.with_options( :controller => 'password', :path_prefix => '/password' ) do |p|
        p.reset_password    '/edit/:anonymous_login_code'   , :action => 'edit_by_anonymous_login_code',    :conditions => { :method => :get }
        p.connect           '/deliver'                      , :action => 'deliver',                         :conditions => { :method => :post }
        p.forgot_password   '/'                             , :action => 'show',                            :conditions => { :method => :get }
        p.edit_password     '/edit'                         , :action => 'edit',                            :conditions => { :method => :get }
        p.connect           '/sent'                         , :action => 'sent'
    end

    # ===========
    # = artists =
    # ===========
    map.resources :artists, :shallow => true do |artist|
        artist.resources :projects, :only => [ :new, :index ]
    end

    # ============
    # = projects =
    # ============
    map.resources :categories
    map.resources :locations
    map.resources :submissions, :except => [:destroy], :member => { :thank_you => :get } do |sub|
        sub.resources :programs, :controller => 'submission_programs', :except => [:show]
    end
    map.connect '/projects/:id/edit/:section', :controller => 'projects', :action => 'edit', :id => /\d+/, :section => Regexp.new( Project::SECTIONS.join('|') )
    map.resources :projects, :only => [:index, :show, :edit, :update, :destroy], :shallow => true do |project|
        project.resources :programs
    end
    
    # ============
    # = curators =
    # ============
    map.resources :curators
    
    # ========
    # = misc =
    # ========
    map.with_options( :controller => 'errors', :path_prefix => '/errors' ) do |errs|
        errs.connect '/500',            :action => 'internal_error'
        errs.connect '/404',            :action => 'not_found'
        errs.connect '/422',            :action => 'unprocessable'
    end

    map.root :controller => 'welcome'
end
