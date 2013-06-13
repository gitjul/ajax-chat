# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    nick "MyString"
    message "MyText"
  end
end
