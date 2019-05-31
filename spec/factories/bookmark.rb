FactoryBot.define do
  factory :bookmark do
    user
    achievement
    status { :locked }
  end
end
