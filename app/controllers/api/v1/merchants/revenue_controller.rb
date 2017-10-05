class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: { "revenue" => Merchant.find(params[:id]).revenue }
  end

end
