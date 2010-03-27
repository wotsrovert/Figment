Factory.define :location do |f|
    f.name { Factory.next( :location_name )}
end

Factory.define :artist do |a|
    a.biography        'Born in London'
    a.names_list       'Homer, Marge, Bart, Lisa, Maggie'
    a.website          'http://www.thesimpsons.com'
    a.group_email      'members@simpsons.com'
    a.contact_name     'Trevor Stow'
    a.public_name      'T-Man Collective'
    a.contact_phone    '917.499.0583'
    a.contact_email    'trevorstow@gmail.com'
    a.is_organization  '1'
end

Factory.define :project do |p|
    p.title       "Factory Project"
    p.description "Something standard from the factory"
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
    u.is_artist             true
end

Factory.sequence :email do |n|
    "some_onexx#{n}@example.com"
end

Factory.sequence :location_name do |n|
    "The Beach #{n}"
end
