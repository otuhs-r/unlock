FactoryBot.define do
  factory :tag, class: ActsAsTaggableOn::Tag do
    name { 'test_tag' }
  end
end
