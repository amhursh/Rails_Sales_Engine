class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    items = Invoice.find(params[:id]).items
    render json: items
  end

end
