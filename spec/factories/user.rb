FactoryBot.define do
    pass = Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false)
    factory :user, aliases: [:following] do
        service_id            { Faker::Internet.username(specifier: 6)}
        username              { Faker::Name.name }
        email                 { Faker::Internet.email }
        password              { pass }
        password_confirmation { pass }
    end

    factory :testuser, class: User, aliases: [:follower] do
        service_id            { Faker::Internet.username(specifier: 6)}
        username              { Faker::Name.name }
        email                 { Faker::Internet.email }
        password              { pass }
        password_confirmation { pass }
    end

end