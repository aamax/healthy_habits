# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "MyString"
    description "MyText"
    amount 1.5
    product_id "MyString"
    active false
    partial "MyString"
  end
end
