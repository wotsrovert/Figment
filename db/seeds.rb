# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

User.create( :email => 'trevorstow@gmail.com', :name => "Trevor Stow", :password => '123123', :password_confirmation => '123123' )
User.create( :email => 'balktick@gmail.com', :name => "Kevin Balktick", :password => '123123', :password_confirmation => '123123' )
