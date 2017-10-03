FactoryGirl.define do
  factory :item do

    sequence :name do |i|
      "Item#{i}"
    end

    sequence :description do |i|
      "Description#{i}"
    end

    unit_price {rand(1000)}

    merchant
    
  end
end
