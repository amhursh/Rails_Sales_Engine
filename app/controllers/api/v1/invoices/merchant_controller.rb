class Api::V1::Invoices::MerchantController < ApplicationController

  def index
    merchant = Invoice.find(params[:id]).merchant
    render json: merchant
  end

end
