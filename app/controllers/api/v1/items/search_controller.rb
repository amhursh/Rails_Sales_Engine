class Api::V1::Items::SearchController < ApplicationController

  def show
    render json: Item.all.order(:id).find_by(item_params)
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

end