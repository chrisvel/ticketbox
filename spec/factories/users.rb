FactoryGirl.define do

  factory :user, class: User do
    id 1
    firstname 'John'
    lastname 'Murdock'
    email 'someone@somewhere.com'
    password '12345678'
    password_confirmation '12345678'
    created_at 2.days.ago
    updated_at 1.minute.ago
  end

  factory :peter, class: User do
    id 2
    firstname 'Peter'
    lastname 'Florrick'
    email 'pflorrick@tgw.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :jack, class: User do
    id 3
    firstname 'Jack'
    lastname 'Bauer'
    email 'jack.b@ctu.com'
    password '12qw12qw12'
    password_confirmation '12qw12qw12'
  end

end
