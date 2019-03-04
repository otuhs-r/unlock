FactoryBot.define do
  factory :achievement do
    title { 'test_title' }

    trait :invalid do
      title { nil }
    end
  end

  factory :marriage, class: Achievement do
    title { 'Marriage' }
  end

  factory :childbirth, class: Achievement do
    title { 'Childbirth' }
  end
end
