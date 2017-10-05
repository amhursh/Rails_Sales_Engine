class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    (object / 100.0).to_s
  end
end
