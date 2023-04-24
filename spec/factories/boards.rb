FactoryBot.define do
    factory :board do
        sequence(:title) { |n| "testboard-#{n.to_s.rjust(3, "0")}" }
    end
  end