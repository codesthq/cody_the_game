class LevelController < ApplicationController
  layout false
  
  def show
    @omg = params[:level]
  end
end
