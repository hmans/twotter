FactoryBot.define do
  factory :post do
    user { User.last }
    body { FFaker::Lorem.paragraph.truncate(250) }
  end
end
