# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#


Category.create( :name => "Sculpture" )
Category.create( :name => "Multi-Media" )
Category.create( :name => "Interactive" )
Category.create( :name => "Dance" )
Category.create( :name => "Performance" )
Category.create( :name => "Music" )

Location.create( :name => "Pavillion" )
Location.create( :name => "Main Stage" )
Location.create( :name => "Nolan Park" )
Location.create( :name => "Colonels' Row" )

User.create( 
    :email                 => 'trevorstow@gmail.com', 
    :name                  => "Trevor Stow", 
    :password              => '123123', 
    :password_confirmation => '123123',
    :role                  => User::ADMIN 
)
User.create( 
    :email                 => 'balktick@gmail.com',
    :name                  => "Kevin Balktick",
    :password              => '123123',
    :password_confirmation => '123123',
    :role                  => User::ADMIN 
)
User.create( 
    :email                 => 'audrey.boguchwal@gmail.com',
    :name                  => "Audrey Boguchwal",
    :password              => '123123',
    :password_confirmation => '123123',
    :role                  => User::ADMIN 
)


