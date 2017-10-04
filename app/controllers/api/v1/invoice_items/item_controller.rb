class Api::V1::InvoiceItems::ItemController < ApplicationController

  def index
    item = InvoiceItem.find(params[:id]).item
    render json: item
  end

end
