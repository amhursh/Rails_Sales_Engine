class Api::V1::Merchants::TopRevenueController < ApplicationController

  def index
    render json: Merchant.most_revenue(params[:quantity])
  end

end