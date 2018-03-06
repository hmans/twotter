FactoryBot.define do
  factory :user do
    name      { |u| u.full_name.parameterize }
    full_name { FFaker::Name.name }
    email     { |u| FFaker::Internet.email(u.full_name) }
    password  'secret'
  end
end
