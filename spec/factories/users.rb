FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :teacher do
      after(:build) do |user|
        user.teacher_profile = create(:teacher_profile)
      end
    end

    trait :student do
      after(:build) do |user|
        user.student_profile = create(:student_profile)
      end
    end
  end
end
