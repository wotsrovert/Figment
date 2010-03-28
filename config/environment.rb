RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
    # Specify gems that this application depends on and have them installed with rake gems:install
    config.gem 'will_paginate', '>= 2.3.12'
    config.gem 'paperclip', :source => 'http://gemcutter.org'
    config.gem 'hoptoad_notifier'

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'Eastern Time (US & Canada)'
end