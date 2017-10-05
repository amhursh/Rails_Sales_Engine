class ApplicationController < ActionController::API

  before_action :convert_unit_price

  def convert_unit_price
    if params[:unit_price]
      params[:unit_price] = (params[:unit_price].to_f * 100).round.to_s
    end  
  end

end
