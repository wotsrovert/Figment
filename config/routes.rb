ActionController::Routing::Routes.draw do |map|

    map.with_options( :controller => 'projects' ) do |project|
        project.submission '/submission', :action => 'new', :conditions => { :method => :get }
    end
    map.resources :projects

    map.root :controller => 'welcome'
end
