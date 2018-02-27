FactoryBot.define do
  factory :hpkp do
    token "MyString"
  end
  factory :etag do
    user nil
    token "MyString"
  end
  factory :tracked_session_hsts_entry do
    tracked_session nil
    url_index 1
  end
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
