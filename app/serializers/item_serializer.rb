class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :merchant_id, :description, :unit_price

  def unit_price
    (object.unit_price / 100.0).to_s
  end
end
