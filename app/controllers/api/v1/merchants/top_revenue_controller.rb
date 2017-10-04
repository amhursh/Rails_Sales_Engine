class Api::V1::Merchants::TopRevenueController < ApplicationController

  def index
    render json: { "most_revenue" => Merchant.most_revenue(params[:quantity]) }
  end

end