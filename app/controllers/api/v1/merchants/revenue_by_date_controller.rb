class Api::V1::Merchants::RevenueByDateController < ApplicationController

  def show
    binding.pry
    render json: { "revenue" => Merchant.find(params[:id]).revenue_by_date(params[:date]) }
  end

end
