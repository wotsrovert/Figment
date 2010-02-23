Factory.define :location do |f|
    f.name "The Beach"
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
