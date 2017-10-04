class Api::V1::Invoices::CustomerController < ApplicationController

  def index
    customer = Invoice.find(params[:id]).customer
    render json: customer
  end

end
