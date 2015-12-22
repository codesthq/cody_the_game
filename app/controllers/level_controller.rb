class LevelController < ApplicationController
  layout false
  
  def show
    @level = params[:level]
  end
end
