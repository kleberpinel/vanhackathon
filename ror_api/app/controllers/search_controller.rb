class SearchsController < ApplicationController
  
  def index
    @field = params[:field]

    render json: @merchants
  end
end
