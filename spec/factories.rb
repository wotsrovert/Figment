Factory.define :location do |f|
    f.name { Factory.next( :location_name )}
end

Factory.define :artist do |a|
    a.contact_email                 { Factory.next(:email) }
    a.public_name   "AwesomeSausome"
    a.contact_name  "Mr. Fantasticulous"
    a.contact_phone "917-555-4325"
end

Factory.define :curator, :class => 'user' do |u|
    u.email                 { Factory.next(:email) }
    u.name                  "Some Curator"
    u.password              '123123'
    u.password_confirmation '123123'
    u.terms                 '1'
    u.is_curator true
end

Factory.define :user do |u|
    u.email                 { Factory.next(:email) }
    u.name            "My Self"
    u.password              '123123'
    u.password_confirmation '123123'
    u.terms                 '1'
end

Factory.sequence :email do |n|
    "some_onexx#{n}@example.com"
end

Factory.sequence :location_name do |n|
    "The Beach #{n}"
end
