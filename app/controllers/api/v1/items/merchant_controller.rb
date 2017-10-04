class Api::V1::Items::MerchantController < ApplicationController

  def index
    merchant = Item.find(params[:id]).merchant
    render json: merchant
  end

end
