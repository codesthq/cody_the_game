class SummaryController < ApplicationController
  def show
  end

  def update
    current_session.email = params[:email]
    if current_session.save
      @show_success = true
      render :show
    else
      @message = "Your email is not valid"
      render :show
    end
  end
end
