class Api::V1::Merchants::PendingCustomersController < ApplicationController

  def index
    merchant = Merchant.find(params[:id])
    render json: merchant.customers_with_pending_invoices
  end

end