class MenuController < ApplicationController
  def show
    @current_level = current_session.current_level
  end
end
