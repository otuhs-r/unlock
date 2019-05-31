FactoryBot.define do
  factory :user do
    nickname { 'test_user' }
    image_url { 'test_image.png' }
  end

  factory :another_user, class: User do
    nickname { 'another_test_user' }
    image_url { 'another_test_image.png' }
  end
end
