FactoryBot.define do
  factory :hst, class: 'Hsts' do
    user nil
    token "MyString"
  end
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
