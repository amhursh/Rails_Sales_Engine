class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    (object / 100.0).to_s
  end
end
