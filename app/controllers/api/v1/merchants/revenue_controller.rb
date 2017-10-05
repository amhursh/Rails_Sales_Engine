class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    if params[:date]
      render json: { "revenue" => Merchant.find(params[:id]).revenue_by_date(params[:date]) }
    else
      render json: { "revenue" => Merchant.find(params[:id]).revenue }
    end
  end

end
