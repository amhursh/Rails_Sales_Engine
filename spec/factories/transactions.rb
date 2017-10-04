FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number "ccnum"
    credit_card_expiration_date "ccexp"
    result "success"
  end
end
