FactoryBot.define do
  factory :post do
    user { User.last }
    body { FFaker::Lorem.sentence }
  end
end
