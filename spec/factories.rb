FactoryBot.define do
  factory :tracked_session do
    session_cookie "MyString"
    first_party_cookie nil
    localstorage nil
    hsts nil
  end
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
