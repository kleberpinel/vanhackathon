class SearchController < ApplicationController
  
  def index
    render json: SearchService.new(params[:q]).find
  end

  def turtles
    render json: { message: 
      "Thurtles are here to rock in Vanckathon! https://github.com/kleberpinel/vanhackathon" 
    }
  end
end
