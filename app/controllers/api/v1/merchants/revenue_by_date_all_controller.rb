class Api::V1::Merchants::RevenueByDateAllController < ApplicationController

  def show
    render json: Merchant.total_revenue_for_date(params[:date]), serializer: TotalRevenueSerializer
  end

end
