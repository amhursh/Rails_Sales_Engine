class Api::V1::Invoices::InvoiceItemsController < ApplicationController

  def index
    invoice_items = Invoice.find(params[:id]).invoice_items
    render json: invoice_items
  end

end
