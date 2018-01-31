FactoryBot.define do
  factory :local_storage do
    token "MyText"
    user nil
  end

  factory :user do
    email                   { Faker::Internet.email }
    password                "password"
    password_confirmation   "password"
  end

end
