class Api::V1::Merchants::RevenueByDateController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: merchant.revenue_by_date(params[:date]), serializer: TotalRevenueSerializer
  end

end
