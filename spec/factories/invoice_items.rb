FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity 1
    unit_price 1000
  end
end
