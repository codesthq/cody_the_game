class MenuController < ApplicationController
  def show
    @max_level = current_session.max_level
  end
end
