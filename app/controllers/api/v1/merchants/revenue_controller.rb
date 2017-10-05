class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    if params[:date]
      render json: Merchant.find(params[:id]).revenue_by_date(params[:date]), serializer: RevenueSerializer
    else
      render json: Merchant.find(params[:id]).revenue, serializer: RevenueSerializer
    end
  end

end
