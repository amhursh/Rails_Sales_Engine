class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: { "total" => Merchant.total_revenue_for_date(params[:date]) }
  end

end